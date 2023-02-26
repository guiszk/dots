# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=frontcube

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"


# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
#plugins=(git postgres python)
plugins=(git)

source $ZSH/oh-my-zsh.sh

PS1="%(?..%B%{$fg[red]%}[%?] %{$reset_color%})%{$fg[magenta]%}%B%{$fg[blue]%}%~ %{$reset_color%}%% "

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='vim'
fi

#aliases
alias ohmyzsh_install='sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
alias ls='ls -Gt --color=auto'
alias ll='ls -lh'
alias la='ls -lah'
alias l1='ls -1'
alias lf='ls -lrt -d -1 "$PWD"/{*,.*}'
alias lh='ls -d .*'
alias pn='ping -c1 archlinux.org'
alias pw='pwgen -y -s $((12 + RANDOM % 20)) 1'
alias du='du -h -d 1'
alias grep='grep --color=always'
alias bgswap='feh --bg-max --randomize ~/.wallpaper/*'
alias lowercase="tr '[:upper:]' '[:lower:]'"
alias ytdl='youtube-dl --no-check-certificate -o "%(title)s.%(ext)s"'
alias zshedit='vim ~/.zshrc'
alias vimedit='vim ~/.vimrc'
alias chmodcorrectdirs='find ./* -type d -prune -exec chmod u=rwx,g=rx,o=rx {} \;'
alias spotifyadblock='bash <(curl -sSL https://raw.githubusercontent.com/SpotX-CLI/SpotX-Mac/main/install.sh)'
alias debian_run='docker run -it -v $PWD:/home/shared --name debian-container debian /bin/bash'

# functions
getsha1 () {
	if [ $# -ne 1 ]; then
        	echo "getsha1 <input text>"
        	return 1
    	else
		query=$(echo $1 | sed 's/[ ][ ]*/+/g')
		ans=$(curl -s "https://api.duckduckgo.com/?q=sha1+${query}&format=json&pretty=1" | jq '.Answer')
		echo Hash: $ans
		firstletters=${ans:1:5}
		nextletters=${ans:6:35}
		numres=$(curl -s "https://api.pwnedpasswords.com/range/${firstletters}" | grep -i $nextletters | cut -d ":" -f 2)
		
		if [ -n "$numres" ]; then
			#not empty
			echo Leaks found: $numres
		else
			#empty
			echo Leaks found: 0
		fi
	fi
}

mc () {
    if [ $# -ne 1 ]; then
        echo "mc <folder name>"
        return 1
    else
        mkdir $1
        cd $1
    fi
}

0x0 () {
    if [ $# -ne 1 ]; then
        echo "0x0 <link/file>"
        return 1
    fi
    regex='((https?)://)?[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]'
    if [ -f $1 ]; then
        curl -F'file=@'$1 http://0x0.st
    elif [[ $1 =~ $regex ]]; then
        curl -F'shorten='$1 http://0x0.st
    fi
}

getwalcolors () {
	cp .cache/wal/colors /tmp/cols.py
	vim /tmp/cols.py	
}

styleswap () {
	wal -i ~/.wallpaper/
}

szk () {
    if [ $# -ne 1 ]; then
        echo "szk <text/file>"
        return 1
    fi
    if [ -f $1  ]; then
        cat $1 | curl --data-binary @- https://szk.onrender.com
    else
        echo $1 | curl --data-binary @- https://szk.onrender.com
    fi
}

mvall () {
    if [ $# -ne 1 ]; then
        echo "mvall <folder name>"
    	return 1
	fi
	if [ -d $1 ]; then
		echo "Folder" $1 "already exists."
		return 1
	fi
	mkdir $1
	for i in $(ls -1 | egrep -v $1); do
		mv "${i}" $1
	done
}

findfind () {
    if [ $# -lt 2 ]; then
        echo "findfind <folder> <extension> <*exclude>"
    	return 1
	fi
	if [ -z "$3" ]; then
		find "$1" -type f -name "*.$2"
	else
		find "$1" -type f -name "*.$2" ! -name "*$3*"
	fi
}

#PATH
export PATH="$PATH:/Users/guiszk/Library/Python/3.9/bin"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

function preexec() {
  timer=$(($(gdate +%s%0N)/1000000))
}

function precmd() {
  if [ $timer ]; then
    now=$(($(gdate +%s%0N)/1000000))
    elapsed=$(($now-$timer))

    export RPROMPT="%F{green}${elapsed}ms %{$reset_color%}"
    unset timer
  fi
}
