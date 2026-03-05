#!/bin/bash

set -e
ABSFile=`realpath $0`
ExecPath=`realpath "$(dirname $ABSFile)"`
rm -rf $ExecPath/.vim/pack/plugins/start
mkdir -p $ExecPath/.vim/pack/plugins/start && cd $ExecPath/.vim/pack/plugins/start
for github in `cat $ExecPath/vim_plugins.ini` ; do
 git clone $github
done

#用elixir-ls 0.14.6, 支持elixir1.12.3
#cd $ExecPath/.vim/bundle/vim-lsp-settings/ && git checkout 63d1d31
#cd $ExecPath

# 获取当前日期和时间，并格式化为YYYY-MM-DD_HH-MM-SS的形式
CurrentDate=$(date +"%Y-%m-%d_%H-%M-%S")
#兼容mac
VimrcFPath=$(realpath ~/.vimrc || echo "")
VimDPath=$(realpath ~/.vim || echo "")
# 使用日期来修改文件名
#备份.vimrc
if [ "${VimrcFPath}X" != "X" ] && [ -f $VimrcFPath ]; then
  echo "已备份为：${VimrcFPath}_${CurrentDate}"
  mv $VimrcFPath ${VimrcFPath}_${CurrentDate}
else
  echo ".vimrc不存在, 不需要备份"
fi

#备份.vim目录
if [ "${VimDPath}X" != "X" ] && [ -d $VimDPath ]; then
  mv $VimDPath "${VimDPath}_${CurrentDate}"
  echo "已备份为：${VimDPath}_${CurrentDate}"
else
  echo ".vim目录不存在, 不需要备份"
fi
cd $ExecPath
cp -rf ./.vimrc ~/
cp -rf ./.vim ~/
