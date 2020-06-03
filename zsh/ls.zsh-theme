PROMPT='%{$fg_bold[yellow]%}[%D%@] %{$fg_bold[green]%}%n@%m%{$reset_color%}:%{$fg_bold[blue]%}%5~%{$reset_color%}
%(!.%{$fg_bold[red]%}#%{$reset_color%}.%{$fg_bold[white]%}❯)%{$reset_color%} '

RPROMPT='$(git_prompt_info)'


# Git info
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg_bold[green]%}✓%{$reset_color%}"

# Git status
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}-%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[magenta]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[blue]%}>%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[cyan]%}=%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[yellow]%}?%{$reset_color%}"


function precmd {
    RETURN_CODE=$?
    END_TIME=$SECONDS

    if [[ -n $START_TIME && -n $COMMAND_EXEC ]]
    then
        echo $(perl -e "
            use Time::Elapsed qw(elapsed);
            use v5.24;
            my \$diff = $END_TIME - $START_TIME;
            if($RETURN_CODE){
                print('$fg_bold[red]⏎ Error[$RETURN_CODE] $fg_bold[white]')
            } else {
                print('$fg[green]⏎ Success $fg[white]')
            }
            if(\$diff > 3){
                print('- Execution Time: ' . elapsed(\$diff));
            }
        ")
        echo $reset_color
    fi
    unset COMMAND_EXEC
    unset START_TIME
    
}

function preexec {
    START_TIME=$SECONDS
    COMMAND_EXEC=1   
}