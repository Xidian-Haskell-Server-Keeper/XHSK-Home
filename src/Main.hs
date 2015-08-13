{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty

main = scotty 3000 $ do
	get "/" $ do
		html "hello,world!"
	get "/he" $ do
		html "haha !"