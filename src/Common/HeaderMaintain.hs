

module Common.HeaderMaintain
    (
    maintainTime
    ) where

      import Data.Time
      import System.Directory
      import System.IO


      maintainTime :: IO String
      maintainTime = do
        isE <- doesFileExist "./.maintain.plan"
        case isE of
          False -> return ""
          True -> do
            aim' <- readFile "./.maintain.plan"
            let rt = "     稍后将进入维护，预计维护时间: " ++ head (lines aim')
            return rt
