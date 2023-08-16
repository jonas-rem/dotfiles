.PHONY: config

config:
	# NVIM
	cp config/init.lua ~/.config/nvim
	mkdir -p ~/.config/nvim/lua
	rm -f ~/.config/nvim/lua/*
	cp config/lua/* ~/.config/nvim/lua/
	# Kitty
	cp -r config/kitty ~/.config/
	# Ctags
	cp config/options.ctags ~/.ctags.d/
	# Clangd user config
	cp config/clangd/.clangd ~/

all: config
