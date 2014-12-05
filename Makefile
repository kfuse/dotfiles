# install the dot files into user's home directory

all: install

install:
	@cp -r vim ~/.vim
	@cp vimrc ~/.vimrc
	@mkdir -p ~/.vim/bundle/
	@git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	@vim +PluginInstall

