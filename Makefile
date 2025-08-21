.PHONY: all json kitty alacritty nvim clean

all: json kitty alacritty nvim vim

nvim: json
	bash make.sh 'nvim'

vim: json
	bash make.sh 'vim'
	vim --not-a-term -N -u NONE -n --cmd ':source make.vim' >/dev/null 2>&1
	cp ./build/vim/voltrix.colortemplate ./voltrix.vim/templates/voltrix.colortemplate
	cp -r ./build/vim/colors ./voltrix.vim/colors

alacritty: json
	bash make.sh 'alacritty'

kitty: json
	bash make.sh 'kitty'

json:
	bash write_json.sh

clean:
	rm -rf build
