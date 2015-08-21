--404 Pages
{-# LANGUAGE OverloadedStrings #-}

module Pages.Null (
nullPage
)where

import Prelude hiding (div,head)
import Web.Scotty(ActionM,html)
import Text.Blaze.Html5
    (body,h1,br,p,div,head,title,h2,hr,b,h3,a,ul,li)
import Text.Blaze.Html((!))
import Text.Blaze.Html.Renderer.Text(renderHtml)
import Text.Blaze.Html5.Attributes(style,href,name)
import Text.Blaze.Html4.Transitional.Attributes (align)
import Utils(blaze)
import Common.Header(pagesHeader,metasettings)

nullPage :: ActionM ()
nullPage = blaze $ do
  head $ do
    metasettings
    title "404"
  body $ do
    pagesHeader "404" "访问页面无法找到。" []
