{-# LANGUAGE OverloadedStrings #-}

module Main
	(
	main
	) where

		import Web.Scotty
		import qualified Data.Text as T
		import System.Directory(getCurrentDirectory,doesFileExist)
		import System.IO.Unsafe

		import Data.Text.Lazy(pack)

		import Frame(pageFrame,Title(..))
		import Pages(
				homeGuide,homePage,
				documentPage,documentGuide,
				donatePage,donateGuide,
				nullPage
			)

		docsLink :: FilePath -> FilePath
		docsLink v = "./XHSK-Doc" ++ v
		webStatusIO :: IO (Maybe String)
		webStatusIO = do
			is <- doesFileExist "./.maintain.plan"
			case is of
				True -> do
					toMaybe <$> readFile "./.maintain.plan"
				False -> return Nothing
			where
				toMaybe = Just

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
				get "/site-status" $ file "./.maintain.plan"
				get (regex "^/docs(.*)") $ do
   					cap <- param "1"
   					file $ docsLink cap
				notFound $ pageFrame
					(Title "404" "访问页面无法找到。" "404")
					Nothing
					nullPage
					webStatus
			putStrLn "XHSK-Home end !"
