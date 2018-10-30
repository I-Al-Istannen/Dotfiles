alias realias="source ~/.bash_aliases"


alias ls="ls --color=auto"
alias grep="grep --color"
alias thunderbird="GTK_THEME=breeze thunderbird"
alias firefox="GTK_THEME=breeze firefox"
alias :q="exit"
alias restart-network="nmcli n off && nmcli n on"
alias ssh="TERM=xterm ssh"
alias firewall="kcmshell4 ufw"
alias battery="upower -i $(upower -e | grep 'BAT') | grep -P '(time to)|(percent)' | sed -E 's/.+time to empty: \s+(.+)/\1/' | sed -E 's/.+percentage:\s*(.+%)/\1/' | tr '\n' '| ' | sed -E 's/(.+)\|/\1\n/'"
alias vlcli='vlc --intf ncurses'
alias jshell='/usr/lib/jvm/java-10-openjdk/bin/jshell'
alias duplicate='termite -d $(pwd) &'
alias ffind=$'fzf --preview \'[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || bat --style=numbers --decorations always --color always {}\''
alias ncdu='ncdu --color=dark'

# KIT
alias kitssh="ssh *@i08fs1.ira.uka.de"
