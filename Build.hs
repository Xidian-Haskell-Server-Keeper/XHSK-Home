#!/usr/local/bin/runghc


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
import Control.Monad





cabal = defaultMainArgs
data OS = Windows | Linux deriving (Show)
instance Read OS where
  readsPrec _ s =
        case s of
          "Windows"  -> [(Windows,"")]
          "Linux" -> [(Linux,"")]
          "windows"  -> [(Windows,"")]
          "linux" -> [(Linux,"")]

data Run = Start | Stop | Restart | Test deriving (Show)
instance Read Run where
  readsPrec _ s =
        case s of
          "Start"->[(Start,"")]
          "Stop"->[(Stop,"")]
          "Restart"->[(Restart,"")]
          "Test"->[(Test,"")]
          "start"->[(Start,"")]
          "stop"->[(Stop,"")]
          "restart"->[(Restart,"")]
          "test"->[(Test,"")]

maintain :: IO () -> IO () -> IO ()
maintain w u = do
  putStrLn "XHSK-Home 维护"
  x <- readFile "./info"
  let xx = head $ lines x
  let flag = read xx :: OS
  case  flag of
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
      setCurrentDirectory ".."
      (_,_,_,cabalinstall) <- createProcess $ shell "cabal install XHSK-Home/"
      ciEc <- waitForProcess cabalinstall
      case ciEc of
        ExitSuccess -> putStrLn "编译成功"
        _ -> error "编译错误"
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
    Start -> do
      gitPull
      cabalInstall
      startIt
      writeFileUTF8 "../.maintain.plan"  "正常运行"
    Stop -> stopIt
    Restart -> do
      (_:aim':_) <- getArgs
      let aim = (read (head $ lines aim') ::UTCTime)
      localTimeZone <- getTimeZone aim
      let localTime = utcToLocalTime localTimeZone aim
      writeFileUTF8 "../.maintain.plan" $ (++) "本站即将进入维护，预计维护时间：" $ show localTime
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
      writeFileUTF8 "./.maintain.plan" "正常运行"
    stopIt = do
      putStrLn "Ready to Stop"
      (_,_,_,sstop) <- createProcess $ shell "pidof XHSK-Home.Bin | xargs kill"
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
