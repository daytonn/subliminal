#!/usr/bin/env bash

sublime_user_package=~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
sublime_user_package_backup=~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User.backup

function sublinal_ask_to_uninstall {
  echo "This will un-install subliminal. Do you wish to continue?"
  select yn in "Yes" "No"; do
    case $yn in
      Yes ) subliminal_uninstall; break;;
      No ) exit;;
    esac
  done
}

function subliminal_remove {
  if [ -d ~/.subliminal ]; then
    rm -Rf ~/.subliminal
  fi
}

function subliminal_restore_user_package {
  if [ -d ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User.backup ]; then
    if [ -L ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User ]; then
      rm -Rf ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
    fi
    mv ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User{.backup,}
  fi
}

function subliminal_uninstall {
  if [ ! -d ~/.subliminal ] && [ ! -L ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User ]; then
    echo "--> Subliminal is not installed. I'm going on break"
  else
    subliminal_remove
    subliminal_restore_user_package
    echo "--> Subliminal successfull uninstalled!"
  fi
}

sublinal_ask_to_uninstall