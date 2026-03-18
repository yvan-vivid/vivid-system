#!/usr/bin/env bash
# Kernel Parameters Diff Script for NixOS
# Usage: scripts/diff-boot-params.sh {current|build|diff}

set -euo pipefail

BOOT_JSON_KEY='."org.nixos.bootspec.v1".kernelParams[]'

get_kernel_params() {
  local path="$1"
  if [[ -f "$path" ]]; then
    jq -r "$BOOT_JSON_KEY" "$path" 2>/dev/null | sort -u
  fi
}

cmd_current() {
  local params
  params=$(get_kernel_params /run/current-system/boot.json)
  echo "=== Current System ==="
  if [[ -z "$params" ]]; then
    echo "(not running NixOS or no boot.json)"
  else
    echo "$params"
  fi
}

cmd_build() {
  if [[ ! -f result/boot.json ]]; then
    echo "Error: result/boot.json not found. Run 'make build' first." >&2
    exit 1
  fi
  local params
  params=$(get_kernel_params result/boot.json)
  echo "=== Current Build ==="
  if [[ -z "$params" ]]; then
    echo "(none)"
  else
    echo "$params"
  fi
}

cmd_diff() {
  local current build
  current=$(get_kernel_params /run/current-system/boot.json)
  build=$(get_kernel_params result/boot.json)

  local tmp_current tmp_build
  tmp_current=$(mktemp)
  tmp_build=$(mktemp)

  [[ -n "$current" ]] && echo "$current" >"$tmp_current"
  [[ -n "$build" ]] && echo "$build" >"$tmp_build"

  local added removed
  added=$(comm -13 "$tmp_current" "$tmp_build")
  removed=$(comm -23 "$tmp_current" "$tmp_build")

  rm -f "$tmp_current" "$tmp_build"

  echo "=== Diff ==="
  if [[ -z "$added" && -z "$removed" ]]; then
    echo "(no changes)"
  else
    if [[ -n "$added" ]]; then
      echo "Added (in result):"
      echo "$added" | sed 's/^/  + /'
    fi
    if [[ -n "$removed" ]]; then
      echo "Removed (from current):"
      echo "$removed" | sed 's/^/  - /'
    fi
  fi
}

case "${1:-}" in
current) cmd_current ;;
build) cmd_build ;;
diff) cmd_diff ;;
*)
  echo "Usage: $0 {current|build|diff}" >&2
  exit 1
  ;;
esac
