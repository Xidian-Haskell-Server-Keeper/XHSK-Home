#!/bin/bash

###############################################################################
##
##  XHSK-Home  沙盒中的启动脚本
##
###############################################################################

if [-n $1]
  then
    case $1 in
      start) doStart
      stop) doStop
      restart) doRestart
    esac
    exit
  else
    echo "XHSK-Home-Website维护工具"
    echo "\tstart 开启"
    echo "\tstop 停止"
    echo "\trestart 更新重启"
    exit
fi

##########
#function#
##########
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
  GPOUTPUT=$(git pull origin)
  if [-n "$GPOUTPUT"]
    then
    echo "同步成功"
    return 1
  else
    echo "同步失败"
    return 0
}

function bin_run()
{
  nothing=$(.cabal-sandbox/bin/XHSK-Home.Bin) &
}

function bin_kill()
{
  killid=$(pgrep XHSK-Home.Bin)
  kill -9 $killid
}

function  doStart ()
{
  RTa=git_pull
  if 
}
