# AGENTS.md — Nix Configuration

This workspace contains two Nix flakes:

| Directory | Purpose |
|---|---|
| `nixos/` | NixOS system specifications for multiple hosts |
| `yvan-local/` | Flake that builds a combined environment package (base dev environment) |

## Flake Architecture

### `yvan-local/` — flake-parts based

Uses **flake-parts** (`github:hercules-ci/flake-parts`). This is the mature, stable component.

- `flake.nix` — entry point; declares inputs and imports all modules from `modules/`
- `modules/*.nix` — each module contributes `packages.<name>` via `perSystem`
- `modules/combined.nix` — combines all sub-packages into `packages.yvan-local` using `pkgs.buildEnv`
- Multi-system: `x86_64-linux`, `aarch64-linux`

**flake-parts module pattern:**

```nix
{...}: {
  perSystem = {config, pkgs, ...}: {
    packages.yvan-something = pkgs.buildEnv { ... };
  };
}
```

Inputs include a local `opencode` flake (`/src/repos/forks/ai/opencode`).

### `nixos/` — traditional flake (transitioning to dendritic)

Not yet using flake-parts or dendritic. Uses a manual `lib.listToAttrs` pattern to auto-discover hosts from `hosts/`.

- `flake.nix` — discovers host directories under `hosts/` and builds `nixosConfigurations`
- `hosts/<hostname>/` — per-host `configuration.nix` + `hardware-configuration.nix`
- `modules/default.nix` — shared module that imports subdirectories (`core/`, `development/`, `environments/`, `machines/`, `media/`, `services/`) and defines `yvan.name` / `yvan.primary` options
- Two nixpkgs inputs: stable (`nixos-25.11`) and unstable (`nixos-unstable` as `pkgs-edge`)
- Hosts: `red-arrow` (Surface Laptop Go), `after-velazquez` (Beelink AMD), `glass-armature` (Framework Desktop), `wittie-box` (PepperJobs minicomputer)

## Development Workflow — Always Use Make

Both directories have Makefiles. **Prefer make targets over raw nix commands.**

### `yvan-local/` Makefile

| Target | Description |
|---|---|
| `make check` | `nix flake check --all-systems` — validates all systems |
| `make check-local` | `nix flake check` — validates current system only (faster) |
| `make build` | `nix build . --out-link result` — builds the default package |
| `make install` | `nix profile install .` — installs into current profile |
| `make diff` | Compares current profile with new build using `nvd diff` |
| `make diff-derivation` | Derivation-level diff using `nix-diff` |
| `make update-source` | `nix flake update` — updates flake.lock |
| `make update` | `nix profile upgrade nix/yvan-local` — upgrades installed profile |

### `nixos/` Makefile

| Target | Description |
|---|---|
| `make check` | `nix flake check --all-systems` — validates all host configs |
| `make check-local` | `nix flake check` — validates current host only |
| `make build` | `nixos-rebuild build --flake .#<hostname>` |
| `make boot` | `nixos-rebuild boot --flake .#<hostname>` |
| `make switch` | `nixos-rebuild switch --flake .#<hostname>` |
| `make diff` | `nvd diff /run/current-system result` |
| `make diff-derivation` | `nix-diff` on derivations |

The hostname is auto-detected via `$(shell hostname)`.

## Key Guidelines

- **Always run `make check`** before committing changes to verify configs evaluate correctly
- For `yvan-local/` development, use `make check-local` for faster iteration on a single system
- When adding new modules to `yvan-local/`, follow the flake-parts `perSystem` pattern and import the module in `flake.nix`
- When adding hosts to `nixos/`, just create a new directory under `hosts/` — they are auto-discovered
- The `nixos/` flake is being transitioned toward a dendritic architecture; expect its structure to evolve
- `yvan-local` uses `pkgs.buildEnv` to combine sub-packages — new environment components should follow the same pattern and be added to `modules/combined.nix`
