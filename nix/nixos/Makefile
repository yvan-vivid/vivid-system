HOSTNAME := $(shell hostname)
FLAKE := ".\#$(HOSTNAME)"

.PHONY: check dry-build build boot switch diff diff-derivation

all: check

check:
	nix flake check --all-systems

check-local:
	nix flake check

dry-build:
	nixos-rebuild dry-build --flake $(FLAKE)

# Real target for the result symlink
result:
	nixos-rebuild build --flake $(FLAKE)

# Phony target that depends on result
build: result
	@echo "Build complete: result -> $$(readlink result)"

boot:
	nixos-rebuild boot --flake $(FLAKE)

switch:
	nixos-rebuild switch --flake $(FLAKE)

# Diff using nvd (shows package-level changes)
diff: result
	nvd diff /run/current-system result

# Diff using nix-diff (shows derivation-level changes)
diff-derivation: result
	nix-diff /run/current-system result
