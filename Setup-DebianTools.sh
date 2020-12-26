# ISO - Debian 10

# Aliases

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
 openvpn\
 ipcalc\
 cmatrix\
 hollywood\
 tty-clock\
 firefox-esr\
"
# 
apt-get install $programs -y