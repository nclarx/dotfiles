if [ ! GitAddCommitPush ]
then
  GitAddCommitPush () {
    workingDir=$1
    commitMsg=$2
    echo "Working dir: $workingDir \n" 
    git -C $workingDir add . && 
      git -C $workingDir commit -m $commitMsg && 
      git -C $workingDir push && 
      git -C $workingDir status
    }
fi

vwiki() {
  if [ ! $1 ]
  then
    echo "Select an operation for Vimwiki:"
      echo "1) commit Dev wiki"
      echo "2) commit/push Work wiki"
      echo "3) commit/push Personal wiki"
      echo "Select a number from above..."
      read mainmenuinput
      echo $mainmenuinput
      case $mainmenuinput in
        1)
          wikiDir="/Users/nc/vimwiki/dev"
          GitAddCommitPush $wikiDir "Dev wiki updated"
          ;;
        2)
          wikiDir="/Users/nc/vimwiki/ca"
          GitAddCommitPush $wikiDir "CA wiki updated"
          ;;
        3)
          wikiDir="/Users/nc/vimwiki/personal"
          GitAddCommitPush $wikiDir "Personal wiki updated"
          ;;
      esac
    else
      commitWiki $1
    fi
  }

commitWiki() {
  if [ $1 = "dev" ] || [ $1 = "ca" ] || [ $1 = "my" ]
  then
    GitAddCommitPush "$HOME/vimwiki/$1" "UPDATE: $1 dev wiki auto update"
  fi
}

alias vwd="vwiki dev"
alias vww="vwiki ca"
alias vwm="vwiki me"
