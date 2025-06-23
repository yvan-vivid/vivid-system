.PHONY: check build install

all: check

check:
	nix flake check

build:
	nix build .

install:
	nix profile install .

