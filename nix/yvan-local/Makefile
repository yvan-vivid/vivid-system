.PHONY: all check build install update-source update diff diff-derivation rebuild clean-build

all: check

check:
	nix flake check --all-systems

check-local:
	nix flake check

# Real target for the result symlink
result:
	nix build . --out-link result

# Phony target that depends on result
build: result
	@echo "Build complete: result -> $$(readlink result)"

rebuild: clean-build build

clean-build:
	rm -f result

install:
	nix profile install .

update-source:
	nix flake update --flake .

update:
	nix profile upgrade nix/yvan-local

# Diff using nvd (shows package-level changes)
diff: result
	@echo "Comparing current profile with new build..." && \
	nvd diff $$(./scripts/extract-yvan-profile.sh url) result

# Diff using nix-diff (shows derivation-level changes)
diff-derivation: result
	@CURRENT=$$(./scripts/extract-yvan-profile.sh url) && \
	echo "Comparing derivations..." && \
	nix-diff $$(nix path-info --derivation "$$CURRENT") $$(nix path-info --derivation result)

