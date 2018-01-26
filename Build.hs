#! /usr/bin/env nix-shell
-- #! nix-shell deps.nix -i "ghci -fdefer-type-errors"
#! nix-shell deps.nix -i 'runhaskell --ghc-arg=-threaded --ghc-arg=-Wall'
#! nix-shell --pure

module Main where

import           Development.Shake
import           Development.Shake.FilePath

main :: IO ()
main = runShakeBuild

buildDir :: FilePath
buildDir = "result"

myShakeOptions :: ShakeOptions
myShakeOptions = shakeOptions { shakeLint = Just LintBasic
                              , shakeReport = ["report.html", "report.json"]
                              , shakeThreads = 0
                              , shakeColor = True
                              }

runShakeBuild :: IO ()
runShakeBuild = shakeArgs myShakeOptions $ do
  wantTargets
  phonyCommands
  rules

wantTargets :: Rules ()
wantTargets = do
  want [buildDir </> "slides.pdf"]

phonyCommands :: Rules ()
phonyCommands = do
  phony "clean" (removeFilesAfter buildDir ["//*"])

rules :: Rules ()
rules = do
  buildDir </> "*.pdf" %> \out -> do
    let inp = out -<.> "tex"
    need [inp]
    latexmk inp
    copyFileChanged (inp -<.> "pdf") out

  buildDir </> "*.tex" %> \out -> do
    copyFileChanged (dropDirectory1 out) out

latexmk :: FilePath -> Action ()
latexmk inp = do
  cmd [WithStdout True
      ,EchoStdout False
      ,EchoStderr False
      ,Stdin ""
      ] bin ["-g", "-shell-escape", "-pdfxe", inp]
  where bin = "latexmk" :: String
