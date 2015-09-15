module Config
    (
    ConfigData(..),
    ConfigPicker(..),
    pickerData,
    getData,
    getDataFromFile
    ) where

      import System.IO.Extra

      data ConfigPicker = Picker String Integer
      data ConfigData = Data Integer String

      pickerData :: [ConfigPicker]
      pickerData = [
        Picker "hackage-url" 1,
        Picker "XHSK-Home" 2
        ]

      getLineFromPicker :: [ConfigPicker] -> String -> Maybe Integer
      getLineFromPicker [] _ = Nothing
      getLineFromPicker (Picker str li:xs) findedstr
        | str == findedstr = Just li
        | otherwise = getLineFromPicker xs findedstr

      getValFromData :: [ConfigData] -> Integer -> Maybe String
      getValFromData _ (-1) =Nothing
      getValFromData [] _ = Nothing
      getValFromData (Data li str:xs) num
        | li == num = Just str
        | otherwise = getValFromData xs num

      getData :: [ConfigData] -> [ConfigPicker] -> String -> Maybe String
      getData cd cp = getValFromData cd.item.getLineFromPicker cp
        where
          item Nothing = -1
          item (Just x) = x

      getDataFromFile :: FilePath -> IO [ConfigData] --readFileUTF8
      getDataFromFile path = do
        text <- readFileUTF8 path --"./.xhsk.home.config"
        return $ getDataFromFileStep (lines text) 1

      getDataFromFileStep :: [String] -> Integer -> [ConfigData]
      getDataFromFileStep [] _ = []
      getDataFromFileStep (x:xs) i
        | note x =  Data i x:getDataFromFileStep xs  (1+i)
        | otherwise = getDataFromFileStep xs $ 1+i
        where
          note (xx:yy:_)
            | xx==yy && yy=='-' =False
            | otherwise = True
          note _ = True
