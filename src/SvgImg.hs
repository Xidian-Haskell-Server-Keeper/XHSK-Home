{-#LANGUAGE OverloadedStrings #-}




module SvgImg
    (
    --frameScotty,
    getSvgPath,
    getSvgLinked
    ) where


      import Text.Blaze(AttributeValue,stringValue)
      import Text.Blaze.Html(Html,(!))
      import Text.Blaze.Html5(a,img)
      import Text.Blaze.Html5.Attributes(href,src)

      getSvgPath :: String -> AttributeValue
      getSvgPath = stringValue . ("/site-status/d04f22c10b926df403ded5aca2668ad4/"++)

      getSvgLinked :: String -> String -> Html
      getSvgLinked x y =
        a ! href (stringValue x) $
          img ! src (getSvgPath y)



-- d04f22c10b926df403ded5aca2668ad4 -- svgimg's md5ßß
{-
      import Prelude hiding (id)
      import Text.Blaze.Html((!))
      import Text.Blaze.Html5.Attributes(xmlns)
      import Text.Blaze.Svg(Svg)
      import Text.Blaze.Svg11(
        svg,lineargradient,stop,rect,g,path,text_
        )
      import Text.Blaze.Svg11.Attributes(
        width,height,x2,y2,offset,stopColor,stopOpacity,id_,
        rx,fill,d,textAnchor,fontFamily,fontSize,x,y,fillOpacity
        )
      import qualified Text.Blaze.Svg11 as S11
      import qualified Text.Blaze.Svg11.Attributes as S11A

      frameScotty :: Svg
      frameScotty = do
        svg ! xmlns "http://www.w3.org/2000/svg" ! width "92" ! height "20" $ do
          lineargradient ! id_ "b" ! x2 "0" ! y2 "100%" $ do
            stop ! offset "0" ! stopColor"#bbb" ! stopOpacity ".1"
            stop ! offset "1" ! stopOpacity ".1"
          S11.mask ! id_ "a" $ do
            rect ! width "92" ! height "20" ! rx "3" ! fill "#fff"
          g ! S11A.mask "url(#a)" $ do
            path ! fill "#555" ! d "M0 0h46v20H0z"
            path ! fill "#ff69b4" ! d "M46 0h46v20H46z"
            path ! fill "url(#b)" ! d "M0 0h92v20H0z"
          g ! fill "#fff" ! textAnchor "middle" ! fontFamily "DejaVu Sans,Verdana,Geneva,sans-serif" ! fontSize "11" $ do
            text_ ! x "23" ! y "15" ! fill "#010101" ! fillOpacity ".3" $ do
              "Frame"
            text_ ! x "23" ! y "14" $ do
              "Frame"
            text_ ! x "68" ! y "15" ! fill "#010101" ! fillOpacity ".3" $ do
              "Scotty"
            text_ ! x "68" ! y "14" $ do
              "Scotty"
-}
