{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    envExtra = ''
      autoload -U select-word-style
      select-word-style bash
      setopt interactivecomments
    '';
    # plugins = [
    #   {
    #     name = "powerlevel-10k";
    #     src = pkgs.zsh-powerlevel10k;
    #     file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    #   }
    # ];
    history = {
      save = 10000000;
      size = 10000000;
      ignoreSpace = true;
      extended = true;
      share = true;
    };
  };
}
