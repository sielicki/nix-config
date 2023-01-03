{ self, config, lib, pkgs, ... }:

let
  inherit (lib) fileContents;
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
in

{
  imports = [ ./secrets.nix ];
  environment = {
    systemPackages = with pkgs; [
      direnv
      jq
      binutils
      coreutils
      curl
      dnsutils
      fd
      git
      ripgrep
      moreutils
      whois
      wget
      bat
    ];
  };

  nix = {
    settings = {
      sandbox = true;
      trusted-users = [ "root" "@wheel" ];
    };
    gc.automatic = true;
    extraOptions = ''
      min-free = 536870912
      keep-outputs = true
      keep-derivations = true
      fallback = true
    '';
  };
}
