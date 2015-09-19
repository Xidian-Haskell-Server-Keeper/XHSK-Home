#!/usr/local/bin/runghc

{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE Trustworthy,ScopedTypeVariables #-}
module Main
    (
      main
    ) where

      import MaintainData

      import System.Environment
      import System.Process
      import System.Directory
      import System.Exit
      import System.IO.Extra(writeFileUTF8)
      import Data.Time
      import Data.Char
      import Control.Monad
      import Text.Blaze.Svg.Shields
      import Text.Blaze.Svg.Renderer.String

      main :: IO ()
      main = do
        (args) <- getArgs
        if null args || map toLower $ head args == "help" then help else do
          case map toLower $ head args of
            "start" ->
            "restart" ->
            "stop" ->
            "test" ->
        return ()


      help :: IO ()
      help = return ()


      getMTData :: IO MTData
      getMTData = do
        text <- readFile "./info"
        return $  read $ head $ lines x ::IO MTData

      start :: IO
      start = do
        os <- getMTData
        (_,_,_,cabalInstall) <- createProcess
