{ self, config, lib, pkgs, ... }:
let
  tailscale-reauth = pkgs.writeShellScriptBin "tailscale-reauth" ''
    ${pkgs.tailscale}/bin/tailscale up -authkey $(cat ${config.age.secrets.tailscale-authkey.path})
  '';
in
{
  services.tailscale = {
    enable = true;
  } // (if pkgs.stdenv.isDarwin then { domain = "llama-mamba"; } else { });

  environment.systemPackages = [ tailscale-reauth ];
}
