# Project status

## Design
- [x] Mixed weapon pack concept agreed: ballistic, industrial, chemical, elemental and energy weapons
- [x] Twelve weapon concepts defined
- [x] Primary and alternate fire described for all twelve
- [x] First-pass numerical target sheet populated (unbalanced, pending comparison to vanilla)
- [x] JSON validator added
- [x] Windows read-only game-manifest collector added

## Technical research
- [x] Identified RCMM Blueprint integration pattern: `Content/_RCMods/RCMod_*`, `BPI_RCMod`, `OnInitialise`
- [x] Identified latest public patch reference checked: RC:EA:03:04:00, build 26783375 (2026-11-19)
- [ ] Confirm local game build and exact Unreal Engine version
- [ ] Obtain and inspect game package metadata/dumps from the local install
- [ ] Confirm legal, distributable loader route for a one-click Melty release
- [ ] Map real weapon base classes, registration hooks, salvage/unlock pools and Workbench hooks
- [ ] Map replication behavior and test host/client behavior

## Build
- [ ] Create real Unreal Blueprint assets in a compatible editor project
- [ ] Implement and test Arc Conductor vertical slice
- [ ] Implement remaining eleven weapons from the verified pattern
- [ ] Create final meshes, animations, materials, sounds, effects and UI icons
- [ ] Package .pak and inspect its contents
- [ ] Test on the target game build with host and client
- [ ] Capture genuine gameplay media
- [ ] Validate the Melty one-click recipe and complete release test

**Current state:** design and tooling scaffold only. No compiled Blueprint assets, .pak, or playable build exists yet. The current session cannot access the user's installed game directory, and Melty's MCP endpoint was unreachable from the execution environment (DNS lookup failed). Do not describe the project as a working mod until the build and tests above pass.


## Local machine report (2026-11-20)
- [x] Identified local Steam build: 26783375
- [x] Identified executable CL: Live-CL-165890
- [x] Confirmed the report lists the main RogueCore-Windows.pak
- [ ] Correct the malformed package CSV / collect the missing game-log tail
- [ ] Check for Unreal Editor 5.6.1 and UnrealPak tool on the user's PC
- [ ] Confirm a loader compatible with Update 3 and compatible with Melty one-click distribution
- [ ] Inspect real ItemData, Reclaimer weapon classes, unlock collections, and replication hooks

See [LOCAL_INSTALL_FINDINGS.md](docs/LOCAL_INSTALL_FINDINGS.md) and [WEAPON_INTEGRATION.md](docs/WEAPON_INTEGRATION.md).
