# Path to your oh-my-zsh installation.
export ZSH=/home/emperor/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/$USER/bin:/home/$USER/.bin:/home/$USER/.cabal/bin:/opt/cabal/1.20/bin:/opt/ghc/7.8.4/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh
alias zshconfig="vim ~/.zshrc"

c00='\e[0;30m'
c01='\e[0;31m'
c02='\e[0;32m'
c03='\e[0;33m'
c04='\e[0;34m'
c05='\e[0;35m'
c06='\e[0;36m'
c07='\e[0;37m'
c08='\e[1;30m'
c09='\e[1;31m'
c10='\e[1;32m'
c11='\e[1;33m'
c12='\e[1;34m'
c13='\e[1;35m'
c14='\e[1;36m'
c15='\e[1;37m'

f0='\e[1;30m'
f1='\e[1;37m'
f2='\e[0;37m'


# Alias to multible ls commands
alias la='ls -Al'                # show hidden files
alias ls='ls -F --color=always' # add colors and file type extention
alias lx='ls -lXB'               # sort by extention
alias lk='ls -lSr'               # sort by size
alias lc='ls -lur'               # sort by change time
alias lu='ls -lur'               # sort by access time
alias lr='ls -lR'                # recursive ls
alias lt='ls -ltr'               # sort by date
alias lm='ls -al | more'         # pip through more
alias ll='ls -alhF'
alias l='ls -CF'
#####################
# Even more aliases #
#####################

alias quit='exit'
# shorthand ;^) #
alias c='clear'
alias m='ncmpcpp'
alias s='sudo'

alias z='zsh'

alias hr='for i in $(seq 1 $(tput cols)); do printf -; done'
alias ld='lsblk'

alias rm='rm -I'
alias cp='cp -vi'
alias mv='mv -i'

alias editor='emacsclient -a "" -t'
alias gv='gvim'
alias sv='sudo vim'

alias unixdate='date +%s%3N'

alias lock='i3lock -ni <(import -window root -silent png:- | convert png:--scale 10% -scale 1000% png:-) &>dev/null'
alias sort-size='du -h --max-depth=1 | sort -h'
alias bk-music='(date && tree /home/$USER/Music/) > /home/$USER/Documents/Reference/my-music.txt'
alias fix-audio='pkill mpd; pulseaudio -k; pulseaudio --start; mpd'

alias checkip='curl -s checkip.dyndns.org | grep -Eo "[0-9\.]+"'
alias skype='xhost +local: &&  su skype -c skype'
#############
# Functions #
#############

function mt() { pmount -w -u 022 sd"$1"1 "$2"; }
function mt2() { pmount -w -u 022 sd"$1"2 "$2"; }
function umt { pumount "$1" ;}

function music-thread() {
	curl $1 | egrep -o "\"https\:\/\/www\.youtube\.com\/watch\?v\=[a-zA-Z0-9_-]*\"" | uniq | xargs mpv --vo=null
}

function mpvpl() {
	find "$PWD" -name "*.${1:-flac}" | sort | mpv --playlist=-
}

function please() {
	sudo "$(fc -ln -1)"
}
function extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2) tar xvjf $1;;
            *.tar.gz)  tar xvzf $1;;
            *.bz2)     bunzip2 $1;;
            *.rar)     unrar x $1;;
            *.tar)     tar xvf $1;;
            *.tbz2)    tar xvjf $1;;
            *.tgz)     tar xvzf $1;;
            *.zip)     unzip $1;;
            *.Z)       uncompress $1;;
            *.7z)      7za x $1;;
            *)         echo "'$1' cannot be extracted using >extract<";;
        esac
    else
        echo "'$1' not a valid file"
    fi
}

function ripflac () {
  input=$1
  output=$2
  cuebreakpoints "$1" | shnsplit -o flac "$2"
}

# auto cd into newly created directory
function mcd() {
    mkdir $@ && cd $@
}

function btc() {
	curl -s https://btc-e.com/api/2/btc_usd/ticker | json_pp | grep avg | awk '{print $3}'
}

function backup() {
	cp -ruv ~/bin /media/backup/;
	cp -ruv ~/.config /media/backup;
	cp -uv ~/.zshrc /media/backup;
	cp -uv ~/.xmodmap /media/backup;
	cp -uv ~/.xbindkeysrc /media/backup;
	yaourt -Q > /media/backup/proggies.txt
	echo 'OK'; }
##################
# Welcome screen #
##################
#screenfetch -c "09,1000"
PROMPT="${ret_status}%{$fg_bold[red]%}%p %C %{$fg_bold[blue]%}λ$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}"
#PROMPT="${ret_status}%{$fg_bold[red]%}λ$(git_prompt_info)%{$fg_bold[blue]%} %{$reset_color%}"
