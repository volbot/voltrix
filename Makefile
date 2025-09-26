.PHONY: all json kitty alacritty nvim vim clean

all: json kitty alacritty nvim vim helix base16 fish

nvim: json
	bash scripts/make.sh 'nvim'
	cp build/nvim/voltrix_generated.lua voltrix.nvim/lua/voltrix_generated.lua

fish: json
	bash scripts/make.sh 'fish'
	cp build/fish/voltrix.fish ~/.config/fish/functions/

# building for vim requires vim-devel
vim: json
	bash scripts/make.sh 'vim'
	vim --not-a-term -N -u NONE -n --cmd ':source scripts/make.vim' >/dev/null 2>&1
	cp build/vim/voltrix.colortemplate voltrix.vim/templates/voltrix.colortemplate
	cp -r build/vim/colors voltrix.vim

alacritty: json
	bash scripts/make.sh 'alacritty'

helix: json
	bash scripts/make.sh 'helix'
	mv build/helix/voltrix.toml build/helix/voltrix_generated.toml
	cat schemes/helix/scheme.toml > build/helix/voltrix.toml
	cat build/helix/voltrix_generated.toml >> build/helix/voltrix.toml
	cp build/helix/voltrix.toml ~/.config/helix/themes/voltrix.toml

kitty: json
	bash scripts/make.sh 'kitty'

base16: json
	bash scripts/make.sh 'base16'

json:
	bash scripts/write_json.sh

clean:
	rm -rf build
