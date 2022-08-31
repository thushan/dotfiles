HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000

# src: https://ubuntuforums.org/showthread.php?t=679762&page=7
setopt correct
setopt extendedglob
setopt autopushd pushdminus pushdsilent pushdtohome
setopt no_clobber           # don't overwrite files when redirect
setopt share_history
setopt hist_verify          # verify when using !
setopt hist_ignore_space    # prepend ' ' to not be saved
setopt nohup               # don't kill bg jobs when tty quits
setopt nocheckjobs          # don't complain about background jobs on exit
setopt printexitvalue       # print exit value from jobs

unsetopt bgnice            # don't nice bg command

autoload -U compinit
compinit


if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# do ls right after cd
cd () {
  if [ -n $1 ]; then
    builtin cd "$@" && ls
  else
    builtin cd ~ && ls
  fi
}

# grep process by name and list the results nicely
pg () {
    if pgrep -f $@ > /dev/null;
    then
        pgrep -f $@ | xargs ps -o user,pid,stat,rss,vsz,pcpu,args \
                               --sort -pcpu,-rss;
    else
        exit 1;
    fi
}

# Set a pretty zsh prompt, taking 0..5 args as colors
setprompt ()
{
    # load this to use $fg
    autoload -U colors
    colors

    c1="%{${1:-"$fg[green]"}%}"             # main color for cmd, cwd, hist
    c2="%{${2:-"$fg_no_bold[cyan]"}%}"      # color for user@host
    c3="%{${3:-"$fg_bold[grey]"}%}"         # color for =,()
    c4="%{${4:-"$fg[white]"}%}"             # time and arrow color
    c5="%{${5:-"$fg[red]"}%}"               # root color

    now="$c3($c4%D{%H:%M} %D{%a %b %d}$c3)"
    userhost="%(!.$c5.$c2)%n$c3@$c2%m"

    line2="$userhost ${c3}[$c1%h$c3] ${c4}--> %(!.$c5.$c1)"
    newline=$'\n%{\r%}'

    # truncate and pad line1 appropiately
    precmd () {
        local cwdrealwidth=${#${(%):-%~}}

        # length of $line1 w/o $cwd = 22
        if [[ "$cwdrealwidth + 22" -gt $COLUMNS ]];
        then
            # truncate
            local cwdwidth = (( $COLUMNS - 22 ))
        else
            # pad
            local padding="${(l.(($COLUMNS - 22 - $cwdrealwidth )))..-.)}"
        fi

        local cwd="$c1%$cwdwidth<...<%~%<<"
        local line1="$c3-($cwd$c3)-${padding}$now"
        export PROMPT="${line1}$newline$line2"
    }

    preexec () { print -n "$reset_color" }
}
