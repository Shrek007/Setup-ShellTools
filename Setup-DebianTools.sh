# Aliases

# Colorize Bash shell prompt if it exists
FILE=~/.bashrc
COLOREXPRESSION="\[\e[31m\][\[\e[m\]\[\e[38;5;172m\]\u\[\e[m\]@\[\e[38;5;153m\]\h\[\e[m\] \[\e[38;5;214m\]\W\[\e[m\]\[\e[31m\]]\[\e[m\]\\$ "
if test -f "$FILE"; then
    $X = export PS1=$COLOREXPRESSION
    $X > $FILE
fi

# List of tools to install put into 'install' variable
programs="\
 openvpn\
 ipcalc\
 cmatrix\
 hollywood\
 tty-clock\
 firefox\
"
# 
apt-get install $programs -y