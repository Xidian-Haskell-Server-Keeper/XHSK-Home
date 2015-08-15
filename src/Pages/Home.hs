{-# LANGUAGE OverloadedStrings #-}

module Pages.Home where
import Prelude hiding (div,head)
import Web.Scotty(ActionM)
import Text.Blaze.Html5
  (body,h1,br,p,div,head,title,h2,hr,b)
import Text.Blaze.Html
import Text.Blaze.Html.Renderer.Text(renderHtml)
import Text.Blaze.Html5.Attributes(style)
import Text.Blaze.Html4.Transitional.Attributes (align)
import Utils


homePage :: ActionM ()
homePage = blaze $ do
  head $ do
    title "XHSK-Home"
  body $do
    h1 ! align "center" $ "西电Hackage镜像站维护组主页"
    h2 ! align "center" $ "XHSK-Home"
    hr
    div $ do
      p $ b "hello,world"
