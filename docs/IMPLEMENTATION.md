# Implementation notes

## Current integration route

The currently documented community route for Rogue Core is a Blueprint mod loaded through the RogueCore Mod Manager (RCMM). Its public integration guide says to:

1. Add the manager's `_IRCMod` interface assets to a matching Unreal project.
2. Put the entry Actor under `Content/_RCMods/`.
3. Prefix the entry Blueprint with `RCMod_`.
4. Implement `BPI_RCMod` and provide mod metadata.
5. Start mod logic from the interface's `OnInitialise` event, not ordinary `BeginPlay`.

Source guide: https://github.com/HatsuEcho/RC-RogueCore-Mod-Manager

Do not copy RCMM's `.uasset` interface files into this repository or release until their redistribution permissions are confirmed. The mod authoring project must use interface assets obtained from the original publisher.

## What must be inspected before real weapon assets can be made

The installed game build is the authority. A public version listing is not enough to establish the user's exact local build or engine minor version. Run `tools/collect_game_manifest.ps1` on the Windows PC and add the generated `roguecore-manifest.json` to a private working copy (do not commit personal absolute paths publicly). Then inspect the target build's own packages/dumps and determine:

- the exact Unreal Engine version required by the installed executable;
- whether the chosen loader is compatible with that exact build;
- the game's real Reclaimer weapon base classes and data assets;
- the weapon loadout, unlock, salvage and Workbench registration points;
- how firing, projectile spawning, status effects and damage are replicated to clients;
- the real skeletons, sockets, animations, effects, sounds, icons and material conventions;
- any conflicts with other mods replacing the same assets.

No guessed class names or fake asset paths should be used as implementation dependencies.

## First playable milestone

Do not attempt all twelve weapon implementations simultaneously. The first vertical slice should be `Arc Conductor` only:

1. A real registered weapon entry reachable through the game's normal loadout/salvage flow.
2. A working primary fire using a verified game projectile or hitscan base.
3. Server-authoritative damage and replicated visuals/sounds.
4. A simple alternate discharge only after primary fire is stable.
5. Host and client tests in a two-player session.
6. A packaged `.pak` tested with the same loader and build that players will use.

After this passes, reuse the proven pattern for the remaining eleven weapon rows. The weapon sheet remains the source of truth.

## Loader and publishing caveat

Rogue Core is not configured in Melty's game catalog in the supplied publishing instructions. The public Mod Hub download explicitly prohibits uploading its file to other sites, and the RCMM repository's visible guide does not establish redistribution rights for its interface assets. Therefore neither loader is treated as a distributable Melty dependency yet. Do not promise one-click installation until a self-contained and permission-cleared recipe is validated.

## Multiplayer rule

All world-affecting actions (projectile spawn, hit registration, damage, status effects, explosions, and field creation) must be checked for host/server authority and replicated results. UI-only feedback may remain local. A mod that has only been tested by its host is not described as multiplayer-compatible.

## Known design-only targets

All values in `weapon_sheet.json` are first-pass targets. They are not vanilla-game measurements and are not claimed to be balanced. Reconcile them against actual game values before a gameplay build.
