{ config, pkgs, lib, ... }:
{
  home.packages = [
    pkgs.git
    pkgs.git-review
    pkgs.mr
  ];

  programs.git = {
    enable = true;
    userName = "Nicholas Sielicki";
    userEmail = "git@opensource.nslick.com";
    ignores = [
      ".vscode"
      "compile_commands.json"
      "tags"
      "TAGS"
      ".cache"
      ".ccls-cache"
      ".dumbjumpignore"
      ".editorconfig"
      ".dir-locals.el"
      ".dumbjump"
      ".ccls-root"
    ];
    extraConfig = {
      core.whitespace = "trailing-space,space-before-tab";
      merge.conflictstyle = "diff3";
      diff = {
        wsErrorHighlight = "all";
        colorMoved = "default";
      };
      format.signoff = true;
      push.default = "simple";
      pull.ff = "only";
      gitreview = {
        remote = "origin";
      };
      http.emptyAuth = true;
    };
  };
}
