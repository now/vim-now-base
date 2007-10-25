# contents: Vim NOW Base Library Makefile.
#
# Copyright © 2006 Nikolai Weibull <now@bitwi.se>

uname_O := $(shell uname -o 2>/dev/null || echo nothing)

DESTDIR = $(HOME)/.vim

INSTALL = install

ifeq ($(uname_O),Cygwin)
	DESTDIR = $(HOME)/vimfiles
endif

DIRS = \
       autoload \
       autoload/now \
       autoload/now/system \
       autoload/now/utilities \
       autoload/now/vim

doc_FILES =

lib_FILES = \
	    autoload/now/file.vim \
	    autoload/now/mbc.vim \
	    autoload/now/regex.vim \
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

plugin_FILES = 

FILES = \
	$(doc_FILES) \
	$(lib_FILES) \
	$(plugin_FILES)

dest_DIRS = $(addprefix $(DESTDIR)/,$(DIRS))

dest_FILES = $(addprefix $(DESTDIR)/,$(FILES))

-include config.mk

.PHONY: all install

all:
	@echo Please run “make install” to install files.

install: $(dest_DIRS) $(dest_FILES)

$(DESTDIR)/%: %
	$(INSTALL) --mode=644 $< $@

$(dest_DIRS):
	$(INSTALL) --directory --mode=755 $@

#make-vim-home-directory-file: 
#	vim -c 'call setline(1, substitute(&rtp, "^\\([^\\,]\\+\\%(\\\\,[^\\,]*\\)*\\),.*$$", "\\1", "")) | w! .vim-home-directory | quit'
