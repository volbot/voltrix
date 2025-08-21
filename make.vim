vim9script

set rtp+=~/.vim/pack/devel/start/colortemplate/
set rtp+=~/.vim/pack/devel/start/libpath/
set rtp+=~/.vim/pack/devel/start/librelalg/
set rtp+=~/.vim/pack/devel/start/libversion/
set rtp+=~/.vim/pack/devel/start/libcolor/
set rtp+=~/.vim/pack/devel/start/libparser/

filetype plugin on
syntax on

import "~/.vim/pack/devel/start/colortemplate/autoload/colortemplate.vim" as colortemplate 
import "~/.vim/pack/devel/start/colortemplate/import/colortemplate/generator/vim.vim" as vimgenerator

var bufnr = bufnr("%")
execute 'split' './build/vim/voltrix.colortemplate'
colortemplate.Build(bufnr('%'), "./build/vim", '!', {backend: 'vim'})
execute $':{bufnr}bwipe'
q

