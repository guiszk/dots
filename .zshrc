# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="kardan"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git postgres python)

source $ZSH/oh-my-zsh.sh

PS1="%(?..%B%{$fg[red]%}[%?] %{$reset_color%})%{$fg[magenta]%}%Bmbp %{$fg[blue]%}%~ %{$reset_color%}%% "

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

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
alias chmodcorrectdirs='find ./* -type d -prune -exec chmod u=rwx,g=rx,o=rx {} \;'

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
