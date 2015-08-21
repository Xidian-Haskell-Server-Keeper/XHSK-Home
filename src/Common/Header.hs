{-# LANGUAGE OverloadedStrings #-}

module Common.Header
    (
      pagesHeader,
      pagesGuide,
      metasettings
    ) where
      import Text.Blaze.Internal(stringValue,string)
      import Prelude hiding (div,head)
      import Web.Scotty(ActionM,html)
      import Text.Blaze.Html((!),toHtml)
      import Text.Blaze.Html.Renderer.Text(renderHtml)
      import Text.Blaze.Html5.Attributes(style,href,name,content,name)
      import Text.Blaze.Html4.Transitional.Attributes (align)
      import Text.Blaze.Html5(Html,header,nav,h1,br,p,div,head,title,h2,hr,a,b,h3,ul,li,meta)
      import Common.HeaderMaintain(maintainTime)
      import System.IO.Unsafe

      pagesHeader :: String -> String -> [(String,String)] -> Html
      pagesHeader cnTitle enTitle guide = do
        hr
        header $ do
          "西电Hackage镜像站维护组主页"
          toHtml $ unsafePerformIO $ maintainTime
          nav $ do
            h3 "导航"
            div $ do
              mconcat $ map (break.makeLink)[
                  ("/","首页"),
                  ("/document","文档"),
                  ("/donate","捐助")
                ]
        hr
        h1 ! align "center" $ toHtml cnTitle
        h2 ! align "center" $ toHtml enTitle
        hr
        hr
        pagesGuide guide
        hr
        where
          break :: Html -> Html
          break x = do
            "   "
            x

      makeLink :: (String,String) -> Html
      makeLink (x,y) = a ! href path $ toHtml y
        where
          path = stringValue x

      pagesGuide :: [(String,String)] -> Html
      pagesGuide x = do
        h3 $ a ! name "guide" $ "目录"
        ul $ do
          mconcat $ map ((li $).makeLink.addSharp) x
        where
          addSharp (x,y) = ('#':x,y)

      metasettings :: Html
      metasettings = do
        meta ! content "width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" ! name "viewport"
