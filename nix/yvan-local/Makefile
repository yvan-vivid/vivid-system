.PHONY: check build install

all: check

check:
	nix flake check

build:
	nix build .

install:
	nix profile install .

update-source:
	nix flake update --flake .

update:
	nix profile upgrade nix/yvan-local
