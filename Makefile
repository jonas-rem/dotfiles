.PHONY: config

config:
	mkdir -p ~/.config/nvim/lua
	cp config/lua/lspinstall.lua ~/.config/nvim/lua
	cp config/init.vim ~/.config/nvim
	cp config/options.ctags ~/.ctags.d/

all: config
