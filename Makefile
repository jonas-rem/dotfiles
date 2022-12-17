.PHONY: config

config:
	cp config/init.vim ~/.config/nvim/
	cp config/options.ctags ~/.ctags.d/

all: config
