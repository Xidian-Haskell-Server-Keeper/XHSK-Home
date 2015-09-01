




module UnSafe
    (
    hackageUrl,
    getUrlFromData
    ) where

      import Config(getDataFromFile,getData,pickerData)

      import System.IO.Unsafe

      hackageUrlIO :: IO String
      hackageUrlIO = do
        configData <- getDataFromFile "./.xhsk.home.config"
        return . (\(Just x) -> x) $ getData configData pickerData "hackage-url"
      hackageUrl :: String
      hackageUrl = unsafeDupablePerformIO hackageUrlIO

      getUrlFromDataIO :: String -> IO String
      getUrlFromDataIO url = do
        configData <- getDataFromFile "./.xhsk.home.config"
        return . (\(Just x) -> x) $ getData configData pickerData url


      getUrlFromData :: String -> String
      getUrlFromData url = unsafeDupablePerformIO $ getUrlFromDataIO url
