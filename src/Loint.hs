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
          Loint 0 "XHSK-Home" $ do
            a ! href (stringValue $ getUrlFromData "XHSK-Home") $ "XHSK"
            " 是 Xidian Haskell(Hackage) Server Keeper 的简写。\n目前还在筹备中。",
          Loint 1 "XHSK-Hackage" $ do
            a ! href (stringValue hackageUrl) $ "XHSK-Hackage"
            " 是 XHSK 架设于西电校内的 Hackage。",
          Loint 2 "Email:qinka@live.com" $ do
            a ! href "mailto:qinka@live.com" $ "qinka@live.com"
            "是 XHSK-Home主要维护着的私人邮箱。但在XHSK-Home 有对外开放邮箱之前，可通过该邮箱联系我们。",
          Loint 3 "开发信息" $ do
            "这个静态网站是使用 "
            a ! href "http://www.haskell.org" $ "Haskell"
            "语言 使用"
            a ! href "https://github.com/scotty-web/scotty" $ "Scotty"
            "框架编写成的。",
          Loint 4 "Repo" $ do
            a ! href "https://github.com/Xidian-Haskell-Server-Keeper/XHSK-Home" $ "GitHub 上的Repo"
            -- <a href=''><img src='' alt='Coverage Status' /></a>
            p $ a ! href "https://coveralls.io/github/Xidian-Haskell-Server-Keeper/XHSK-Home?branch=master" $
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
