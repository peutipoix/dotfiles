#!/bin/bash

DF_DIR=${PWD}/dotfiles

[ ! -d ${DF_DIR} ] && return 1;

[ -e ${DF_DIR}/.vim.tgz ] && [ ! -d ${DF_DIR}/.vim ] && pushd ${DF_DIR} && /bin/tar -xzf .vim.tgz && popd

for df in \
	.gitconfig \
	.vimrc \
	.viminfo \
	.vim \
	.bashrc \
	.bashrc.d ; do
	[ -e ${HOME}/${df} ] && [ ! -h ${HOME}/${df} ] && [ ! -e ${HOME}/${df}.orig ] && mv ${HOME}/${df} ${HOME}/${df}.orig
	ln -s ${DF_DIR}/${df} ${HOME}/${df}
	[ $? -eq 0 ] && echo "setup successfully ${df}"
done

