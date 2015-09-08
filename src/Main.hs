{-# LANGUAGE OverloadedStrings #-}

module Main
	(
	main
	) where

		import Web.Scotty
		import System.Directory(getCurrentDirectory,doesFileExist)

		import Frame(pageFrame,Title(..))
		import Pages(
				homeGuide,homePage,
				documentPage,documentGuide,
				donatePage,donateGuide,
				nullPage,
				lointPage
			)

		import SvgImg(eval)
		import Utils()

		docsLink :: FilePath -> FilePath
		docsLink v = "./XHSK-Doc" ++ v

		webStatus :: Bool
		webStatus = True



		main :: IO ()
		main = do
			getCurrentDirectory >>= putStrLn
			putStrLn "XHSK-Home begin!"
			scotty 3000 $ do
				get "/" $ pageFrame
					(Title "西电Hackage镜像站维护组主页" "XHSK-Home" "XHSK-Home")
					homeGuide
					homePage
					webStatus
				get "/document" $ pageFrame
					(Title "文档" "Documents" "Documents")
					documentGuide
					documentPage
					webStatus
			 	get "/donate" $ pageFrame
					(Title "捐助" "DONATE!" "DONATE!")
					donateGuide
					donatePage
					webStatus
				get "/loint" $ pageFrame
					(Title "端点录" "Loint" "LOINT")
					Nothing
					lointPage
					webStatus
				get "/site-status" $ do
					setHeader "Content-Type" "text/plain"
					file "./.maintain.plan"
				--logo
				get "/site-status/d04f22c10b926df403ded5aca2668ad4/:arg" $ do
					filename <- param "arg"
					setHeader "Content-Type" "image/svg+xml"
					file $ "./statusLogo/" ++ filename ++ ".svg"
				get (regex "^/docs(.*)") $ do
   					cap <- param "1"
   					file $ docsLink cap
				get "/e8b32bc4d7b564ac6075a1418ad8841e/ea79ac5f8cb5d58613cbfa9cbd451096/:svgarg" $ do
					svgArg <- param "svgarg"
					setHeader "Content-Type" "image/svg+xml"
					eval svgArg
				notFound $ pageFrame
					(Title "404" "访问页面无法找到。" "404")
					Nothing
					nullPage
					webStatus
			putStrLn "XHSK-Home end !"

{-
$ md5
server
e8b32bc4d7b564ac6075a1418ad8841e

-}
