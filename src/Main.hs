{-# LANGUAGE OverloadedStrings #-}

module Main
	(
	main
	) where

		import Web.Scotty
		import qualified Data.Text as T

		import Pages.Home
		import Pages.Null --404
		import Pages.Donate
		import Pages.Document

		main = do
			putStrLn "XHSK-Home begin!"
			scotty 3000 $ do
				get "/"  homePage
				get "/document" documentPage
				delete "/" $ do
					text "nothings"
				get "/404" nullPage
				get "/donate" donatePage
				notFound $ nullPage
			putStrLn "XHSK-Home end !"
