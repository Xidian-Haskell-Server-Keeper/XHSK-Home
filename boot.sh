#!/bin/bash

###############################################################################
##
##  XHSK-Home  沙盒中的启动脚本
##
###############################################################################

function cabal_install ()
{
  echo "XHSK-Home 编译"
  cabal install XHSK-Home/ -O2 --make | grep 'XHSK-Home' Install*
  echo "编译完成"
}
