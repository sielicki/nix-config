{ self, config, ... }:
{
  age.secrets.sielicki-personal-password.file = "${self}/secrets/sielicki-personal-password.age";
  age.secrets.tailscale-authkey.file = "${self}/secrets/tailscale-authkey.age";
}
