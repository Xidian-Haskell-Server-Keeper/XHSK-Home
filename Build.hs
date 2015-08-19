#!/bin/runghc

{-# LANGUAGE CPP #-}
#define _BUILD_
module Build where
import Distribution.Simple
import System.Environment
import System.Process




cabal = defaultMainArgs
data OS = Windows | Linux deriving (Show,Read)
data Run = Start | Stop | Restart | Test deriving (Show,Read)

maintain :: IO () -> IO () -> IO ()
maintain w u = do
  putStrLn "XHSK-Home 维护"
  x <- readFile "./info"
  let flag = read x :: OS
  case flag of
    Linux -> u
    Windows -> w
    _ -> undefined


main = do
  args <- getArgs
  if null args || head args == "help" then help else maintain (windowsMain $ head args) (unixMain $ head args)
  where
    help = do
      putStrLn "XHSK-Home 维护"

windowsMain :: String -> IO ()
windowsMain arg = do
  let flag = read arg :: Run
  case flag of
    Test -> do
      (_,_,_,cabalinstall) <- createProcess $ shell "cabal install"
      waitForProcess cabalinstall
      createProcess $
        proc "./.cabal-sandbox/bin/XHSK-Home.Bin.exe" []
      createProcess $
        shell "start http://localhost:3000/"
      getLine
      (_,_,_,kill) <- createProcess $ shell "taskkill /IM XHSK-Home.Bin.exe /F"
      waitForProcess kill
      putStrLn "测试结束"

    _ -> undefined
unixMain :: String -> IO ()
unixMain _ =undefined
