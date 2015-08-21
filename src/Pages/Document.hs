{-# LANGUAGE OverloadedStrings #-}

module Pages.Document
    (
    documentPage,
    docsLink
    ) where
      import Prelude hiding (div,head)
      import Web.Scotty(ActionM,html)
      import Common.Header(pagesHeader,pagesGuide,metasettings)
      import Utils(blaze)
      import Text.Blaze.Html((!))
      import Text.Blaze.Html.Renderer.Text(renderHtml)
      import Text.Blaze.Html5.Attributes(style,href,name)
      import Text.Blaze.Html4.Transitional.Attributes (align)
      import Text.Blaze.Html5(body,h1,br,p,div,head,title,h2,hr,b,h3,a,ul,li)
      import Text.Blaze.Internal(stringValue)

      documentPage :: ActionM ()
      documentPage = blaze $ do
        head $ do
          title "Document"
          metasettings
        body $ do
          pagesHeader "文档" "Documents" []
          h3 $ a ! name "ghc" $ "Glasgow Haskell Compilation's Document"
          div $ do
            ul $ do
              li $ a ! href "/docs/haskell-platform-7.10.2/users_guide/index.html" $ "s"

      docsLink :: FilePath -> FilePath
      docsLink v = "../XHSK-Doc/" ++ v
