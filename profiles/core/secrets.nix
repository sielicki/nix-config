{ self, config, ... }:
{
  age.secrets.sielicki-personal-password.file = "${self}/secrets/sielicki-personal-password.age";
}
