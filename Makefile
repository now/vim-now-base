# contents: Vim NOW Base Library Makefile.
#
# Copyright © 2006 Nikolai Weibull <now@bitwi.se>

FILES = \
	autoload/now/file.vim \
	autoload/now/list.vim \
	autoload/now/mbc.vim \
	autoload/now/regex.vim \
	autoload/now/string.vim \
	autoload/now/system/network.vim \
	autoload/now/system/passwd.vim \
	autoload/now/system/user.vim \
	autoload/now/utilities/list.vim \
	autoload/now/vim.vim \
	autoload/now/vim/buffer.vim \
	autoload/now/vim/buffers.vim \
	autoload/now/vim/mark.vim \
	autoload/now/vim/motion.vim \
	autoload/now/vim/point.vim \
	autoload/now/vim/range.vim \
	autoload/now/vim/settings.vim \
	autoload/now/vim/window.vim \
	autoload/now/vim/windows.vim

include vim.mk
