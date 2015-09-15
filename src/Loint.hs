{-# LANGUAGE OverloadedStrings #-}


module Loint
    (
    sortLoint,
    lointData,
    addLointLink,
    Loint(..)
    ) where

      import Prelude hiding (div,id)
      import Text.Blaze(ToMarkup(..),string,stringValue)
      import Text.Blaze.Html((!),Html,toHtml)
      import Text.Blaze.Html5(a,h3,div,img,p)
      import Text.Blaze.Html5.Attributes(name,href,src,alt)
      import Text.Blaze.Svg.Shields.Url

      import SvgImg(getSvgLinked,getSvgPath,xhskHome,languageHaskell,frameScotty,xhskHackage,repo,static,licenseBSD)
      import UnSafe(hackageUrl,getUrlFromData)


      data Loint a  = Loint a String Html Html -- id tag title text
      type LointList a = [Loint a]


      findLointId :: LointList Integer-> String -> Maybe Integer
      findLointId [] _ = Nothing
      findLointId (Loint id tag _ _ : xs) aim
        | tag == aim = Just id
        | otherwise = findLointId xs aim


      addLointLink :: String -> Html
      addLointLink tag = a ! href (stringValue link) $ string title
        where
          id = findLointId lointData tag
          link = case id of
            Nothing -> "/404"
            Just i ->  "/loint#LOINT-" ++ show i
          title = case id of
            Nothing -> "LOINT[>.<]"
            Just i -> "LOINT[" ++ show i ++"]"


      indexLoint :: Num a => Integer -> LointList a -> LointList Integer
      indexLoint _ [] = []
      indexLoint i (Loint _ tag title text :xs) = Loint i tag title text : indexLoint (i+1) xs

      lointData :: LointList Integer
      lointData = indexLoint 0 $ sortLoint  datas
        where
          datas = [
            Loint 0 "xhskhome" (getSvgLinked Nothing xhskHome) $ do
              p $ do
                a ! href (stringValue $ getUrlFromData "XHSK-Home") $ "XHSK"
                " 是 Xidian Haskell(Hackage) Server Keeper 的简写。\n目前还在筹备中。"
              p $ do
                "XHSK，也就是西电Hackage维护社团目前隶属于西安电子科技大学软件学院141301401班团支部。"
                "创建人"
                a ! href "mailto:qinka@live.com" $ "李约瀚"
                "。"
              ,
            Loint 1 "xhskhackage" (getSvgLinked Nothing xhskHackage) $ do
              p $ a ! href (stringValue hackageUrl) $ "XHSK-Hackage"
              " 是 XHSK 架设于西电校内的 Hackage。"
              p "同步时间与次数：目前正处于测试，"
              ,
            Loint 2 "email" "Email:qinka@live.com" $ do
              a ! href "mailto:qinka@live.com" $ "qinka@live.com"
              "是 XHSK-Home主要维护着的私人邮箱。但在XHSK-Home 有对外开放邮箱之前，可通过该邮箱联系我们。",
            Loint 0.1 "dev" "开发与Repo信息" $
              div $
                p $ do
                  getSvgLinked Nothing static
                  " "
                  getSvgLinked Nothing languageHaskell
                  " "
                  getSvgLinked Nothing frameScotty
                  " "
                  getSvgLinked Nothing licenseBSD
                  " "
                  getSvgLinked Nothing repo
                  " "
                  a ! href "https://coveralls.io/github/Xidian-Haskell-Server-Keeper/XHSK-Home?branch=master" $
                    img ! src "https://coveralls.io/repos/Xidian-Haskell-Server-Keeper/XHSK-Home/badge.svg?branch=master&service=github"
                        ! alt "Coverage Status",
              Loint 4 "hackageUpload" "XHSK-Hackage账户与上传" $ do
                "目前上传并不需要任何账户，但我们计划添加这一功能。"
                "而且XHSK－Hackage的账户 与 hackage.haskell.org的账户并不通用、相等。"
            ]


      sortLoint :: (Num a , Ord a)=> LointList a -> LointList a
      sortLoint [] = []
      sortLoint (x@(Loint i _ _ _):xs) =
        let smallerOrEq = [b | b@(Loint bi _ _ _) <- xs ,bi <= i ]
            larger = [b | b@(Loint bi _ _ _) <- xs ,bi > i ]
        in sortLoint smallerOrEq ++ [x] ++ sortLoint larger


      instance (Show a ,ToMarkup a)=> ToMarkup (Loint a) where
        toMarkup (Loint id _ title str) = div $ do
            h3 $ a ! name (stringValue numStr) $ do
              "== Loint[" :: Html
              toHtml id
              "] == " ::Html
              title
            str
          where
            numStr =  "LOINT-" ++ show id
