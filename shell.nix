with import <nixpkgs> {};

let
  ghcPackages = ghc.withPackages (p: with p;
    [
      bytestring
      dhall
      hlint
      lens
      pandoc
      shake
      text
      wreq
    ]
  );
  latexPackages = texlive.combine {
    inherit (texlive)
    animate
    babel
    beamer
    chngcntr
    cleveref
    enumitem
    etoolbox
    excludeonly
    fancyvrb
    fvextra
    float
    framed
    ifplatform
    lineno
    listings
    mdframed
    media9
    microtype
    minted
    needspace
    ocgx2
    pgf
    scheme-medium
    textpos
    todonotes
    upquote
    xcolor
    xstring
    ;
  };
  pyPackages = with pythonPackages; [ pygments ];
in
  runCommand "slides-build-input" {
    buildInputs = [
      coreutils
      eject
      ghcPackages
      google-fonts
      graphviz
      imagemagick
      latexPackages
      unzip
      which
    ] ++ pyPackages;
  } ""
