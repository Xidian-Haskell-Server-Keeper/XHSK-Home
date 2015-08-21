{-# LANGUAGE OverloadedStrings #-}

module Pages.Document
    (
    documentPage
    ) where
      import Prelude hiding (div,head)
      import Web.Scotty(ActionM,html)
      import Common.Header(pagesHeader,pagesGuide)
      import Utils(blaze)
      import Text.Blaze.Html((!))
      import Text.Blaze.Html.Renderer.Text(renderHtml)
      import Text.Blaze.Html5.Attributes(style,href,name)
      import Text.Blaze.Html4.Transitional.Attributes (align)
      import Text.Blaze.Html5(body,h1,br,p,div,head,title,h2,hr,b,h3,a,ul,li)

      documentPage :: ActionM ()
      documentPage = blaze $ do
        head $ do
          title "Document"
        body $ do
          pagesHeader "文档" "Documents" []
