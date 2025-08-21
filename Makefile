.PHONY: all json kitty alacritty nvim clean

all: json kitty alacritty nvim vim

nvim: json
	bash scripts/make.sh 'nvim'

vim: json
	bash scripts/make.sh 'vim'
	vim --not-a-term -N -u NONE -n --cmd ':source scripts/make.vim' >/dev/null 2>&1
	cp build/vim/voltrix.colortemplate voltrix.vim/templates/voltrix.colortemplate
	cp -r build/vim/colors voltrix.vim

alacritty: json
	bash scripts/make.sh 'alacritty'

kitty: json
	bash scripts/make.sh 'kitty'

json:
	bash scripts/write_json.sh

clean:
	rm -rf build
