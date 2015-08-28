


module Loint
    (
    sortLoint,
    lointData,
    Loint(..)
    ) where
      import Prelude hiding (div)
      import Text.Blaze(ToMarkup(..),string,stringValue)
      import Text.Blaze.Html((!))
      import Text.Blaze.Html5(a,h3,div)
      import Text.Blaze.Html5.Attributes(name)


      data Loint = Loint Integer String  String -- id title text
      type LointList = [Loint]


      lointData :: LointList
      lointData = [
          Loint 0 "test" "test",
          Loint 1 "test1" "test2"
        ]

      sortLoint :: LointList -> LointList
      sortLoint [] = []
      sortLoint (x@(Loint i _ _):xs) =
        let smallerOrEq = [a | a@(Loint ai _ _) <- xs ,ai <= i ]
            larger = [a | a@(Loint ai _ _) <- xs ,ai > i ]
        in sortLoint smallerOrEq ++ [x] ++ sortLoint larger


      instance ToMarkup Loint where
        toMarkup (Loint num title str) = div $ do
            h3 $ a ! name (stringValue numStr)
              $ string $ numStr ++ "] ## " ++ title
            string str
          where
            numStr = (++) "## LOINT [" $ show num
