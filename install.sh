#!/usr/bin/env bash

subliminal_upstream_remote="git@github.com:daytonn/subliminal.git"
subliminal_download_link="https://github.com/daytonn/subliminal/archive/master.zip"

function sublinal_ask_to_install {
  echo "This will install subliminal. Do you wish to continue?"
  select yn in "Yes" "No"; do
    case $yn in
      Yes ) subliminal_install; break;;
      No ) exit;;
    esac
  done
}

function subliminal_install {
  subliminal_link_binary
  subliminal_download
}

function subliminal_download {
  if [ -d ~/.subliminal ]; then
    echo "subliminal is already installed. I'm going on break."
  else
    mkdir ~/.subliminal
    echo "--> Installing subliminal"
    echo ""
    cd ~/.subliminal
    git init
    git remote add upstream $subliminal_upstream_remote
    git pull upstream master
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
        No ) exit;;
      esac
    done
  fi
}

function subliminal_link_binary {
  if [ -e /usr/local/bin/subl ];then
    echo ""
    echo "--> Binary already linked!"
  else
    ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
  fi
}

sublinal_ask_to_install
