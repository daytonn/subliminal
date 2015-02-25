#!/usr/bin/env bash

package_control_url="https://packagecontrol.io/Package%20Control.sublime-package"

function sublinal_ask_to_install {
  echo "This will install subliminal. Do you wish to continue?"
  select yn in "Yes" "No"; do
    case $yn in
      Yes ) subliminal_install; break;;
      No ) exit;;
    esac
  done
}

function subliminal_link_binary {
  if [ -e /usr/local/bin/subl ];then
    echo "--> Binary already linked!"
  else
    ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
  fi
}

function subliminal_backup_user_package {
  if [ -d ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User ]; then
    mv ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User{,.backup}
  fi
}

function subliminal_link_package {
  subliminal_backup_user_package
  ln -s ~/.subliminal/User ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
}

function subliminal_init_repository {
  mkdir ~/.subliminal
  cd ~/.subliminal
  git init
  git remote add upstream git@github.com:daytonn/subliminal.git
  git pull upstream master
}

function subliminal_add_remote {
  echo ""
  echo "Do you want to add a remote repository?"
  select yn in "Yes" "No"; do
    case $yn in
      Yes )
        echo "What is the git remote url?"
        read git_remote
        if [ -n "$git_remote" ]; then
          git remote add origin $git_remote
        fi
        break;;
      No ) break;;
    esac
  done
}

function subliminal_install {
  if [ -d ~/.subliminal ]; then
    echo "--> Subliminal is already installed. I'm going on break."
  else
    echo "--> Installing subliminal"
    subliminal_link_binary
    subliminal_init_repository
    subliminal_add_remote
    subliminal_link_package
    echo "--> Subliminal successfully installed!"
  fi
}

sublinal_ask_to_install
