{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty
import qualified Data.Text as T

import Pages.Home
import Pages.Null --404

main = do
	putStrLn "XHSK-Home begin!"
	scotty 3000 $ do
		get "/"  homePage
		get "/404" nullPage
		notFound $ nullPage
	putStrLn "XHSK-Home end !"



{-
	delete "/" $ do
  	html "deleted!"
	post "/" $ do
  	html "posted!"
	put "/" $ do
  	html "put-ted!"
		get "/he" $ do
			html "haha !"-}
