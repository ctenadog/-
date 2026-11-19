# Read-only diagnostic helper. It does not modify the game or copy game assets.
[CmdletBinding()]
param(
    [string]$GamePath,
    [string]$OutputPath = (Join-Path (Get-Location) 'roguecore-manifest.json')
)
$ErrorActionPreference = 'Stop'
$AppId = '2605790'

function Get-SteamLibraries {
    $roots = @()
    foreach ($key in @('HKCU:\Software\Valve\Steam', 'HKLM:\SOFTWARE\WOW6432Node\Valve\Steam', 'HKLM:\SOFTWARE\Valve\Steam')) {
        try {
            $p = Get-ItemProperty -Path $key -ErrorAction Stop
            if ($p.SteamPath) { $roots += $p.SteamPath }
            if ($p.InstallPath) { $roots += $p.InstallPath }
        } catch { }
    }
    $roots = $roots | Select-Object -Unique
    $libraries = [System.Collections.Generic.List[string]]::new()
    foreach ($root in $roots) {
        if (Test-Path $root) { $libraries.Add($root) }
        $vdf = Join-Path $root 'steamapps\libraryfolders.vdf'
        if (Test-Path $vdf) {
            $raw = Get-Content -LiteralPath $vdf -Raw
            foreach ($match in [regex]::Matches($raw, '"path"\s*"([^"]+)"')) {
                $p = $match.Groups[1].Value -replace '\\\\','\'
                if (Test-Path $p) { $libraries.Add($p) }
            }
        }
    }
    return $libraries | Select-Object -Unique
}

if (-not $GamePath) {
    $possibleNames = @('Deep Rock Galactic RogueCore', 'Deep Rock Galactic Rogue Core', 'Deep Rock Galactic: Rogue Core')
    foreach ($library in (Get-SteamLibraries)) {
        foreach ($name in $possibleNames) {
            $candidate = Join-Path $library (Join-Path 'steamapps\common' $name)
            if (Test-Path $candidate) { $GamePath = $candidate; break }
        }
        if ($GamePath) { break }
    }
}
if (-not $GamePath -or -not (Test-Path $GamePath)) {
    $GamePath = Read-Host 'Enter the full Rogue Core game folder path (Steam > Manage > Browse local files)'
}
if (-not (Test-Path $GamePath)) { throw "Game folder not found: $GamePath" }
$GamePath = (Resolve-Path -LiteralPath $GamePath).Path

$steamapps = Split-Path (Split-Path $GamePath -Parent) -Parent
$manifestPath = Join-Path $steamapps "appmanifest_$AppId.acf"
$buildId = $null
if (Test-Path $manifestPath) {
    $acf = Get-Content -LiteralPath $manifestPath -Raw
    $m = [regex]::Match($acf, '"buildid"\s*"(\d+)"')
    if ($m.Success) { $buildId = $m.Groups[1].Value }
}

$exeCandidates = Get-ChildItem -LiteralPath $GamePath -Filter '*.exe' -Recurse -File -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -match 'RogueCore.*(Shipping)?\.exe$|RogueCore\.exe$' } |
    Select-Object -First 5
$exeInfo = @($exeCandidates | ForEach-Object {
    [pscustomobject]@{
        path = $_.FullName.Substring($GamePath.Length).TrimStart('\')
        fileVersion = $_.VersionInfo.FileVersion
        productVersion = $_.VersionInfo.ProductVersion
        length = $_.Length
    }
})
$paksPath = Join-Path $GamePath 'RogueCore\Content\Paks'
$paks = @()
if (Test-Path $paksPath) {
    $paks = @(Get-ChildItem -LiteralPath $paksPath -File | ForEach-Object {
        [pscustomobject]@{ name = $_.Name; sizeBytes = $_.Length; modifiedUtc = $_.LastWriteTimeUtc.ToString('o') }
    })
}

$result = [ordered]@{
    game = 'Deep Rock Galactic: Rogue Core'
    appId = $AppId
    installPath = $GamePath
    steamBuildId = $buildId
    executableCandidates = $exeInfo
    paksDirectory = $paksPath
    pakFiles = $paks
    generatedUtc = [DateTime]::UtcNow.ToString('o')
    note = 'Metadata only; no copyrighted game assets or personal data are copied.'
}
$result | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath $OutputPath -Encoding UTF8
Write-Host "Manifest written: $OutputPath"
Write-Host "Steam build: $buildId"
Write-Host "Pak files listed: $($paks.Count)"
