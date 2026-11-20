# Local installation findings

Report received: 2026-11-20.

## Confirmed from the user's diagnostic report

- Steam App ID: `2605790`.
- Local Steam build ID: `26783375`.
- Executable product/file version: `Live-CL-165890`.
- The report's build and CL match public patch notes for `RC: EA:03:04:00 + 165890`, dated 19 November 2026: https://steamdb.info/patchnotes/26783375/
- The reported game Paks directory contains the main `RogueCore-Windows.pak` (2,905,517,960 bytes).
- No separate Mod Hub or RCMM loader package was listed in that Paks directory at scan time.
- The report found no running Rogue Core process at scan time.
- The newest discovered `RogueCore.log` was last modified 6 November 2026; its tail was not among the received attachments.

Private local path, machine-specific component details, and executable hashes are intentionally not repeated in this public repository.

## Diagnostic bundle issues

- The submitted `pak_inventory.csv` is malformed: it contains PowerShell collection metadata (`Count`, `Keys`, `Values`) rather than one row per package file. The structured `pakInventory` field in `report.json` is usable and reports the single main `.pak`.
- `latest_game_log_tail.txt` was described by `READ_ME.txt` but was not included in the files received.
- The report does not prove an Unreal Editor installation or the existence of `UnrealPak.exe`.

## Engine and loader research (external, not local confirmation)

- PCGamingWiki lists Unreal Engine 5.6.1 for Rogue Core (verification dated 14 November 2026): https://www.pcgamingwiki.com/wiki/Deep_Rock_Galactic:_Rogue_Core
- The community RCMM source describes a Blueprint entry Actor under `Content/_RCMods/`, prefixed `RCMod_`, implementing `BPI_RCMod` and starting logic in `OnInitialise`: https://github.com/HatsuEcho/RC-RogueCore-Mod-Manager
- Nexus posts for RCMM 1.1.2 include a 5 November 2026 comment saying it needs an update for Update 3. Treat its compatibility with build 26783375 as unverified: https://www.nexusmods.com/deeprockgalacticroguecore/mods/6?tab=posts
- Mod Hub's public page describes Blueprint mod loading, but its permissions say the file may not be uploaded to other sites. Do not bundle its `ModHub_P.pak` in a Melty release without explicit permission: https://www.nexusmods.com/deeprockgalacticroguecore/mods/3

## Current conclusion

The local game version is identified. The game content archive itself was not supplied (and must not be uploaded here). Before compiling a gameplay mod, identify the exact compatible mod loader, the Unreal Editor/build tools, and real Reclaimer item classes/registration hooks. The build is not yet cleared.


## Loader compatibility checked 2026-11-20
- RCMM 1.1.2 was last updated 10 June 2026; its 5 November 2026 pinned comment says it needs an update for Update 3. The user's local build is Update 3.04, so RCMM compatibility is not assumed.
- Mod Hub v1 is described as a Blueprint mod loader, but its Nexus permissions prohibit uploading the Mod Hub file to other sites and require permission for modification/asset use. We will not bundle its files without permission.
- Mod Hub's Blueprint loading approach is documented for mods that do not replace existing game assets. Whether it can register new `ItemData` entries and add them to the real Reclaimer selection flow is still unverified.
- The local Paks inventory contains only the main game PAK; no Mod Hub or RCMM PAK was detected.
