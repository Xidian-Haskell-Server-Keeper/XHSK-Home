
{-# LANGUAGE OverloadedStrings #-}

module Pages
    (
    homeGuide,homePage,
    documentPage,documentGuide,
    donatePage,donateGuide,
    nullPage,
    lointPage
    ) where

      import Prelude hiding (div)

      import Frame()
      import Loint(sortLoint,lointData,addLointLink)
      import UnSafe(hackageUrl)

      import Text.Blaze.Html((!),toHtml)
      import Text.Blaze.Internal(string,stringValue)
      import Text.Blaze.Html5(
          Html,hr,p,a,ul,li,h1,h2,h3,h4,div
        )
      import Text.Blaze.Html5.Attributes(
          name,href
        )


      lointPage :: Html
      lointPage = mconcat $ map toHtml $ sortLoint lointData

      nullPage :: Html
      nullPage = do
        p " Sorry "
        p "少思八九，常想一二"

      documentGuide :: Maybe[(String,String)]
      documentGuide =  Just [
        ("ghc","GHC"),
        ("xhskhackage","XHSK-Hackage")
        ]

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
        h3 $ a ! name "xhskhackage" $ "XHSK-Hackage"
        div $ do
          h4 "使用"
          p $ do
            "在 Cabal 的 config（配置文件） 中相对 hackage.haskell.org 添加一个 基于 XHSK－Hackage 的数据即可。"
            "添加类似：remote-repo: XHSK-Hackage:http://xhsk-hackage-url/packages/archive"
          p $ do
            "之后可直接使用 cabal update，更新。"
            "或者通过在网站上下载＊.tar.gz文件在通过 cabal-install 安装即可"
          h4 "注册账户"
          p $ do
            "注册账户的方法目前只有通过直接向"
            a ! href "mailto:qinka@live.com?subject=XHSK-Hackage%20上传账户申请&body=%0dXHSK-Hackage账户申请%0d申请账户名：%0d申请密码%0d联系邮箱："
              $ "qinka@live.com"
            "发送邮件申请获得。XHSK－Hackage中的邮件申请功能目前无法使用，其不会发送邮件到指定的邮箱中。邮件要求发送以下内容："
            ul $ do
              li "申请的账户名（如果有重名则会发回邮件要求重添）。"
              li "申请账户的密码（可以不填，则要求自己修改）。"
              li "联系方式，邮箱（可以直接填写qq号，西电校内的邮箱直接通过审核）。"
              li "审核信息，写明您的身份信息（包括所在学院，班级姓名，学号等，以便我们何时您的真实身份），同时我们保证您的信息不会被泄漏。"
              li "无关信息，方便我们了解您，同时对您进行审核（包括Github的账号）。"
              li "特殊说明（选），如果您有特殊需求，可以在此选填。"
            "我们会在收到邮件之后为您审核，由于目前处于测试状态，审核速度将变得不定。"
          p "注册账户的目的"
          p "注册账户的目的主要是向 XHSK－Hackage 中上传包。而如何制作包请查阅互联网。"
          h4 "上传 包"
          p $ do
            "上传一个使用Cabal的包到XHSK-Hackage,需要做如下几件事。"
            "注"
            addLointLink "hackageUpload"
          ul $ do
            li "使用 cabal 对已经写好的包使用 cabal sdist 进行分发，得到 *.tag.gz  的文件。"
            li "使用命令 cabal update --check 对其进行检查，查看是否符合要求。"
            li "使用 cabal update 或到 XHSK－Hackage 上的 Upload 中上传。且两者均需要用户名和密码。"


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
            "同时我们也接受"
            a ! href "/donate" $ "捐助"
            "。"
          p $ do
            "更多参见"
            addLointLink "xhskhome"
        hr
        h3 $ a ! name "hackage" $"Hackage"
        div $ do
          h4 "使用Hackage"
          p $ do
            "XHSK-Hackage 是"
            a ! href "http://hackage.haskell.org" $ "Hackage"
            "的镜像。是Haskell中不可缺少的一部分。Haskell 编写成的绝大部分软体、程序与库，都是通过 Hackage 分发给世界各地的用户。"
          p $ do
            "Hackage 的分发是直接分发代码，并通过 Cabal 装。"
          p $ do
            "XHSK-Hackage 的网址："
            a ! href (stringValue hackageUrl) $ "XHSK-Hackage"
          h4 $ do
            "更多的信息请"
            a ! href "/document#xhskhackage" $ "访问这里"
            "。"
        hr
        h3 $ a ! name "about" $"其他"
        div $ do
          "Copyright (C) 2015 XHSK"
          p $ do
            "其他详见"
            addLointLink "dev"
