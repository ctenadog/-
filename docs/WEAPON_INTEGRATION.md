# Weapon integration research

This is a research note, not a claim that the listed classes have already been verified against the user's local game build.

## Asset Manager configuration

A publicly available Rogue Core reverse-engineering project contains a `DefaultGame.ini` snapshot with these asset scans:

| Primary Asset Type | Base class | Scanned content directories |
|---|---|---|
| `ItemData` | `/Script/RogueCore.ItemData` | `/Game/WeaponsNTools`, `/Game/GameElements/Drone`, `/Game/Unlocks/Items` |
| `BXEUnlockCollection` | `/Script/RogueCore.BXEUnlockCollection` | `/Game/Unlocks/Collections`, `/Game/Unlocks/Collections/WeaponsToolsGear`, `/Game/Character/Reclaimers/BoosterDecks`, `/Game/GameElements/Abilities/DataAssets` |
| `BXEUnlockBase` | `/Script/RogueCore.BXEUnlockBase` | `/Game/Unlocks/DataAssets`, `/Game/Unlocks/Artifacts` |
| `DamageClass` | `/Script/RogueCore.DamageClass` | `/Game/GameElements/Damage` |

Source: https://github.com/raffel080108/MOTD/blob/6f52137347ea4c1d6345037bf43ffbf6863931cd/assets/RogueCore/Config/DefaultGame.ini

The same configuration snapshot reports `ProjectVersion=0.4.142510.0`. It is a community project snapshot, not proof of the local executable's project version.

## What this changes

New weapons must be built as real Rogue Core item data and associated weapon/actor assets, then made discoverable through the game's supported asset and unlock/loadout flow. A cosmetic actor spawned from an RCMM entry alone is not enough to add a usable Reclaimer weapon to the actual weapon selection system.

## Required inspection before implementation

1. Identify the concrete ItemData assets and their parent weapon classes in the local game build.
2. Identify how weapon data points to the held weapon actor, projectile/hitscan logic, animation, effects, sound, icon, and upgrade definitions.
3. Identify how Reclaimer loadout selection and salvage/unlock pools query ItemData/BXEUnlockCollection.
4. Confirm multiplayer authority/replication for firing, projectiles, damage, and status effects.
5. Confirm the chosen loader is compatible with build 26783375 and can be installed by Melty in one click.

Until these references are resolved, weapon entries in `weapon_sheet.json` remain design rows, not a buildable asset manifest.
