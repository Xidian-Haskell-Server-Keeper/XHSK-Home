#!/bin/bash

###############################################################################
##
##  XHSK-Home  沙盒中的启动脚本
##
###############################################################################

function cabal_install ()
{
  echo "XHSK-Home 编译"
  CIOP=$(cabal install XHSK-Home/ | grep "XHSK-Home" Install* |cat)
  if [-n "$CIOP"]
    then
      echo "编译完成"
      return 1
    else
      echo "编译失败"
      return 0
}

function git_pull ()
{
  echo "Git Pull"

}

function isUPtpDATE ()
{
  GPOUTPUT=$(git pull origin | grep "Already up-to-date.")
  if [-n "$GPOUTPUT"]
    then
    echo $GPOUTPUT
    return 1
  else
    echo 
}
