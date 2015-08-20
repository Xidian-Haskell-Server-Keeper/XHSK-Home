{-# LANGUAGE OverloadedStrings #-}

module Common.Header
    (
      pagesHeader,
      pagesGuide
    ) where
      import Text.Blaze.Internal(stringValue,string)
      import Prelude hiding (div,head)
      import Web.Scotty(ActionM,html)
      import Text.Blaze.Html((!),toHtml)
      import Text.Blaze.Html.Renderer.Text(renderHtml)
      import Text.Blaze.Html5.Attributes(style,href,name)
      import Text.Blaze.Html4.Transitional.Attributes (align)
      import Text.Blaze.Html5(Html,header,nav,h1,br,p,div,head,title,h2,hr,a,b,h3,ul,li)



      pagesHeader :: Html
      pagesHeader = do
        hr
        header $ do
          "西电Hackage镜像站维护组主页"
          nav $ do
            h3 "导航"
            div $ do
              mconcat $ map (break.makeLink)[
                  ("/","首页"),
                  ("/document","文档"),
                  ("/donate","捐助")
                ]
                where
                  break :: Html -> Html ->Html
                  break x = return x >>= "  "
        hr
        hr

      makeLink :: [(String,String)] -> Html
      makeLink (x,y) = a ! href path $ toHtml y
        where
          path = stringValue x

      pagesGuide :: [(String,String)] -> Html
      pagesGuide x = do
        h3 $ a ! name "guide" $ "目录"
        ul $ do
          mconcat $ map ((li $).makeLink) x

      metasettings :: Html
      metasettings = do
        meta ! content "width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" ! name "viewport"

