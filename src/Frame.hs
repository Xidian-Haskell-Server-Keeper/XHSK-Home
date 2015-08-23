{-# LANGUAGE OverloadedStrings #-}

module Frame
    (
    Title(..),
    metasettings,
    makeLink,
    pagesLinks,
    pageFrame
    ) where

      import Prelude hiding (div,head,break)
      import Utils (blaze)

      import Web.Scotty(ActionM)
      import Text.Blaze.Internal(string,stringValue)
      import Text.Blaze.Html((!),toHtml)
      import Text.Blaze.Html4.Transitional.Attributes (align)
      import Text.Blaze.Html5(
          Html,hr,p,b,head,title,meta,header,
          nav,a,body,h1,h2,h3,div,ul,li,img
        )
      import Text.Blaze.Html5.Attributes(
          href,name,content,name,src
        )


      data Title = Title String String String

      metasettings :: Html
      metasettings = meta
          ! content
            "width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no"
          ! name "viewport"

      break :: Html -> Html
      break x = do
        "   "
        x
      makeLink :: (String,String) -> Html
      makeLink (x,y) = a ! href path $ toHtml y
        where
          path = stringValue x
      pagesLinks :: [(String,String)]
      pagesLinks = [
          ("/","首页"),
          ("/document","文档"),
          ("/donate","捐助")
        ]

      pageFrame :: Title                     -- title
             -> Maybe [(String,String)]   -- Guide
             -> Html                      -- 网页内部
             -> Maybe String              -- 网站 状态 提示
             -> ActionM ()

      pageFrame  t@(Title cnT enT webT) g mainPart info = blaze $ do
        head $ do
          metasettings
          title $ string webT
        body $ do
          p ! src ".maintain.plan" $ ""
          hr
          header $ do
            case info of
              Just x -> do
                p $ string x
                "西电Hackage镜像站维护组主页"
              Nothing -> b "西电Hackage镜像站维护组主页"
          nav $ do
            h3 "导航"
            div $ mconcat $ map (break.makeLink) pagesLinks
          hr
          h1 ! align "center" $ toHtml cnT
          h2 ! align "center" $ toHtml enT
          hr
          hr
          case g of
            Nothing -> ""
            Just g' -> do
              h3 $ a ! name "guide" $ "目录"
              ul $ do
                mconcat $
                  map (li.makeLink.
                      (\(urlLink,display) -> ('#':urlLink,display))
                    ) g'
              hr
          mainPart
          hr
          p ! align "right" $ "Powered by Scotty · Copyright 2015 XHSK"
