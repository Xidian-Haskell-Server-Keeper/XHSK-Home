#!/bin/bash

###############################################################################
##
##  XHSK-Home  沙盒中的启动脚本
##
###############################################################################

##########
#function#
##########
function cabal_install ()
{
  echo "XHSK-Home 编译"
  CIOP=$( cabal install . | grep "Installed XHSK-Home" |cat )
  if [ -n "$CIOP" ]
    then
      echo "编译完成"
      return 1
    else
      echo "编译失败"
      return 0
    fi
}

function git_pull ()
{
  GPOUTPUT=$( git pull origin )
  if [ -n "$GPOUTPUT" ]
    then
    echo "同步成功"
    return 1
  else
    echo "同步失败"
    return 0
  fi
}

function bin_run()
{
  nothing=$( ../.cabal-sandbox/bin/XHSK-Home.Bin & )
}

function bin_kill()
{
  killid=$( pgrep XHSK-Home.Bin )
  kill -9 $killid
}

function  doStart ()
{
  echo "start"
  RTa=$(git_pull)
  if [ 0 == RTa ]
    then
      return 0
  fi
  RTb=$(cabal_install)
  if [ 0 == RTb ]
    then
      return 0
  fi
  RTd=$(bin_run)
  if [ 0 == RTd ]
    then
       return 0
  fi
}

function doStop ()
{
  echo "stop"
  RTc=bin_kill
  if [ 0 == RTc ]
    then
       return 0
  fi
}

function doRestart ()
{
  echo "restart"
  RTa=git_pull
  if [ 0 == RTa ]
    then
      return 0
  fi
  RTb=cabal_install
  if [ 0 == RTb ]
    then
      return 0
  fi
  RTc=bin_kill
  if [ 0 == RTc ]
    then
       return 0
  fi
  RTd=bin_run
  if [ 0 == RTd ]
    then
       return 0
  fi
}


if [ $1 ]
  then
    case $1 in
      start) doStart;;
      stop) doStop;;
      restart) doRestart;;
    esac
    exit
  else
    printf "XHSK-Home-Website维护工具\n "
    printf "\tstart 开启\n"
    printf "\tstop 停止\n"
    printf "\trestart 更新重启\n"
    exit
fi
