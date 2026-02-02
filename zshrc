# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
## ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

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

# 2025-06-28 - RStrom
# I was getting this error
## [oh-my-zsh] fzf plugin: Cannot find fzf installation directory.
# Please add `export FZF_BASE=/path/to/fzf/install/dir` to your .zshrc

# It looks like the error is fixed by placing the line below BEFORE the plugins section
# https://github.com/ohmyzsh/ohmyzsh/issues/11639
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
autojump
colored-man-pages
colorize
copyfile
copypath
fzf
eza
1password
docker
docker-compose
dotenv
history
jsontools
kate
jump
pip
pipenv
pyenv
rsync
screen
ssh
ssh-agent
themes
vscode
wd)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export LIBVIRT_DEFAULT_URI='qemu:///system'

# force zsh to show the complete history
## alias history="history 0"
alias history='history -i 1'


setopt EXTENDED_HISTORY		# record command start time
# Turn off setopt INC_APPEND_HISTORY if setopt share_history is enabled
# setopt INC_APPEND_HISTORY
setopt INC_APPEND_HISTORY_TIME	# append command to history file immediately after execution
setopt share_history

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=200000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
#setopt share_history         # share command history data

# force zsh to show the complete history
## alias history="history 0"
alias history='history -i 1'

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'



alias cls='clear'

alias ls='eza'                                                              # ls
alias l='eza -lbF'                                                          # list, size, type, git
alias ll='eza -lbGF'                                                        # long list
alias llm='eza -lbGF --sort=modified'                                       # long list, modified date sort
alias la='eza -lbhHigUmuSa --time-style=long-iso --color-scale'             # all list
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --color-scale'            # all + extended list
alias lS='eza -1'			                                    # one column, just names
alias lt='eza --tree --level=2'                                             # tree
# requires that xclip be installed
# Alias to send text from terminal to clipboard
# This is usually via using cat to output the file and then pipe it to xclip
alias copy="xclip -selection clipboard -rmlastnl"
alias clip="xclip -selection clipboard -rmlastnl"
## 2022-07-16 - Trying new xclip aliases
# alias xclip='xclip -selection clipboard -rmlastnl'
alias paste="xclip -selection clipboard -o"
## 2024-05-28 - adding pbcopy and pbpaste aliases
alias pbcopy='xsel --input --clipboard'
alias pbpaste='xsel --output --clipboard'

# Docker Aliases
alias docker-start-webdav='docker run -p 80:80 -v "${PWD}":/srv/data/share rstrom/webdav'
alias docker-stop-webdav='docker stop $(sudo docker ps -q --filter ancestor=rstrom/webdav)'
alias docker-start-ubuntu2004='docker run -it ubuntu2004'
alias docker-start-ubuntu1804='docker run -it ubuntu1804'
alias docker-start-ubuntu1604='docker run -it ubuntu1604'
alias docker-start-ubuntu1404='docker run -it ubuntu1404'
alias docker-delete-dangling-images='docker rmi -f $(sudo docker images -f "dangling=true" -q)'

# SSH aliases
alias ssh-kali-proxmox='ssh rstrom@kali-proxmox-3'
alias ssh-do3='ssh rstrom@do3.robertstrom.org'
alias ssh-do4='ssh rstrom@do4.robertstrom.org'
alias ssh-proxmox='ssh root@proxmox-3'

# Mount QNAP-1 Home directory
alias mount-QNAP-1='sudo mount -t cifs -o gid=1000,uid=1000,vers=3.0,username=rstrom //192.168.0.99/rstrom /mnt/QNAP-1'
alias unmount-QNAP-1='sudo umount /mnt/QNAP-1'
alias QNAP-1='cd /mnt/QNAP-1'


# Fix ssh known_hosts file
# RStrom - Added 2026-02-02
function fix-known-hosts-file() {

    local host=$1
        local port=$2
        local target=$host

        if [ -z "$host" ]; then
            echo "Usage: fix-known-hosts-file [hostname/IP] [optional-port]"
            return 1
        fi

        # Handle port formatting for ssh-keygen
        if [ -n "$port" ]; then
            target="[$host]:$port"
        fi

        # 1. Remove the old key
        if ssh-keygen -f "$HOME/.ssh/known_hosts" -R "$target"; then
            echo "Removed $target from known_hosts."
            echo "Reconnecting..."
            echo "-----------------------------------"
            
            # 2. Build the SSH command as an array
            local -a ssh_cmd
            if [[ "$TERMINAL_PROGRAM" == "kitty" || -n "$KITTY_PID" ]]; then
                ssh_cmd=(kitty +kitten ssh)
            else
                ssh_cmd=(ssh)
            fi

            # 3. Add port flag if needed
            [ -n "$port" ] && ssh_cmd+=(-p "$port")

            # 4. Execute (the @ expands the array elements individually)
            "${ssh_cmd[@]}" "$host"
        else
            echo "Error: Failed to remove $target."
            return 1
        fi

}


