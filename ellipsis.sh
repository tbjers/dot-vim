#!/usr/bin/env bash
#
# tbjers/dot-zsh ellipsis package

pkg.link() {
  files=(inputrc vimrc)

  for file in ${files[@]}; do
    fs.link_file $file
  done

  # link module into ~/.vim
  fs.link_file $PKG_PATH
}

pkg.install() {
  # install pathogen
  mkdir -p $PKG_PATH/autoload $PKG_PATH/bundle
  curl -LSso $PKG_PATH/autoload/pathogen.vim https://tpo.pe/pathogen.vim

  # install dependencies
  cd $PKG_PATH/bundle
  git.clone git@github.com:altercation/vim-colors-solarized.git
  git.clone git@github.com:bling/vim-airline.git
  git.clone git@github.com:tpope/vim-fugitive.git
  git.clone git@github.com:digitaltoad/vim-jade.git
  git.clone git@github.com:groenewege/vim-less.git
  git.clone git@github.com:kien/ctrlp.vim.git
  git.clone git@github.com:gabrielelana/vim-markdown.git
  git.clone git@github.com:SirVer/ultisnips.git
  git.clone git@github.com:elzr/vim-json.git
  git.clone git@github.com:etaoins/vim-volt-syntax.git
  git.clone git@github.com:StanAngeloff/php.vim.git
  git.clone git@github.com:terryma/vim-multiple-cursors.git
  git.clone git@github.com:mxw/vim-jsx.git
  git.clone git@github.com:tpope/vim-fireplace.git
  git.clone git@github.com:derekwyatt/vim-scala.git
  git.clone git@github.com:kchmck/vim-coffee-script.git
  git.clone git@github.com:tmux-plugins/tpm.git
  git.clone git@github.com:joshdick/onedark.vim.git
  git.clone git@github.com:vim-airline/vim-airline-themes.git
}

helper() {
  # run command for ourselves
  $1

  # run command for each addon
  for addon in ~/.vim/bundle/*; do
    # git status/push only repos which are ours
    if [ $1 = "git.pull" ] || [ "$(cat $addon/.git/config | grep url | grep $ELLIPSIS_USER)" ]; then
      cd $addon
      $1 vim/$(basename $addon)
    fi
  done
}

pkg.pull() {
  helper git.pull
}

pkg.status() {
  helper hooks.status
}

pkg.push() {
  helper git.push
}
