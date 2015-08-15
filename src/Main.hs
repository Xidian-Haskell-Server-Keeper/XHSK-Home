{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty

import Pages.Home
import Pages.Null --404

main = scotty 3000 $ do
	get "/"  homePage
	get "/404" nullPage
	notFound $ nullPage



{-
	delete "/" $ do
  	html "deleted!"
	post "/" $ do
  	html "posted!"
	put "/" $ do
  	html "put-ted!"
		get "/he" $ do
			html "haha !"-}
