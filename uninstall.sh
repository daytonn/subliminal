#!/usr/bin/env bash

function subliminal_message {
  echo "--> $1"
}

function sublinal_ask_to_uninstall {
  echo ""
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
    subliminal_message "Removing subliminal"
    rm -Rf ~/.subliminal
  fi
}

function subliminal_restore_user_package {
  if [ -d ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User.backup ]; then
    if [ -L ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User ]; then
      subliminal_message "Removing subliminal user packages"
      rm -Rf ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
    fi
    subliminal_message "Restoring original user packages"
    mv ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User{.backup,}
  fi
}

function subliminal_uninstall {
  if [ ! -d ~/.subliminal ] && [ ! -L ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User ]; then
    subliminal_message "Subliminal is not installed. I'm going on break"
  else
    subliminal_remove
    subliminal_restore_user_package
    subliminal_message "Subliminal successfull uninstalled!"
  fi
}

sublinal_ask_to_uninstall