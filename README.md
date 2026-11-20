# Rock & Load: Expanded Reclaimer Arsenal

**Twelve new ways to make Hoxxes regret waking up.**

A mixed-style weapon pack concept for **Deep Rock Galactic: Rogue Core**. The first planned release contains twelve original Reclaimer weapons across ballistic, industrial, chemical, elemental and energy families.

> **Status: design/tooling scaffold — not a playable mod yet.** No compiled Blueprint assets or `.pak` are included. See [PROJECT_STATUS.md](PROJECT_STATUS.md).

## Weapon roster

| # | Weapon | Combat identity |
|---:|---|---|
| 1 | Arc Conductor | Chain-lightning carbine and charged pulse |
| 2 | Cryo Needle | Precision cryo darts and piercing ice shard |
| 3 | Rail Splitter | Charged armor-piercing railgun |
| 4 | Rotary Shredder | Spin-up rotary cannon with overdrive |
| 5 | Rivet Storm | Pneumatic rivets with manual detonation |
| 6 | Acid Injector | Corrosive precision injector and three-needle fan |
| 7 | Magnetar Disc | Ricocheting magnetic disc with early recall |
| 8 | Seismic Projector | Staggering shockwave and focused impact line |
| 9 | Gravity Well Launcher | Enemy-pulling field and early implosion |
| 10 | Thermal Lance | Continuous heat beam and vent burst |
| 11 | Magma Mortar | Thermal area-denial shell and impact slug |
| 12 | Bore-Drill Cannon | Piercing drill projectile and return pass |

## First-minute loop

Choose a weapon, enter the first cave encounter, and test its primary and alternate fire against the opening enemy group. The target game mode is the game's native co-op PvE loop (1–4 players); multiplayer behavior of this mod has not been tested.

## Project files

- [weapon_sheet.json](weapon_sheet.json) — source-of-truth concept data and first-pass stat targets.
- [tools/validate_weapon_sheet.py](tools/validate_weapon_sheet.py) — no-dependency design-sheet validator.
- [tools/collect_game_manifest.ps1](tools/collect_game_manifest.ps1) — read-only Windows helper that finds Rogue Core's Steam install and records build/executable/PAK metadata. It does not copy game assets.
- [docs/IMPLEMENTATION.md](docs/IMPLEMENTATION.md) — integration route, first playable milestone and build gates.
- [docs/RESEARCH_NOTES.md](docs/RESEARCH_NOTES.md) — external technical references.

## Validation

```powershell
python tools/validate_weapon_sheet.py weapon_sheet.json
```

For a strict check that refuses to clear implementation while game paths/hooks remain unresolved:

```powershell
python tools/validate_weapon_sheet.py weapon_sheet.json --require-integration
```

## Credits and permissions

All weapon names and gameplay concepts in this draft are original proposals. No third-party game assets, loader binaries or interface .uasset files are included. Final code/art/audio license and remix permissions remain to be decided by the creator. Third-party loader/interface files must be obtained from their publishers and redistributed only where their permissions explicitly allow it.


## Latest local findings
The user's diagnostic identifies build `26783375` / `Live-CL-165890` and the main game PAK. The package CSV was malformed and the log tail/editor-tool inventory is missing. See [local findings](docs/LOCAL_INSTALL_FINDINGS.md) and [weapon integration research](docs/WEAPON_INTEGRATION.md).
