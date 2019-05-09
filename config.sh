
mv ~/.vimrc ~/.vimrc_bk
mv ~/.vim ~/.vim_bk
mv ~/.bashrc ~/.bashrc_bk
mv ~/.tmux.conf ~/.tmux.conf_bk

cp -r .vimrc ~/.vimrc
cp -r  .vim ~/.vim
cp -r  .bashrc ~/.bashrc
cp -r  .tmux.conf ~/.tmux.conf
cp -r  .git-completion.bash ~/.git-completion.bash

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

cp file.vim  ~/.vim/bundle/FuzzyFinder/autoload/fuf/file.vim