# Functions added - 4/10/2022 RStrom
function grepEmailAddresses() {
	grep -E -o "\b[a-zA-Z0-9.-]+@[a-zA-Z0-9.-](+.|&#46;)[a-zA-Z0-9.-]+\b" $1
}

function grepURLs() {
	grep -oE '\b(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]' $1
}

function convertFromHexGetURLs() {
	## Original regex
	## sed "s/<script language.*('//g" $1 | sed "s/').*$//g" | xxd -r -p | grep -oE '\b(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]'
	sed "s/<script.*('//g" $1 |  sed "s/').*$//g" | sed "/<script/,/<\/script>/d" | sed "/<html/,/<\/html>/d"  | xxd -r -p | grep -oE '\b(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]'
}

function convertFromHexGetEmail() {
	sed "s/<script language.*('//g" $1 | sed "s/').*$//g" | xxd -r -p | sed "s/&#46;/./g" | grep -E -o "\b[a-zA-Z0-9.-]+@[a-zA-Z0-9.-](+.|&#46;)[a-zA-Z0-9.-]+\b"
}

get-geoiplookup-io() {
	#do things with parameters like $1 such as
	curl --insecure https://json.geoiplookup.io/geo/"$1"
}

get-geoipinfo-io() {
	#do things with parameters like $1 such as
	curl --insecure https://ipinfo.io/"$1"
}

start-python-httpserver-80() {
python -m SimpleHTTPServer 80
}

start-python3-httpserver-80() {
python3 -m http.server 80
}

start-python3-HTTPUploadServer() {
python3 -m uploadserver 80
}

start-python-ftp-server() {
python3 -m pyftpdlib -p 21 --write
}

start-apache-web-server() {
	echo "The Apache web servers directory is /var/www/html/"
	sudo systemctl start apache2
}

stop-apache-web-server() {
	sudo systemctl stop apache2
}

start-xfreerdp-connection() {
    # echo "Please enter the username"
    # read rdp_user_name
    # echo "Please enter the password"
    # read rdp_password
    # echo "Please enter the IP Address"
    # read rdp_ip_address
    xfreerdp /cert-ignore /compression /u:$rdp_user_name /p:$rdp_password /w:1366 /h:768 /v:$rdp_ip_address /smart-sizing +auto-reconnect +clipboard 
}

status-ssh-service() {
    sudo systemctl status ssh
}

start-ssh-service() {
    sudo systemctl start ssh
}

stop-ssh-service() {
    sudo systemctl stop ssh
}

connect-QNAP-sshfs() {
sshfs rstrom@qnap: ~/QNAPMyDocs
}


connect-remote-SMB-share() {
    echo "Please enter the SMB username"
    read smb_user_name
    echo "Please enter the SMB password"
    read smb_user_password
    echo "Please enter the IP Address of the SMB server to connect to"
    read smb_ip_address
    echo "Please enter the name of the SMB share to connect to"
    read smb_share
    sudo mount -t cifs -o gid=1000,uid=1000,vers=2.0,username=$smb_user_name,password=$smb_user_password //$smb_ip_address/$smb_share /home/rstrom/SMBMount
}

connect-remote-SMB-share-alt-port() {
    echo "Please enter the SMB username"
    read smb_user_name
    echo "Please enter the SMB password"
    read smb_user_password
    echo "Please enter the IP Address of the SMB server to connect to"
    read smb_ip_address
    echo "Please enter the name of the SMB share to connect to"
    read smb_share
    echo "Please enter the alternate port of the SMB share to connect to"
    read smb_port    
    sudo mount -t cifs -o gid=1000,uid=1000,vers=2.0,username=$smb_user_name,password=$smb_user_password,port=$smb_port //$smb_ip_address/$smb_share /home/rstrom/SMBMount
}

connect-remote-SMB-domain-share() {
    echo "Please enter the SMB username"
    read smb_user_name
    echo "Please enter the SMB password"
    read smb_user_password
    echo "Please enter the name of the Windows domain"
    read smb_domain_name
    echo "Please enter the IP Address of the SMB server to connect to"
    read smb_ip_address
    echo "Please enter the name of the SMB share to connect to"
    read smb_share
    sudo mount -t cifs -o gid=1000,uid=1000,vers=2.0,username=$smb_user_name,domain=$smb_domain_name,password=$smb_user_password //$smb_ip_address/$smb_share /home/rstrom/SMBMount
}

