### Debian 10

# .bashrc functions
neofetch = neofetch --separator ':  \t'

# Aliases to put into ~\.bashrc  OR  ~\.bash_profile
alias neofetch="neofetch --separator ':  \t'"

# Colorize Bash shell prompt if it exists
FILE=~/.bashrc
COLOREXPRESSION="\[\e[31m\][\[\e[m\]\[\e[38;5;172m\]\u\[\e[m\]@\[\e[38;5;153m\]\h\[\e[m\] \[\e[38;5;214m\]\W\[\e[m\]\[\e[31m\]]\[\e[m\]\\$ "
if test -f "$FILE"; then
    $X = export PS1=$COLOREXPRESSION
    $X > $FILE
fi

# set mappings for terminal shortcuts in either ~/.inputrc OR /etc/inputrc
FILE=~/.inputrc
if test -f "$FILE"; then

# List of tools to install put into 'install' variable
programs="\
 pip3\
 openvpn\
 ipcalc\
 cmatrix\
 hollywood\
 nms\
 tty-clock\
 firefox-esr\
 nmap\
 zenmap\
 git\
 symlinks\
 neofetch\
 whois\
 netdiscover\
 tmux\
"
# 
apt-get install $programs -y


### Package Managers
# PIP3 (Python)
pip3 install bpytop