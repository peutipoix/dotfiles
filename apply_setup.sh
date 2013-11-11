#!/bin/sh

DF_DIR=${PWD}/dotfiles

[ ! -d ${DF_DIR} ] && return 1;

for df in \
	.gitconfig \
	.vimrc \
	.vim
	.bashrc \
	.bashrc.d ; do
	if [ -e ${HOME}/${df} ]; then
		mv ${HOME}/${df} ${HOME}/${df}.orig
		ln -s ${DF_DIR}/${df} ${HOME}/${df}
		[ $? -eq 0 ] && echo "setup successfully ${df}"
	fi
done