connect-remote-SMB-share-guest() {
    echo "Please enter the IP Address of the SMB server to connect to"
    read smb_ip_address
    echo "Please enter the name of the SMB share to connect to"
    read smb_share
    sudo mount -t cifs -o gid=1000,uid=1000,vers=2.0,username=guest,password="" //$smb_ip_address/$smb_share /home/rstrom/SMBMount
}


disconnect-remote-SMB-share() {
cd ~
sudo umount /home/rstrom/SMBMount
}

## Old Nmap XML to HTML function
# Commented out on 8/27/2023
## nmap-xml-to-html() {
## infile=$1
## outfile=$(echo $infile | sed 's/xml/html/')
## xsltproc $infile -o $outfile
## }

# Updated Nmap XML to HTML function
# Added on 8/27/2023
# This function incorporates a conversion of the path to the xsl template if the scan was performed on a Windows system
nmap-xml-to-html() {
infile=$1
cp $infile $infile.sav
## This conversion only needs to happen if the Nmap scan was done on a Windows system
## If the text below does not exist in the Nmap XML file then there should be no change made to the XML file and the conversion should still work
sed -i 's/C\:\/Program Files (x86)\/Nmap\/nmap\.xsl/usr\/share\/nmap\/nmap\.xsl/' $infile
outfile=$(echo $infile | sed 's/xml/html/')
xsltproc $infile -o $outfile
}


convert-Unix-EpochTime() {
        echo "Please enter the Unix Epoch Time string (seconds, not milliseconds)"
        read unixepoch
        echo ""
        echo "The Unix Epoch timestamp conversion translates to this date and time:"
        date -d@$unixepoch
}

convert-Unix-EpochTimeMiliseconds() {
        echo "Please enter the Unix Epoch Time string (milliseconds)"
        read unixepoch
        echo ""
        echo "The Unix Epoch timestamp conversion translates to this date and time:"
        date -d @$(  echo "($unixepoch + 500) / 1000" | bc)
}


Backup-Obsidian() {
    backupdate=$(date +"%Y-%m-%d_%H-%M-%S")
    cd ~
    7zz a Obsidian_backup_$backupdate ./Obsidian
}

# 2025-04-18 - RStrom
# This is an informational funcion. A reminder, if needed, on how to quickly drop to the bottom of a long shell history list
jumpToEndofHistory() {
        # https://superuser.com/questions/868090/how-to-jump-to-the-bottom-of-the-terminal-input-history-after-a-long-lookback
        ehco "Press the ESC key and then the > key to jump to the end of command history"
}

# Updated the function based on this SANS post - 2024-04-09 - RStrom
# Taking Apart URL Shorteners
# https://isc.sans.edu/diary/Taking+Apart+URL+Shorteners/28980
expandshortURL() {
curl -k -v -I $1 2>&1 | grep -i "< location" | cut -d " " -f 3
}

# 2025-04-18 - RStrom
# An alternative method of expanding shortened URL's - pretty much the same as above though
expandurl() {
        curl -sIL $1 | grep -i ^Location;
}

bloodhound-tunnel() {

ssh -fqnN -L 8081:127.0.0.1:8080 rstrom@kali-proxmox-3
echo "BloodHound is now available via http://localhost:8081/ui/login"

}

get-bhtunnel-pid() {

bhtunnelpid=$(ss -antp | grep 8081 | grep -Eo 'pid=[0-9]{1,10}' | awk -F"=" '{ print $2 }' | head -n 1)
echo $bhtunnelpid

}

kill-bloodhound-tunnel() {

bhtunnelpid=$(ss -antp | grep 8081 | grep -Eo 'pid=[0-9]{1,10}' | awk -F"=" '{ print $2 }' | head -n 1)
kill -15 $bhtunnelpid

}

remove-loop-device() {

loopdev=$(lsblk /dev/loop* | head -n 2 | tail -n 1 | grep -Eo 'loop[0-9]{1,2}')
sudo losetup -d /dev/$loopdev

}


export PATH="$PATH:/home/rstrom/go/bin/"

# Created by `pipx` on 2025-05-03 19:32:03
export PATH="$PATH:/home/rstrom/.local/bin"

export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

source /home/rstrom/.config/broot/launcher/bash/br

eval "$(zoxide init zsh)"
