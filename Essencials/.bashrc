#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTTIMEFORMAT='%Y-%m-%d%T '
PS1='[\u@\h \W]\$ '

alias ls='ls --color=auto'
alias lt='ls -lsrht'

alias cls='clear'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -lcht'
alias grep='grep --color=auto'


# alsamixer
alias alsa_store='sudo alsactl store'
alias alsa_restore='sudo alsactl restore'

# backup essencials
alias be='sudo /bin/carbo__BackupEssencials.sh'

# bashrc
alias bsr='source ~/.bashrc; printf "bashrc was reloaded!\n"'
alias bs='vim ~/.bashrc'
alias cb='sudo carbonara.sh'

# clipboard / trash / recent 
alias cla='xsel --clipboard --clear && printf "\nclipboard was cleaner!\n";sudo trash-empty --all -f && printf "Rubbish is clear!\n"; rm -rf /home/*/.local/share/recently-used.xbel && printf "Files recent was removed!\n"'


# journalctl
alias jp='journalctl --user -u RestartAllServicesPipewire.service'
alias lsblkd='lsblk --output=NAME,MODEL,PATH,FSAVAIL,FSROOTS,FSSIZE,FSTYPE,FSUSED,FSUSE%,FSVER,MOUNTPOINTS | grep -v loop '

# kernel
alias mk='sudo mkinitcpio -P'
alias grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

# komorebi
alias komokill='sudo killall komorebi; sudo killall gjs; komorebi > /dev/null 2>&1 & clear'

# keyboard set
alias pt='sudo loadkeys br-abnt2' 

# pacman 
alias paclean='sudo pacman -Rns $(pacman -Qdtq) ; sudo pacman -Sc --noconfirm'
alias pacv='expac --timefmt="%Y-%m-%d %T" "%l\t%n" | sort | tail -n 20'
alias pacrm='sudo rm /var/lib/pacman/db.lck'

# pipewire
alias pw='/bin/PipewireRestartAllServices.sh'
alias pws='/bin/PipewireCheckServices.sh'
alias spt='speaker-test -t wav -c 2 -l 1'

# Rubbish
alias rb=''

# System
alias cleanup='clear; echo "Buscando arquivos grandes no sistema..."; sleep 3;sudo find / -type f -size +1G -exec du -sh {} + 2>/dev/null | sort -h | head -n 30'

# Habilitar auto-complete de comandos
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

source /home/apollo/.config/broot/launcher/bash/br
export EDITOR=vim
