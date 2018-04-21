.PHONY: full minimal clean

full: \
	.vimrc_\
	.zprofile_\
	.zshrc_\
	.gitconfig_\
	.gitignore_global_
	ln -sf ~/dotfiles/.vimrc_ ~/.vimrc
	ln -sf ~/dotfiles/.zprofile_ ~/.zprofile
	ln -sf ~/dotfiles/.zshrc_  ~/.zshrc
	ln -sf ~/dotfiles/.gitconfig_ ~/.gitconfig
	if [ ! -d ~/.config ]; then\
		mkdir ~/.config/;\
	fi
	if [ ! -d ~/.config/git ]; then\
		mkdir ~/.config/git;\
	fi
	if [ ! -d ~/.config/git ]; then\
		mkdir ~/.vim;\
	fi
	if [ ! -d ~/.config/git ]; then\
		mkdir ~/.vim/dict;\
	fi
	ln -sf ~/dotfiles/.gitignore_global_ ~/.config/git/ignore
	ln -sf ~/dotfiles/dict/*  ~/.vim/dict/

minimal: \
	.vimrc_minimal_\
	.zprofile_\
	.zshrc_\
	.gitconfig_\
	.gitignore_global_
	ln -sf ~/dotfiles/.vimrc_minimal_ ~/.vimrc
	ln -sf ~/dotfiles/.zprofile_ ~/.zprofile
	ln -sf ~/dotfiles/.zshrc_  ~/.zshrc
	ln -sf ~/dotfiles/.gitconfig_ ~/.gitconfig
	if [ ! -d ~/.config ]; then
		mkdir ~/.config/;
	fi
	if [ ! -d ~/.config/git ]; then
		mkdir ~/.config/git;
	fi
	if [ ! -d ~/.config/git ]; then\
		mkdir ~/.vim;\
	fi
	if [ ! -d ~/.config/git ]; then\
		mkdir ~/.vim/dict;\
	fi
	ln -sf ~/dotfiles/.gitignore_global_ ~/.config/git/ignore
	ln -sf ~/dotfiles/dict/*  ~/.vim/dict/

.vimrc_:
	cp .vimrc .vimrc_

.vimrc_minimal_:
	cp .vimrc_minimal .vimrc_minimal_

.zprofile_:
	cp .zprofile .zprofile_

.zshrc_:
	cp .zshrc .zshrc_

.gitconfig_:
	cp .gitconfig .gitconfig_

.gitignore_global_:
	cp .gitignore_global .gitignore_global_

clean:
	rm -f ./*_
