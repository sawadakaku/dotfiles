.PHONY: full minimal bash bash_minimal clean\
		vimrc zprofile zshrc gitconfig gitignore_global\
		vimdict neosnipet tmux.conf

full: \
	init.vim\
	zprofile\
	zshrc\
	gitconfig\
	gitignore_global\

minimal: \
	vimrc_minimal\
	vimdict\
	zprofile\
	zshrc\
	gitconfig\
	gitignore_global\

bash: \
	init.vim\
	gitconfig\
	gitignore_global\

bash_minimal: \
	vimrc_minimal\
	vimdict\
	gitconfig\
	gitignore_global\

vimrc: .vimrc_
	if [ -L ~/.vimrc ]; then\
		unlink ~/.vimrc;\
	fi
	ln -sf ~/dotfiles/.vimrc_ ~/.vimrc

.vimrc_:
	cp .vimrc .vimrc_

vimrc_minimal: .vimrc_minimal_
	if [ -L ~/.vimrc ]; then\
		unlink ~/.vimrc;\
	fi
	ln -sf ~/dotfiles/.vimrc_minimal_ ~/.vimrc

.vimrc_minimal_:
	cp .vimrc_minimal .vimrc_minimal_

zprofile: .zprofile_
	if [ -L ~/.zprofile ]; then\
		unlink ~/.zprofile;\
	fi
	ln -sf ~/dotfiles/.zprofile_ ~/.zprofile

.zprofile_:
	cp .zprofile .zprofile_

zshrc: .zshrc_
	if [ -L ~/.zshrc ]; then\
		unlink ~/.zshrc;\
	fi
	ln -sf ~/dotfiles/.zshrc_  ~/.zshrc

.zshrc_:
	cp .zshrc .zshrc_

gitconfig: .gitconfig_
	if [ -L ~/.gitconfig ]; then\
		unlink ~/.gitconfig;\
	fi
	ln -sf ~/dotfiles/.gitconfig_ ~/.gitconfig

.gitconfig_:
	cp .gitconfig .gitconfig_

gitignore_global: .gitignore_global_
	if [ ! -d ~/.config ]; then\
		mkdir ~/.config/;\
	fi
	if [ ! -d ~/.config/git ]; then\
		mkdir ~/.config/git;\
	fi
	ln -sf ~/dotfiles/.gitignore_global_ ~/.config/git/ignore

.gitignore_global_:
	cp .gitignore_global .gitignore_global_

vimdict:
	if [ ! -d ~/.vim ]; then\
		mkdir ~/.vim;\
	fi
	if [ ! -d ~/.vim/dict ]; then\
		mkdir ~/.vim/dict;\
	fi
	ln -sf ~/dotfiles/dict/*  ~/.vim/dict/

neosnipet:
	mkdir -p ~/.vim/dein/repos/github.com/Shougo/neosnippet-snippets/neosnippets
	ln -sf ~/dotfiles/cpp/cpp.snip ~/.vim/dein/repos/github.com/Shougo/neosnippet-snippets/neosnippets/cpp.snip

tmux.conf: .tmux.conf_
	if [ -L ~/.tmux.conf ]; then\
		unlink ~/.tmux.conf;\
	fi
	ln -sf ~/dotfiles/.tmux.conf_ ~/.tmux.conf

.tmux.conf_:
	cp .tmux.conf .tmux.conf_

init.vim: init.vim_
	if [ ! -d ~/.config/nvim ]; then\
		mkdir -p ~/.config/nvim;\
	fi
	if [ -L ~/.config/nvim/init.vim ]; then\
		unlink ~/.config/nvim/init.vim;\
	fi
	ln -sf ~/dotfiles/init.vim_ ~/.config/nvim/init.vim

init.vim_:
	cp init.vim init.vim_

clean:
	rm -f ./*_

