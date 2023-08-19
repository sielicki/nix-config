{
  description = "A highly structured configuration database.";

  inputs =
    {
      flake-compat = {
        url = "github:edolstra/flake-compat";
        flake = false;
      };

      flake-utils.url = "github:numtide/flake-utils";

      # Track channels with commits tested and built by hydra
      nixos.url = "github:nixos/nixpkgs/nixos-22.11";
      latest.url = "github:nixos/nixpkgs/master";
      nixpkgs-darwin-stable.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";

      home.url = "github:nix-community/home-manager/master";
      home.inputs.nixpkgs.follows = "latest";

      darwin.url = "github:LnL7/nix-darwin/master";
      darwin.inputs.nixpkgs.follows = "latest";

      wsl.url = "github:nix-community/NixOS-WSL/main";
      wsl.inputs.nixpkgs.follows = "latest";
      wsl.inputs.flake-compat.follows = "flake-compat";
      wsl.inputs.flake-utils.follows = "flake-utils";

      deploy.url = "github:serokell/deploy-rs";
      deploy.inputs.nixpkgs.follows = "latest";

      agenix.url = "github:ryantm/agenix";
      agenix.inputs.nixpkgs.follows = "latest";

      nixos-hardware.url = "github:nixos/nixos-hardware";

      nixos-generators.url = "github:nix-community/nixos-generators";

      emacs-overlay.url = "github:nix-community/emacs-overlay";
      emacs-overlay.inputs.nixpkgs.follows = "latest";
      emacs-overlay.inputs.flake-utils.follows = "flake-utils";

      nix-straight-el.url = "github:nix-community/nix-straight.el";
      nix-straight-el.flake = false;

      digga.url = "github:divnix/digga";
      digga.inputs.nixpkgs.follows = "latest";
      digga.inputs.nixlib.follows = "latest";
      digga.inputs.darwin.follows = "darwin";
      digga.inputs.home-manager.follows = "home";
      digga.inputs.deploy.follows = "deploy";
      digga.inputs.flake-compat.follows = "flake-compat";
      digga.inputs.flake-utils.follows = "flake-utils";
    };

  outputs =
    { self
    , agenix
    , deploy
    , digga
    , emacs-overlay
    , home
    , nixos
    , nixos-hardware
    , nixos-generators
    , nix-straight-el
    , nixpkgs
    , wsl
    , ...
    } @ inputs:
    digga.lib.mkFlake
      {
        inherit self inputs;

        channelsConfig = { allowUnfree = true; };

        channels = {
          nixos = {
            imports = [ (digga.lib.importOverlays ./overlays) ];
            overlays = [ ];
          };
          nixpkgs-darwin-stable = {
            imports = [ (digga.lib.importOverlays ./overlays) ];
            overlays = [
              (channels: final: prev: { } // prev.lib.optionalAttrs true { })
            ];
          };
          latest = { };
        };

        lib = import ./lib { lib = digga.lib // self.inputs.latest.lib; };

        sharedOverlays = [
          (final: prev: {
            __dontExport = true;
            lib = prev.lib.extend (lfinal: lprev: {
              our = self.lib;
            });
          })

          agenix.overlays.default
          emacs-overlay.overlays.default

          (import ./pkgs)
        ];

        nixos = {
          hostDefaults = {
            system = "x86_64-linux";
            channelName = "nixos";
            imports = [ (digga.lib.importExportableModules ./modules) ];
            modules = [
              { lib.our = self.lib; }
              digga.nixosModules.bootstrapIso
              digga.nixosModules.nixConfig
              home.nixosModules.home-manager
              agenix.nixosModules.age
            ];
          };

          imports = [ (digga.lib.importHosts ./hosts/nixos) ];
          hosts = {
            dogtoy = { modules = [ nixos-hardware.nixosModules.lenovo-legion-15arh05h ]; };
            dogbark = { modules = [ nixos-hardware.nixosModules.raspberry-pi-4 ]; system = "aarch64-linux"; };
          };
          importables = rec {
            profiles = digga.lib.rakeLeaves ./profiles // {
              users = digga.lib.rakeLeaves ./users;
            };
            suites = with profiles; rec {
              hm-minimal = [ users.personal-minimal ];
              hm-devel = [ users.personal-devel ];
              hm-heavy = [ users.personal-heavy ];
              base = [ core.nixos users.root ];
              personal = [ cachix networking.tailscale ];
              gaming = [ games.steam ];
              nvidia-offload = [ games.nvidia-offload ];
              wsl = [ core.wsl ];
            };
          };
        };

        darwin = {
          hostDefaults = {
            system = "x86_64-darwin";
            channelName = "nixpkgs-darwin-stable";
            imports = [ (digga.lib.importExportableModules ./modules) ];
            modules = [
              { lib.our = self.lib; }
              digga.darwinModules.nixConfig
              home.darwinModules.home-manager
              agenix.darwinModules.age
            ];
          };

          imports = [ (digga.lib.importHosts ./hosts/darwin) ];
          hosts = {
            greydog = { /* configuration is in greydog.nix */ };
          };
          importables = rec {
            profiles = digga.lib.rakeLeaves ./profiles // {
              users = digga.lib.rakeLeaves ./users;
            };
            suites = with profiles; rec {
              hm-minimal = [ users.personal-minimal ];
              hm-devel = [ users.personal-devel ];
              hm-heavy = [ users.personal-heavy ];
              base = [ core.darwin ];
              yabai = [ window-managers.yabai ];
              personal = [ cachix users.personal-heavy networking.tailscale ];
            };
          };
        };

        home = {
          imports = [ (digga.lib.importExportableModules ./users/modules) ];
          modules = [ ];
          importables = rec {
            profiles = digga.lib.rakeLeaves ./users/profiles;
            suites = with profiles; rec {
              base = [ core zsh git skim starship shellutils ];
              heavy-base = [ emacs vscode ];
              devel = [ direnv git docs ];
              graphical = [ alacritty chat ];
            };
          };
          users = {
            personal-minimal = { home.stateVersion = "22.11"; }; # base user
            personal-devel = { home.stateVersion = "22.11"; }; # emacs, man pages, terminal emulator, shell utilities, etc.
            personal-heavy = { home.stateVersion = "22.11"; }; # spotify, discord, element, steam, etc.
          };
        };

        devshell = ./shell;

        homeConfigurations = digga.lib.mergeAny
          (digga.lib.mkHomeConfigurations self.darwinConfigurations)
          (digga.lib.mkHomeConfigurations self.nixosConfigurations)
        ;

        deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations { };

      }
  ;
}
