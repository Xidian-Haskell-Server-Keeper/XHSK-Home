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
      import Text.Blaze.Html5(body,h1,br,p,div,head,title,h2,hr,b,h3,a,ul,li,h4)
      import Text.Blaze.Internal(stringValue)

      documentPage :: ActionM ()
      documentPage = blaze $ do
        head $ do
          metasettings
          title "Document"
        body $ do
          pagesHeader "文档" "Documents" []
          p $ do
            "更多资料详见："
            ul $ do
              li $ a ! href "http://www.haskell.org/ghc/" $ "GHC Home Page"
              li $ a ! href "http://ghc.haskell.org/trac/ghc/" $ "GHC Developers Home"
          h3 $ a ! name "ghc" $ "Glasgow Haskell Compilation's Document"
          div $ do
            h4 "7.10.2"
            ul $ do
              li $ a ! href "/docs/haskell-platform-7.10.2/users_guide/index.html" $
                "The User's Guide"
              li $ a ! href "/docs/haskell-platform-7.10.2/libraries/index.html" $
                "Libraries"
              li $ a ! href "/docs/haskell-platform-7.10.2/libraries/ghc-7.10.2/index.html" $
                "GHC API"

      docsLink :: FilePath -> FilePath
      docsLink v = "./XHSK-Doc/" ++ v
