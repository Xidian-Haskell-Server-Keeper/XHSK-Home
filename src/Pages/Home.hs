{-# LANGUAGE OverloadedStrings #-}

module Pages.Home
  (
    homePage
  ) where
    import Prelude hiding (div,head)
    import Web.Scotty(ActionM,html)
    import Text.Blaze.Html5
      (body,h1,br,p,div,head,title,h2,hr,b,h3,a,ul,li)
    import Text.Blaze.Html((!))
    import Text.Blaze.Html.Renderer.Text(renderHtml)
    import Text.Blaze.Html5.Attributes(style,href,name)
    import Text.Blaze.Html4.Transitional.Attributes (align)
    import Utils(blaze)
    import Common.Header(pagesHeader,pagesGuide,metasettings)

    homePage :: ActionM ()
    homePage = blaze $ do
      head $ do
        metasettings
        title "XHSK-Home"
      body $do
        pagesHeader
        h1 ! align "center" $ "西电Hackage镜像站维护组主页"
        h2 ! align "center" $ "XHSK-Home"
        hr
        hr
        pagesGuide [
              ("info","简介"),
              ("hackage","Hackage"),
              ("about","其他")
            ]
        hr
        h3 $ a ! name "info" $  "简介"
        div $ do
          p $  do
            "XHSK 是 Xidian Haskell Server Keeper 的简写。"
            "意在为校内师生于校外同志提供一些与Haskell有关的服务，"
            "同时尝试为校内师生提供一些学习Haskell的资料。"
          p $ do
            "XHSK，也就是西电Hackage维护社团目前隶属于西安电子科技大学软件学院141301401班团支部。"
            "创建人"
            a ! href "mailto:qinka@live.com" $ "李约瀚"
            "。同时我们也接受"
            a ! href "/donate" $ "捐助"
            "。"
        hr
        h3 $ a ! name "hackage" $"Hackage"
        hr
        h3 $ a ! name "about" $"其他"
        div $ do
          "Copyright (C) 2015 XHSK"
          p $ do
            "This website is written in Haskell."
          p $ do
            "这个网站用Haskell编写。"
          p $ do
            "网站代码依托关于GitHub  "
            a ! href "https://github.com/Xidian-Haskell-Server-Keeper/XHSK-Home" $
              "Repo : XHSK-Home"
            "。"
