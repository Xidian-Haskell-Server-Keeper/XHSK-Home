{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty

import Pages.Home

main = scotty 3000 $ do
	get "/"  homePage


{-
	delete "/" $ do
  	html "deleted!"
	post "/" $ do
  	html "posted!"
	put "/" $ do
  	html "put-ted!"
		get "/he" $ do
			html "haha !"-}
