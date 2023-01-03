{
  programs.starship = {
    enable = false;
    settings = {
      line_break.disabled = true;
      hostname.ssh_only = false;
      localip.ssh_only = false;
      localip.disabled = false;
      shell.disabled = false;
      shell.zsh_indicator = "z";
      shell.bash_indicator = "b";
      status.disabled = false;
      c.disabled = true;
      python.disabled = true;
    };
  };
}
