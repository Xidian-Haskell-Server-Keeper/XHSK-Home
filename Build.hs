#!/bin/runghc

module Build where
import Distribution.Simple
import System.Environment
import System.Process
import System.Directory
import System.Exit


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
      putStrLn "键入回车退出"
      getLine
      (_,_,_,kill) <- createProcess $ shell "taskkill /IM XHSK-Home.Bin.exe /F"
      waitForProcess kill
      putStrLn "测试结束"
    _ -> undefined
unixMain :: String -> IO ()
unixMain arg = do
  let flag = read arg :: Run
  case flag of
    Start -> start'git
    Stop -> stopIt
    Restart -> restartIt
    _ -> undefined
  where
    start'git = do
      (_,_,_,git'pull) <- createProcess $
        proc "git" ["pull","master"]
      exCode <- waitForProcess git'pull
      case exCode of
        ExitSuccess -> start'cabal
        _ -> putStrLn "repo 同步失败"
      return ()
    start'cabal =do
      setCurrentDirectory ".."
      (_,_,_,cabal'install) <- createProcess $
        proc "cabal" ["install","./XHSK-Home/"]
      exCode <- waitForProcess cabal'install
      case exCode of
        ExitSuccess -> start'server
        _ -> putStrLn "cabal 安装失败"
      return ()
    start'server = do
      createProcess $
        shell "exec ../.cabal-sandbox/bin/XHSK-Home.Bin"
      return ()
    stopIt = do
      createProcess $ shell "pidof XHSK-Home.Bin | xargs kill -s 9"
      return ()
    restartIt = do
      stopIt
      start'git
      return ()