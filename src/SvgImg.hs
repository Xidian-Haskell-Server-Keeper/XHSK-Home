{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}




module SvgImg
    (
    getSvgPath,
    getSvgLinked,
    SvgShields(..),
    eval
    ) where

      import Utils(blazeSvg)

      import Web.Scotty(ActionM)

      import Text.Blaze(AttributeValue,stringValue,ToMarkup)
      import Text.Blaze.Html(Html,(!))
      import Text.Blaze.Html5(a,img)
      import Text.Blaze.Html5.Attributes(href,src)
      import Text.Blaze.Svg(Svg)
      import Text.Blaze.Svg.Shields(
        plasticStyle,
        flatStyle,
        socialStyle,
        flatSquareStyle
        )
      import Data.Text.Lazy(unpack)
      import Data.Text.Internal.Lazy(Text)


      getSvgPath :: String -> AttributeValue
      getSvgPath = stringValue . ("/site-status/d04f22c10b926df403ded5aca2668ad4/"++)

      getSvgLinked :: String -> String -> Html
      getSvgLinked x y =
        a ! href (stringValue x) $
          img ! src (getSvgPath y)

      data SvgShields a b where
        PlasticStyle ::(Show a,ToMarkup a,Read a,Show b,Floating b,Read b) =>
                       (a,b) -> (a,b) -> Maybe String -> Maybe String -> SvgShields a b
        FlatStyle ::(Show a,ToMarkup a,Read a,Show b,Floating b,Read b) =>
                    (a,b) -> (a,b) -> Maybe String -> Maybe String -> SvgShields a b
        FlatSquareStyle ::(Show a,ToMarkup a,Read a,Show b,Floating b,Read b) =>
                          (a,b) -> (a,b) -> Maybe String -> Maybe String -> SvgShields a b
        SocialStyle ::(Show a,ToMarkup a,Read a,Show b,Floating b,Read b) =>
                      (a,b) -> (a,b) -> Maybe String -> Maybe String -> Maybe String -> SvgShields a b

      instance (Read a,Read b) => Read (SvgShields a b) where
        readsPrec = error "no!!!!!!!!!!!!"

      eval' :: Text -> Svg
      eval' url= case ssData of
        PlasticStyle (l,lp) (r,rp) cA cB ->
          plasticStyle (l,lp) (r,rp) cA cB
        FlatStyle (l,lp) (r,rp) cA cB ->
          flatStyle (l,lp) (r,rp) cA cB
        FlatSquareStyle (l,lp) (r,rp) cA cB ->
          flatSquareStyle (l,lp) (r,rp) cA cB
        SocialStyle (l,lp) (r,rp) cA cB u ->
          socialStyle (l,lp) (r,rp) cA cB u
        where
          ssData = read url' ::SvgShields Double Double
          url' = unpack url
      eval :: Text -> ActionM ()
      eval = blazeSvg . eval'

{-
$ md5
SvgShields
ea79ac5f8cb5d58613cbfa9cbd451096


d04f22c10b926df403ded5aca2668ad4 -- svgimg's md5
-}
