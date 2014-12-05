# install the dot files into user's home directory

install:
	@cp -r vim ~/.vim
	@cp vimrc ~/.vimrc
	@mkdir ~/.vim/bundle/
	@git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

