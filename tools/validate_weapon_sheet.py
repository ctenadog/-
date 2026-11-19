#!/usr/bin/env python3
"""Validate the Rock & Load design sheet without third-party dependencies."""
from __future__ import annotations
import argparse
import json
import sys
from pathlib import Path

REQUIRED = {
    "id", "name", "family", "role", "damage_type", "primary_fire",
    "alternate_fire", "prototype_stats", "special_rules", "tradeoff",
    "visual_identity", "audio_identity", "implementation",
}
STAT_KEYS = {"damage_per_hit", "fire_rate_per_second", "magazine", "reserve_ammo", "reload_seconds"}


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("sheet", nargs="?", default="weapon_sheet.json")
    parser.add_argument("--require-integration", action="store_true",
                        help="Fail until every weapon has verified game asset and registration mappings.")
    args = parser.parse_args()
    path = Path(args.sheet)
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        print(f"FAIL: cannot load {path}: {exc}", file=sys.stderr)
        return 1

    errors: list[str] = []
    if data.get("schema_version") != 1:
        errors.append("schema_version must be 1")
    weapons = data.get("weapons")
    if not isinstance(weapons, list):
        errors.append("weapons must be an array")
        weapons = []
    if len(weapons) != 12:
        errors.append(f"expected exactly 12 weapons, got {len(weapons)}")

    ids: set[str] = set()
    names: set[str] = set()
    integration_blockers: list[str] = []
    for index, weapon in enumerate(weapons, start=1):
        prefix = f"weapons[{index}]"
        if not isinstance(weapon, dict):
            errors.append(f"{prefix} must be an object")
            continue
        missing = REQUIRED - set(weapon)
        if missing:
            errors.append(f"{prefix} missing: {', '.join(sorted(missing))}")
            continue
        if not weapon["id"] or weapon["id"] in ids:
            errors.append(f"{prefix}.id is blank or duplicated: {weapon['id']!r}")
        ids.add(weapon["id"])
        if not weapon["name"] or weapon["name"] in names:
            errors.append(f"{prefix}.name is blank or duplicated: {weapon['name']!r}")
        names.add(weapon["name"])
        for key in ("family", "role", "damage_type", "primary_fire", "alternate_fire",
                    "tradeoff", "visual_identity", "audio_identity"):
            if not isinstance(weapon[key], str) or not weapon[key].strip():
                errors.append(f"{prefix}.{key} must be a non-empty string")
        stats = weapon["prototype_stats"]
        if not isinstance(stats, dict) or STAT_KEYS - set(stats):
            errors.append(f"{prefix}.prototype_stats must contain {', '.join(sorted(STAT_KEYS))}")
        else:
            for key in STAT_KEYS:
                value = stats[key]
                if not isinstance(value, (int, float)) or isinstance(value, bool) or value < 0:
                    errors.append(f"{prefix}.prototype_stats.{key} must be a non-negative number")
        impl = weapon["implementation"]
        if not isinstance(impl, dict):
            errors.append(f"{prefix}.implementation must be an object")
        elif (not impl.get("target_game_asset") or not impl.get("weapon_registration_hook")
              or impl.get("replication") == "unknown"):
            integration_blockers.append(weapon["id"])

    if errors:
        print("DESIGN SHEET: FAIL")
        for item in errors:
            print(f"- {item}")
        return 1

    print(f"DESIGN SHEET: PASS — {len(weapons)} unique weapon entries; required design fields populated.")
    print(f"IMPLEMENTATION MAPPING: {len(integration_blockers)} unresolved weapon mappings: {', '.join(integration_blockers)}")
    if args.require_integration and integration_blockers:
        print("IMPLEMENTATION PREFLIGHT: BLOCKED — inspect the installed game and map every weapon to real assets/hooks first.")
        return 2
    print("IMPLEMENTATION PREFLIGHT: NOT CLEARED (design validation does not prove a playable mod).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
