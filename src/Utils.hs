{-# LANGUAGE OverloadedStrings #-}

module Utils (
pet,
blaze,
blazeSvg
)where

import           Text.Blaze.Html.Renderer.Text (renderHtml)
import           Text.Blaze.Html5              (Html)
import           Text.Blaze.Internal           (preEscapedText)
import           Web.Scotty                    (ActionM,html,setHeader,raw)

import           Text.Blaze.Svg(Svg)
import           Text.Blaze.Svg.Renderer.Utf8  (renderSvg)

pet = preEscapedText

blaze :: Html -> ActionM ()
blaze = html . renderHtml

blazeSvg :: Svg -> ActionM ()
blazeSvg img = do
  setHeader "Content-Type" "image/svg+xml"--"text/xml"
  raw.renderSvg $ img
