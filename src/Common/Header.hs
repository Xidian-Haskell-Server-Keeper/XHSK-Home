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
              a ! href "/" $ "首页"
              "  "
              a ! href "/document" $ "文档"
              "  "
              a ! href "/donate" $ "捐助"
        hr
        hr

      pagesGuide :: [(String,String)] -> Html
      pagesGuide x = do
        h3 $ a ! name "guide" $ "目录"
        ul $ do
          mconcat $ map guideToHtml x

      guideToHtml :: (String,String) -> Html
      guideToHtml (x,y) =
        li $ a ! href tag $ toHtml y
        where
          tag = stringValue $ '#':x
