# Research notes

Last researched: 2026-11-20

- The RCMM integration guide documents `_IRCMod`, `Content/_RCMods/`, the `RCMod_` entry name, `BPI_RCMod`, and the `OnInitialise` lifecycle event: https://github.com/HatsuEcho/RC-RogueCore-Mod-Manager
- A public mod page describes Mod Hub as a Blueprint mod framework and specifies placement of its `ModHub_P.pak` in `RogueCore/Content/Paks`: https://www.nexusmods.com/deeprockgalacticroguecore/mods/3
- The Mod Hub page states that its file may not be uploaded to other sites. This project does not bundle it.
- SteamDB lists Rogue Core build 26783375 for patch RC:EA:03:04:00 dated 2026-11-19: https://steamdb.info/patchnotes/26783375/. This is a public version reference only; it does not prove the user's local install is on that build.
- A community mod, “Four Weapon Choices at the Workbench”, changes the number of choices, not the actual weapon roster: https://www.nexusmods.com/deeprockgalacticroguecore/mods/129

## Limitations

The current session cannot read the user's local game directory or reach Melty's MCP endpoint. The local manifest script is provided to collect non-content metadata for the next implementation step. No game assets are included here.
