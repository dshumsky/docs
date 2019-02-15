# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export HISTFILESIZE=200000
export HISTSIZE=200000
shopt -s histappend
shopt -s cmdhist # Combine multiline commands into one in history
HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoredups # Ignore duplicates, ls without options and builtin commands
export HISTIGNORE="&:ls:[bf]g:exit"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Unzip... Extract...
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

export GOPATH=$HOME/go
export GOROOT_BOOTSTRAP=$HOME/go1.4
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/games:/usr/local/games:/usr/local/go/bin:$HOME/go/bin

# http://ezprompt.net/
# export PS1="$ "
export PS1="\[\e[36m\]\u\[\e[m\]@\[\e[33m\]\h\[\e[m\]: \[\e[31m\]\w\[\e[m\] \\$\n"

export VISUAL=vim
export EDITOR="$VISUAL"

alias ls="ls --color=auto -F"
alias lss='ls -lah'
alias lsp='lsof -P -i -n'
alias ..='cd ..'

alias vi="vim"

alias grep="grep --color=auto"
alias hh="history | grep "
alias rm="rm -i "

alias cpu='cat /proc/cpuinfo | grep "model name" | head -1; sensors;'
alias disk='df -h;'
alias memory='free -h;'
# alias htop='htop -d 2'

alias clean_page='echo "echo 1 > /proc/sys/vm/drop_caches" | sudo sh;'

alias reboot='sudo reboot;'
alias shutdown='sudo telinit 0;'

alias gotest='go test -v ./...; go test -v -race ./...;'
alias c11='g++ -std=c++11'

alias clean='echo -e \\033c;'
alias clean_go='rm -rf $GOPATH/pkg'

alias gbra='git branch;'
alias gmas='git checkout master;'
alias gadd='git add -A .;'
alias gmit='git commit;'

alias cs='cd $HOME/go/src/github.com/gyuho;'
alias css='cd $HOME/go/src/github.com/coreos;'
alias learn='cd $HOME/go/src/github.com/gyuho/learn/doc/linux_setup;'

alias work='
ETCD_PATH=$HOME/go/src/github.com/coreos/etcd
if [ ! -d $ETCD_PATH ]; then
	echo "not exist!"

	git clone git@github.com:gyuho/etcd.git $HOME/go/src/github.com/coreos/etcd

	cd $HOME/go/src/github.com/coreos/etcd
	git remote add upstream git@github.com:coreos/etcd.git
	git fetch upstream
	git merge upstream/master
	git remote -v
	git branch
	git push
	pwd

else

	echo "exist!"

	prefix="backup_etcd_"
	underscore="_"
	date_string=$(date +"%Y%m%d%H%M%S")
	cd $HOME/go/src/github.com/coreos/etcd
	current_branch=$(git branch | sed -n -e "s/^\* \(.*\)/\1/p")
	temp_dir=$prefix$current_branch$underscore$date_string
	mv $HOME/go/src/github.com/coreos/etcd $HOME/go/src/github.com/coreos/$temp_dir

	git clone git@github.com:gyuho/etcd.git $HOME/go/src/github.com/coreos/etcd

	cd $HOME/go/src/github.com/coreos/etcd
	git remote add upstream git@github.com:coreos/etcd.git
	git fetch upstream
	git merge upstream/master
	git remote -v
	git branch
	git push
	pwd
fi

git config --global core.excludesFile $HOME/go/src/github.com/coreos/etcd/.vscode/*
echo """
# Ignore everything in this directory
*
# Except this file
!.gitignore
""" > $HOME/go/src/github.com/coreos/etcd/.vscode/.gitignore
'
