#!/usr/local/bin/runghc


{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE Trustworthy #-}
{-# LANGUAGE ScopedTypeVariables #-}



module Build where
import Distribution.Simple
import System.Environment
import System.Process
import System.Directory
import System.Exit
import System.IO.Extra(writeFileUTF8)
import Data.Time
import Data.Char
import Control.Monad
import Text.Blaze.Svg.Renderer.String
import Text.Blaze.Svg.Shields



cabal :: [String] -> IO ()
cabal = defaultMainArgs

data OS = Windows | Linux | FinalSite String deriving (Show)
instance Read OS where
  readsPrec _ s' =
    case str of
          "windows"  -> [(Windows,"")]
          "linux" -> [(Linux,"")]
          "final" -> [(FinalSite $ read (s!!1),"")]
          "finalsite" -> [(FinalSite $ read (s!!1),"")]
    where
      s = words s'
      str = map toLower $ head s

data Run = Start | Stop | Restart | Test deriving (Show)
instance Read Run where
  readsPrec _ s =
    case s of
          "start"->[(Start,"")]
          "stop"->[(Stop,"")]
          "restart"->[(Restart,"")]
          "test"->[(Test,"")]
    where
      str = map toLower s

maintain :: [IO ()]-> IO ()
maintain [w,u,f] = do
  putStrLn "XHSK-Home 维护"
  x <- readFile "./info"
  let xx = head $ lines x
  let flag = read xx :: OS
  case  flag of
    Linux -> u
    Windows -> w
    FinalSite _ -> f
    _ -> undefined

main :: IO ()
main = do
  args <- getArgs
  if null args || head args == "help" then help else maintain [windowsMain $ head args,unixMain $ head args,putStrLn ":("]
  where
    help = do
      putStrLn "XHSK-Home 维护"
      x <- readFile "./info"
      let platform = read $ head $ lines x ::OS
      case platform of
        Linux -> undefined
        Windows -> undefined
        FinalSite _ -> undefined
      return ()


--------------------------Help-Infomation----------------------------


helpOfLinux,helpOfFinalSite,helpOfWindows ::[String]
helpOfLinux=undefined
helpOfWindows=undefined
helpOfFinalSite=undefined


--------------------------Windows-(Only Test)------------------------

windowsMain :: String -> IO ()
windowsMain arg = do
  let flag = read arg :: Run
  case flag of
    Test -> do
      setCurrentDirectory ".."
      (_,_,_,cabalinstall) <- createProcess $ shell "cabal install XHSK-Home\\"
      ciEc <- waitForProcess cabalinstall
      case ciEc of
        ExitSuccess -> putStrLn "编译成功"
        _ -> error "编译错误"
      _ <- createProcess $
        proc "./.cabal-sandbox/bin/XHSK-Home.Bin.exe" []
      _ <- createProcess $
        shell "start http://localhost:3000/"
      putStrLn "键入回车退出"
      _ <- getLine
      (_,_,_,kill) <- createProcess $ shell "taskkill /IM XHSK-Home.Bin.exe /F"
      _ <- waitForProcess kill
      putStrLn "测试结束"
    _ -> undefined

--------------------Unix-Like--------------------

unixMain :: String -> IO ()
unixMain arg = do
  let flag = read arg :: Run
  case flag of
    Start -> do
      gitPull
      cabalInstall
      startIt
    Stop -> stopIt
    Restart -> do
      (_:aim':_) <- getArgs
      let aim = read (head $ lines aim') ::UTCTime
      localTimeZone <- getTimeZone aim
      let localTime = utcToLocalTime localTimeZone aim ---- 2015-09-15 18:12:24
      writeFile "../.maintain.plan" $ renderSvg $ plasticStyle ("预计维护时间",69) (show localTime,200) Nothing $ Just "#D02090"
      gitPull
      cabalInstall
      waitIt aim
      stopIt
      startIt
    Test -> testIt
    _ -> undefined
  where
    gitPull = do
      (_,_,_,git'pull) <- createProcess $
        proc "git" ["pull","origin"]
      exCode <- waitForProcess git'pull
      case exCode of
        ExitSuccess -> return ()
        _ -> error "repo 同步失败"
      return ()
    cabalInstall =do
      setCurrentDirectory ".."
      (_,_,_,cabal'install) <- createProcess $
        proc "cabal" ["install","./XHSK-Home/"]
      exCode <- waitForProcess cabal'install
      case exCode of
        ExitSuccess -> return ()
        _ -> error "cabal 安装失败"
      return ()
    startIt = do
      createProcess $
        shell "exec .cabal-sandbox/bin/XHSK-Home.Bin &"
      writeFile "../.maintain.plan"  $ renderSvg  $ plasticStyle ("网站状态",46) ("正常运行",46) Nothing $ Just "#20B2AA"
    stopIt = do
      putStrLn "Ready to Stop"
      (_,_,_,sstop) <- createProcess $ shell "pidof XHSK-Home.Bin | xargs kill -s 2"
      waitForProcess sstop
      return ()
    waitIt wait = do
      cur <- getCurrentTime
      when (wait > cur) $ waitIt wait
    testIt = do
      setCurrentDirectory ".."
      (_,_,_,cabalinstall) <- createProcess $ shell "cabal install XHSK-Home/"
      ciEc <- waitForProcess cabalinstall
      case ciEc of
        ExitSuccess -> putStrLn "编译成功"
        _ -> error "编译错误"
      createProcess $
        proc "./.cabal-sandbox/bin/XHSK-Home.Bin" ["+RTS","-s"]
      putStrLn "按回车，结束"
      getLine
      stopIt
      putStrLn "测试结束"

---------------FinalSite------------------
