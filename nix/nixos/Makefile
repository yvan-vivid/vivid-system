HOSTNAME := $(shell hostname)
FLAKE := ".\#$(HOSTNAME)"

.PHONY: check dry-build build boot switch

all: check

check:
	nix flake check --all-systems

check-local:
	nix flake check

dry-build:
	nixos-rebuild dry-build --flake $(FLAKE)

build:
	nixos-rebuild build --flake $(FLAKE)

boot:
	nixos-rebuild boot --flake $(FLAKE)

switch:
	nixos-rebuild switch --flake $(FLAKE)
