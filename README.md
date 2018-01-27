# Person Presentation Template For LaTeX Beamer

[![Build Status](https://travis-ci.org/markus1189/presentation.svg?branch=master)](https://travis-ci.org/markus1189/presentation)

## Components

- [Shake](http://shakebuild.com/) to build the presentation
- [Nix](http://nixos.org) to have a declarative environment with all
  needed executables / haskell libs / texlive packages / fonts / etc.

## Requirements

You need the *nix* package manager, the whole rest (haskell, latex,
...) will be automatically provided using it.  That means after
installing the nix package manager, you're good to go (promise!)

## Travis CI

The presentation is automatically build using travis CI.

## How To Build

It's a *single* command:

```
./Build.hs
```

The presentation is under `results/slides.pdf`.
