.PHONY: all json kitty alacritty nvim vim clean

TINTED_BUILDER_RUST_SHA256 = 51a68e43b86192bf081f99bf3c1798d9e346d5dd016d76f31ea75a58585d9386
TINTED_BUILDER_RUST_FILE = ./lib/tinted-builder-rust/tinted-builder-rust.tar.gz
TINTED_BUILDER_RUST_CMD = ./lib/tinted-builder-rust/tinted-builder-rust -s ./build/base16 build out

SHA256_CMD = sha256sum

all: vim nvim terminals fish

fish: json
	bash scripts/make.sh 'fish'
	cp build/fish/voltrix.fish ~/.config/fish/functions/

vim: base16 deps 
	if [ ! -d ./tinted-vim ]; then \
		git clone https://github.com/tinted-theming/tinted-vim ;\
	fi
	mkdir -p ./out/templates
	cp ./tinted-vim/templates/* ./out/templates
	$(TINTED_BUILDER_RUST_CMD)
	rm ./out/templates/*

nvim: base16 deps 
	if [ ! -d ./tinted-nvim ]; then \
		git clone https://github.com/tinted-theming/tinted-nvim ;\
	fi
	mkdir -p ./out/templates
	cp ./tinted-nvim/templates/* ./out/templates
	$(TINTED_BUILDER_RUST_CMD)
	rm ./out/templates/*

terminals: base16 deps 
	if [ ! -d ./tinted-terminal ]; then \
		git clone https://github.com/tinted-theming/tinted-terminal ;\
	fi
	mkdir -p ./out/templates
	cp ./tinted-terminal/templates/* ./out/templates
	$(TINTED_BUILDER_RUST_CMD)
	rm ./out/templates/*

base16: json
	bash scripts/make.sh 'base16'

json:
	bash scripts/write_json.sh

deps: tinted_builder_rust

tinted_builder_rust: 
	mkdir -p ./lib/tinted-builder-rust
	wget -O "$(TINTED_BUILDER_RUST_FILE)" https://github.com/tinted-theming/tinted-builder-rust/releases/download/v0.13.2/tinted-builder-rust-x86_64-unknown-linux-gnu.tar.gz
	CALCULATED_SHA256=`$(SHA256_CMD) $(TINTED_BUILDER_RUST_FILE)`; \
	case "$$CALCULATED_SHA256 " in \
		($(TINTED_BUILDER_RUST_SHA256)\ *) : ok ;; \
		(*) echo invalid checksum for "$(TINTED_BUILDER_RUST_FILE)", expected=\"$(TINTED_BUILDER_RUST_SHA256)\" actual=\"$$CALCULATED_SHA256\"; \
		exit 1 ;; \
	esac
	tar xf ./lib/tinted-builder-rust/tinted-builder-rust.tar.gz -C ./lib/tinted-builder-rust

clean:
	rm -rf ./lib ./out ./tinted-terminal ./tinted-nvim ./tinted-vim
