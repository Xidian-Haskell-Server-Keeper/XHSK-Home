{-# LANGUAGE OverloadedStrings #-}




module SvgImg
    (
    getSvgPath,getSvgLinked,
    xhskHome,languageHaskell,frameScotty,xhskHackage,repo,static,licenseBSD
    ) where



      import Text.Blaze(AttributeValue,stringValue,ToMarkup)
      import Text.Blaze.Html(Html,(!))
      import Text.Blaze.Html5(a,img)
      import Text.Blaze.Html5.Attributes(href,src)
      import Text.Blaze.Svg.Shields.Url


      getSvgPath :: (Show a,ToMarkup a,Read a,Show b,Floating b,Read b) => SvgShields a b  -> AttributeValue
      getSvgPath x = stringValue $ ("/e8b32bc4d7b564ac6075a1418ad8841e/ea79ac5f8cb5d58613cbfa9cbd451096/"++) $ show x


      getSvgLinked ::(Show a,ToMarkup a,Read a,Show b,Floating b,Read b) => Maybe String -> SvgShields a b -> Html
      getSvgLinked Nothing y =
        a  $
          img ! src (getSvgPath y)

      getSvgLinked (Just x) y =
        a ! href (stringValue x) $
          img ! src (getSvgPath y)




      xhskHome,languageHaskell,frameScotty,xhskHackage,repo,static,licenseBSD:: SvgShields String Double

      xhskHome = FlatSquareStyle ("XHSK",30) ("Home",33) Nothing $ Just "007ec6"
      languageHaskell = PlasticStyle ("Language",53) ("Haskell",39) Nothing $ Just "fe7d37"
      frameScotty = PlasticStyle ("Frame",34) ("Scotty",36) Nothing $ Just "ff69b4"
      xhskHackage = FlatSquareStyle ("XHSK",30) ("Hackage",47) Nothing $ Just "007ec6"
      licenseBSD = FlatStyle ("license",40) ("BSD3",30) Nothing $ Just "9f9f9f"
      static = FlatStyle ("Website",43) ("static",32) Nothing $ Just "dfb317"
      repo = SocialStyle ("fork",20) ("star",20) Nothing Nothing Nothing





    {-  data SvgShields a b  where
        PlasticStyle ::(Show a,ToMarkup a,Read a,Show b,Floating b,Read b) =>
                       (a,b) -> (a,b) -> Maybe String -> Maybe String -> SvgShields a b
        FlatStyle ::(Show a,ToMarkup a,Read a,Show b,Floating b,Read b) =>
                    (a,b) -> (a,b) -> Maybe String -> Maybe String -> SvgShields a b
        FlatSquareStyle ::(Show a,ToMarkup a,Read a,Show b,Floating b,Read b) =>
                          (a,b) -> (a,b) -> Maybe String -> Maybe String -> SvgShields a b
        SocialStyle ::(Show a,ToMarkup a,Read a,Show b,Floating b,Read b) =>
                      (a,b) -> (a,b) -> Maybe String -> Maybe String -> Maybe String -> SvgShields a b
        deriving (Show)-}




  {-    instance (Show a,ToMarkup a,Read a,Show b,Floating b,Read b) => Read (SvgShields a b) where
        readsPrec _ str' =
          case s of
            "plastic" -> [(PlasticStyle (read $ ws!!1,read $ws!!2) (read $ ws!!3,read $ws!!4) cA cB,"")]
            "flat" -> [(FlatStyle (read $ ws!!1,read $ws!!2) (read $ ws!!3,read $ws!!4) cA cB,"")]
            "flatsquare" -> [(FlatSquareStyle (read $ ws!!1,read $ws!!2) (read $ ws!!3,read $ws!!4) cA cB,"")]
            "social" -> [(SocialStyle (read $ ws!!1,read $ws!!2) (read $ ws!!3,read $ws!!4) Nothing lA lB,"")]
            _ ->error "SvgShields:don't have this style"
          where
            str = [ if c=='/'||c=='&' then ' ' else c | c <- str']
            (s':ws) = words str ::[String]
            s ::String
            s = map (\c-> if isUpper c then toLower c else c) s'
            cB = if length ws <5 then Nothing else Just $ ws!!5
            cA = if length ws <6 then Nothing else Just $ ws!!6
            lA = cB
            lB = cA


      colorAToUrl,colorBToUrl :: Maybe String -> String
      colorAToUrl Nothing = ""
      colorAToUrl (Just color) = "/"++color
      colorBToUrl Nothing = ""
      colorBToUrl (Just color) = "/"++color

      instance (Show a,Show b) => Show (SvgShields a b) where
        show (PlasticStyle (l,lp) (r,rp) cA cB) = -- /l/lp/r/rp&stype=
          "/platics/"++show l++"/"++show lp++"/"++show r++"/"++show rp++colorAToUrl cA ++colorBToUrl cB
        show (FlatStyle (l,lp) (r,rp) cA cB) = -- /l/lp/r/rp&stype=
          "/flat/"++show l++"/"++show lp++"/"++show r++"/"++show rp++colorAToUrl cA ++colorBToUrl cB
        show (FlatSquareStyle (l,lp) (r,rp) cA cB) = -- /l/lp/r/rp&stype=
          "/flatsquare/"++show l++"/"++show lp++"/"++show r++"/"++show rp++colorAToUrl cA ++colorBToUrl cB
        show (SocialStyle (l,lp) (r,rp) cA cB _) = -- /l/lp/r/rp&stype=
          "/social++"++show l++"/"++show lp++"/"++show r++"/"++show rp++colorAToUrl cA ++colorBToUrl cB

-}
{-
$ md5
SvgShields
ea79ac5f8cb5d58613cbfa9cbd451096


d04f22c10b926df403ded5aca2668ad4 -- svgimg's md5
-}
