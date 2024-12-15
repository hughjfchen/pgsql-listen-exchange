{
  description = "pgsql-listen-exchange";

  inputs = {
    beam-flakes.url = "github:mhanberg/nix-beam-flakes";
    beam-flakes.inputs.flake-parts.follows = "flake-parts";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    beam-flakes,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit self;} {
      imports = [beam-flakes.flakeModule];

      systems = ["x86_64-linux"];

      perSystem = _: {
        beamWorkspace = {
          enable = true;
          devShell.languageServers.erlang = true;
          versions = {
            erlang = "27.1";
          };
        };
      };
    };
}
