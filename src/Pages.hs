{-# LANGUAGE OverloadedStrings #-}

module Pages
    (
    homeGuide,
    homePage,
    documentPage,
    documentGuide,
    donatePage,
    donateGuide,
    nullPage
    ) where

      import Prelude hiding (div)

      import Frame()
      import Text.Blaze.Html((!))
      import Text.Blaze.Html5(
          Html,hr,p,a,ul,li,h1,h2,h3,h4,div
        )
      import Text.Blaze.Html5.Attributes(
          name,href
        )


      nullPage :: Html
      nullPage = do
        p " Sorry "
        p "少思八九，常想一二"

      documentGuide :: Maybe[(String,String)]
      documentGuide = Nothing

      documentPage :: Html
      documentPage = do
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
      donateGuide :: Maybe [(String,String)]
      donateGuide = Just [
          ("forus","捐款"),
          ("useage","捐款去处"),
          ("how","如何捐款"),
          ("supervise","监督我们")
        ]
      donatePage :: Html
      donatePage = do
        h3 $ a ! name "forus" $ "为我们捐款"
        div $ do
          p "为什么我们需要捐款？"
          p $ do
            "XHSK-Home 为非盈利性组织，资金来源于XHSK自身成员和您的捐助。"
            "而本身XHSK各方面的线上与线下活动、运行设备、所使用的软件等会用到钱。"
            "但本身XHSK并无法得到来自学校的帮助。同时，捐款能使我们更好的服务于广大师生。"
          p "我们接受什么？"
          p $ do
            "我们接受货币形式捐助、物资形式的捐助、优惠方式的捐助（如：打折等）与相对有偿的捐助（如：广告），同时接受个人与公司的捐助。"
            "对于货币形式的捐助，我们接受人民币方式的现金、电汇等形式的捐助。"
            "如果捐助者捐赠的货币币种并非人民币，我们将会慎重考虑。"
            "特殊方式的充值卡（如西电校园网流量充值卡）与特殊的充值捐赠也是接受的。"
            "对于物资捐助的形式，我们接受绝大多数物资。但是捐赠者需要提前知道，"
            "我们有可能将接受到的物资再次无偿捐赠于其他慈善性的个人与组织，也有可能将其变卖。"
            "上述两种行为我们将公开其详细情况。"
            "对于优惠方式的捐赠，我们将会视情况以使用、出售、无偿捐赠等形式处理。"
            "对于相对有偿的捐助，我们将会与捐助者通过相对正式的方式协商。"
          p "我们组织的章程，将于近日公开。"
        hr
        h3 $ a ! name "useage" $ "我们如何使用捐款"
        div $ do
          p "使用捐款的明细将会公开。"
          "使用用途："
          ul $ do
            li "用于购买，更新维护服务器"
            li "购买用于同步各类资源的校园网流量"
            li "用于服务于维护中的一些基本消耗"
        hr
        h3 $ a ! name "how" $ "如何为我们捐款"
        div $ do
          "捐赠方式"
          ul $ do
            li $ do
              "目前唯一的方当面捐赠。将您需要捐赠的相关信息于联系方式以邮件发送至 "
              a ! href "mailto:qinka@live.com?subject=Donate%20to%20XHSK" $ "qinka@live.com"
              " 我们将邮件等形式告知您具体捐赠方式。"
        hr
        h3 $ a ! name "supervise" $ "监督我们"
        div $ do
          "我们将定期公开受捐赠的详细信息（不会再未经许可的情况下透漏个人信息）。公开方式待定。"

      homeGuide :: Maybe [(String,String)]
      homeGuide = Just [
            ("info","简介"),
            ("hackage","Hackage"),
            ("about","其他")
          ]
      homePage :: Html
      homePage = do
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
          p "This website is written in Haskell."
          p "这个网站用Haskell编写。"
          p $ do
            "网站代码依托关于GitHub  "
            a ! href "https://github.com/Xidian-Haskell-Server-Keeper/XHSK-Home" $
              "Repo : XHSK-Home"
            "。"
