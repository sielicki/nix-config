{ ... }:
{
  users.users.bootstrap = {
    isNormalUser = true;
    home = "/var/empty";
    description = "Bootstrap User";
    extraGroups = [ "wheel" "networkmanager" ];
    password = "bootstrap";
  };
}
