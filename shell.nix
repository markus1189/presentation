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
    environ
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
    tcolorbox
    textpos
    todonotes
    trimspaces
    upquote
    xcolor
    xstring
    ;
  };
  pyPackages = with pythonPackages; [ pygments ];
in
  runCommand "slides-build-input" {
    FONTCONFIG_FILE = makeFontsConf { fontDirectories = [ google-fonts ]; };

    buildInputs = [
      coreutils
      eject
      ghcPackages
      graphviz
      imagemagick
      latexPackages
      unzip
      which
    ] ++ pyPackages;
  } ""
