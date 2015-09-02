{-# LANGUAGE OverloadedStrings #-}


module Loint
    (
    sortLoint,
    lointData,
    addLointLink,
    Loint(..)
    ) where

      import Prelude hiding (div)
      import Text.Blaze(ToMarkup(..),string,stringValue)
      import Text.Blaze.Html((!),Html)
      import Text.Blaze.Html5(a,h3,div,img,p)
      import Text.Blaze.Html5.Attributes(name,href,src,alt)

      import SvgImg(getSvgLinked,getSvgPath)
      import UnSafe(hackageUrl,getUrlFromData)


      data Loint = Loint Integer Html Html -- id title text
      type LointList = [Loint]



      addLointLink :: Integer -> Html
      addLointLink i = a ! href (stringValue link) $ string title
        where
          link = "/loint#LOINT-" ++ show i
          title = "LOINT[" ++ show i ++"]"


      lointData :: LointList
      lointData = [
          Loint 0 (getSvgLinked (getUrlFromData "XHSK-Home") "XHSKHome") $ do
            a ! href (stringValue $ getUrlFromData "XHSK-Home") $ "XHSK"
            " 是 Xidian Haskell(Hackage) Server Keeper 的简写。\n目前还在筹备中。",
          Loint 1 (getSvgLinked (getUrlFromData hackageUrl) "XHSKHackage") $ do
            a ! href (stringValue hackageUrl) $ "XHSK-Hackage"
            " 是 XHSK 架设于西电校内的 Hackage。",
          Loint 2 "Email:qinka@live.com" $ do
            a ! href "mailto:qinka@live.com" $ "qinka@live.com"
            "是 XHSK-Home主要维护着的私人邮箱。但在XHSK-Home 有对外开放邮箱之前，可通过该邮箱联系我们。",
          Loint 3 "开发与Repo信息" $
            div $
              p $ do
                img ! src (getSvgPath "static")
                " "
                getSvgLinked "http://www.haskell.org" "LanguageHaskell"
                " "
                getSvgLinked "https://github.com/scotty-web/scotty" "FrameScotty"
                " "
                getSvgLinked "https://raw.githubusercontent.com/Xidian-Haskell-Server-Keeper/XHSK-Home/master/LICENSE" "licenseBSD"
                " "
                getSvgLinked "https://github.com/Xidian-Haskell-Server-Keeper/XHSK-Home" "repo"
                " "
                a ! href "https://coveralls.io/github/Xidian-Haskell-Server-Keeper/XHSK-Home?branch=master" $
                  img ! src "https://coveralls.io/repos/Xidian-Haskell-Server-Keeper/XHSK-Home/badge.svg?branch=master&service=github"
                      ! alt "Coverage Status"
        ]


      sortLoint :: LointList -> LointList
      sortLoint [] = []
      sortLoint (x@(Loint i _ _):xs) =
        let smallerOrEq = [b | b@(Loint bi _ _) <- xs ,bi <= i ]
            larger = [b | b@(Loint bi _ _) <- xs ,bi > i ]
        in sortLoint smallerOrEq ++ [x] ++ sortLoint larger


      instance ToMarkup Loint where
        toMarkup (Loint num title str) = div $ do
            h3 $ a ! name (stringValue numStr) $ do
              "## " :: Html
              title
            str
          where
            numStr =  "LOINT-" ++ show num
