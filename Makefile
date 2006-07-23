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
       lib \
       lib/now \
       lib/now/system \
       lib/now/vim

doc_FILES =

lib_FILES = \
	    lib/now.vim \
	    lib/now/file.vim \
	    lib/now/mbc.vim \
	    lib/now/system.vim \
	    lib/now/system/network.vim \
	    lib/now/system/passwd.vim \
	    lib/now/system/user.vim \
	    lib/now/vim.vim \
	    lib/now/vim/motion.vim \
	    lib/now/vim/position.vim

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
