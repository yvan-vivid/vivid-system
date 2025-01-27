# Yvan Vivid - Configuration Overlays
{
  inputs,
  system,
  ...
}: {
  version-refs = final: prev:
    prev
    // {
      stable = prev;
      edge = import inputs.nixpkgs-edge {
        system = system;
        config.allowUnfree = true;
      };
    };
  trivial = final: prev: prev;
}
