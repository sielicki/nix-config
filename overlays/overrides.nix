channels: final: prev: {

  __dontExport = true;

  inherit (channels.latest)
    cachix
    dhall
    discord
    discocss
    element-desktop
    rage
    sbcl
    stumpwm
    nix
    nix-index
    nixos-generators
    nixpkgs-fmt
    qutebrowser
    signal-desktop
    starship
    deploy-rs
    linuxPackages_xanmod_latest
    ;

  haskellPackages = prev.haskellPackages.override
    (old: {
      overrides = prev.lib.composeExtensions (old.overrides or (_: _: { })) (hfinal: hprev:
        let version = prev.lib.replaceChars [ "." ] [ "" ] prev.ghc.version;
        in
        {
          # same for haskell packages, matching ghc versions
          inherit (channels.latest.haskell.packages."ghc${version}")
            haskell-language-server;
        });
    });

  linuxPackages = channels.latest.linuxPackages;
  lispPackages = channels.latest.lispPackages;

  #lispPackages_new.sbclPackages = prev.lispPackages_new.sbclPackages.override
  #  (old: {
  #    overrides = prev.lib.composeExtensions (old.overrides or (_: _: { })) (f: p:
  #      {
  #        inherit (channels.latest.lispPackages_new.sbclPackages)
  #          stumpwm
  #          ;
  #      });
  #  });
}
