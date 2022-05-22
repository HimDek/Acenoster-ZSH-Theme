# Acenoster ZSH Theme: A multipurpose ZSH theme with a very detailed git and mercurial prompt.
# Much of the codebase is copied shamelessly from oh-my-zsh's agnoster theme (https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/agnoster.zsh-theme)
# Visually simillar to oh-my-zsh's fino theme (https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/fino.zsh-theme)

# README

# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://github.com/Lokaltog/powerline-fonts).
# Make sure you have a recent version: the code points that Powerline
# uses changed in 2012, and older versions will display incorrectly,
# in confusing ways. To test if your terminal and font support it, check that
# all the necessary characters are supported by copying the below
# command into your terminal.
# `echo "\ue0a0 \u263f \u293b \u27a6 \u2213 \u00b1 \u271a \u25b2 \u25bc \u2714 \u25cb \u2699 \u2717"`

# What does it show?
# Username@Hostname (Username turns red if root)
# '⤻' AWS profile name if any (profile name in red if contains "-prod" or "production")
# Full working directory
# Version control status:
#   Git branch '', detached head '➦' or Mercurial branch '☿'
#   Name of current git branch or revision@name of mercurial branch or bzr@revision of bazaar if any
#   '∓' if any untracked files present in git, mercurial or bazaar
#   '±' if any tracked files modified in git, mercurial or bazaar
#   '✚' if any modifications staged in git
#   '✔' if the working tree is clean in git, mercurial or bazaar
#   '▲' number of commits ahead of origin in git or mercurial if any
#   '▼' number of commits behind origin in git if any
# Virtual environment name if any
# '⚙:' No of background tasks if any
# '✗:' Previous command's exit code if non zero or '○' if zero.

CURRENT_BG='NONE'

# Characters
  BRANCH="\ue0a0"
  HGBRANCH="\u263f"
  AWSSYMBOL="\u293b"
  DETACHED="\u27a6"
  MINUSPLUS="\u2213"
  PLUSMINUS="\u00b1"
  CROSS="\u271a"
  UPTRIANGLE="\u25b2"
  DOWNTRIANGLE="\u25bc"
  CHECKMARK="\u2714"
  CIRCLE="\u25cb"
  GEAR="\u2699"
  WRONG="\u2717"

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context () {
  if [[ $EUID -eq 0 ]]; then
    echo "%{$FG[009]%}%B%n%b%{$reset_color%}%{$FG[239]%}@%{$reset_color%}%{$FG[033]%}%B%m%b%{$reset_color%}"
  else
    echo "%{$FG[040]%}%B%n%b%{$reset_color%}%{$FG[239]%}@%{$reset_color%}%{$FG[033]%}%B%m%b%{$reset_color%}"
  fi
}

# vsc_info git hooks
+vi-git () {

  # Check if local is clean or dirty
  dirty=$(parse_git_dirty)
  if [[ -n $dirty ]]; then
    # Check for untracked files
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
      git status --porcelain | grep '??' &> /dev/null ; then
      hook_com[unstaged]=" %{$FG[009]%}%B$MINUSPLUS%b%{$reset_color%}$hook_com[unstaged]"
    fi
  else
    hook_com[unstaged]=" %{$FG[040]%}%B$CHECKMARK%b%{$reset_color%}"
  fi

  # Check if local is ahead or behind remote
  local ahead behind
  ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
  (( $ahead )) && hook_com[misc]+=" %{$FG[033]%}%B$UPTRIANGLE${ahead}%b%{$reset_color%}"
  behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
  (( $behind )) && hook_com[misc]+=" %{$FG[009]%}%B$DOWNTRIANGLE${behind}%b%{$reset_color%}"
}

# Git: branch/detached head, dirty status
prompt_git () {
  (( $+commands[git] )) || return
  local ref dirty mode repo_path

   if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]]; then
    repo_path=$(git rev-parse --git-dir 2>/dev/null)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="$FG[203]$DETACHED$reset_color $(git rev-parse --short HEAD 2> /dev/null)"

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:git*+set-message:*' hooks git
    zstyle ':vcs_info:*' stagedstr " %{$FG[040]%}%B$CROSS%b%{$reset_color%}"
    zstyle ':vcs_info:*' unstagedstr " %{$FG[226]%}%B$PLUSMINUS%b%{$reset_color%}"
    zstyle ':vcs_info:*' formats '%u%c%m'
    zstyle ':vcs_info:*' actionformats '%u%c%m'
    vcs_info
    echo -n " %{$FG[239]%}on%{$reset_color%} ${${ref}/refs\/heads\//$FG[203]%B$BRANCH%b$reset_color }${vcs_info_msg_0_%%}${mode}"
  fi
}

prompt_bzr () {
  (( $+commands[bzr] )) || return

  # Test if bzr repository in directory hierarchy
  local dir="$PWD"
  while [[ ! -d "$dir/.bzr" ]]; do
    [[ "$dir" = "/" ]] && return
    dir="${dir:h}"
  done

  local bzr_status status_mod status_all revision
  if bzr_status=$(bzr status 2>&1); then
    status_mod=$(echo -n "$bzr_status" | head -n1 | grep "modified" | wc -m)
    status_all=$(echo -n "$bzr_status" | head -n1 | wc -m)
    revision=${$(bzr log -r-1 --log-format line | cut -d: -f1):gs/%/%%}
    if [[ $status_mod -gt 0 ]] ; then
      echo " %{$FG[239]%}on%{$reset_color%} bzr%{$FG[239]%}@%{$reset_color%}$revision %{$FG[226]%}%B$PLUSMINUS%b%{$reset_color%}"
    else
      if [[ $status_all -gt 0 ]] ; then
        echo " %{$FG[239]%}on%{$reset_color%} bzr%{$FG[239]%}@%{$reset_color%}$revision %{$FG[009]%}%B$MINUSPLUS%b%{$reset_color%}"
      else
        echo " %{$FG[239]%}on%{$reset_color%} bzr%{$FG[239]%}@%{$reset_color%}$revision %{$FG[040]%}%B$CHECKMARK%b%{$reset_color%}"
      fi
    fi
  fi
}

prompt_hg () {
  (( $+commands[hg] )) || return
  local ahead behind rev st cl branch
  if $(hg id >/dev/null 2>&1); then
    cl=" %{$FG[040]%}%B$CHECKMARK%b%{$reset_color%}"
    rev=$(hg id -n 2>/dev/null | sed 's/[^-0-9]//g')
    branch=$(hg id -b 2>/dev/null)
    if `hg st | grep -q "^\?"`; then
      cl=""
      st=" %{$FG[009]%}%B$MINUSPLUS%b%{$reset_color%}"
    fi
    if `hg st | grep -q "^[MA]"`; then
      cl=""
      st+=" %{$FG[226]%}%B$PLUSMINUS%b%{$reset_color%}"
    fi
    st=" %{$FG[239]%}on%{$reset_color%} %{$FG[244]%}%B$HGBRANCH%b%{$reset_color%} ${rev:gs/%/%%}%{$FG[239]%}@%{$reset_color%}${branch:gs/%/%%}$st"

    # Check if ahead of origin,
    ahead=$(hg log -r "draft()" | grep "summary" | wc -l)
    if [[ ahead -ne "0" ]]; then
      cl+=" %{$FG[033]%}%B$UPTRIANGLE${ahead}%b%{$reset_color%}"
    fi

    # Check if behind origin, commented because terribly slow
    #behind=$(hg incoming | grep "summary" | wc -l)
    #if [[ behind -ne "0" ]]; then
    #  cl+=" %{$FG[009]%}%B$DOWNTRIANGLE${behind}%b%{$reset_color%}"
    #fi

    echo "$st$cl"
  fi
}

# Dir: current working directory
prompt_dir () {
  echo " %{$FG[239]%}in%{$reset_color%} \"%{$fg_bold[white]%}%d%{$reset_color%}\""
}

# Virtualenv: current working virtualenv
prompt_virtualenv () {
  if [[ -n "$VIRTUAL_ENV" && -n "$VIRTUAL_ENV_DISABLE_PROMPT" ]]; then
    echo " %{$FG[239]%}using%{$reset_color%} <${VIRTUAL_ENV:t:gs/%/%%}>"
  fi
}

#AWS Profile:
# - display current AWS_PROFILE name
prompt_aws () {
  [[ -z "$AWS_PROFILE"  ]] && return
  case "$AWS_PROFILE" in
    *-prod|*production*) echo  " %{$FG[130]%}$AWSSYMBOL%{$reset_color%} %{$FG[009]%}${AWS_PROFILE:gs/%/%%}%{$reset_color%}" ;;
    *) echo " %{$FG[130]%}$AWSSYMBOL%{$reset_color%} %{$FG[040]%}${AWS_PROFILE:gs/%/%%}%{$reset_color%}" ;;
  esac
}

prompt_back_job () {
  local bg=$(jobs -l | wc -l)
  if [[ $bg -ne 0 ]]; then
    echo "─<%{$FG[033]%}%B$GEAR:$bg%b%{$reset_color%}>"
  fi
}

# Prompt character is the last exit code if non 0.
prompt_str () {
  local LAST_EXIT_CODE=$?
  if [[ $LAST_EXIT_CODE -ne "0" ]]; then
    echo "$(prompt_back_job)─<%{$FG[009]%}%B$WRONG:$LAST_EXIT_CODE%b%{$reset_color%}> "
  else
    echo "$(prompt_back_job)─%{$FG[040]%}%B$CIRCLE%b%{$reset_color%} "
  fi
}

get_space () {
  local STR=$1$2
  local zero='%([BSUbfksu]|([FB]|){*})'
  local LENGTH=${#${(S%%)STR//$~zero/}}
  local SPACES=$(( COLUMNS - LENGTH - ${ZLE_RPROMPT_INDENT:-1} ))

  (( SPACES > 0 )) || return
  printf ' %.0s' {1..$SPACES}
}

export VIRTUAL_ENV_DISABLE_PROMPT=1

## Main prompt

_LEFT="╭─\$(prompt_context)\$(prompt_aws)\$(prompt_dir)\$(prompt_git)\$(prompt_bzr)\$(prompt_hg)\$(prompt_virtualenv)"
_RIGHT=""

preprompt () {
  _SPACES=`get_space $_LEFT $_RIGHT`
  print
  print -rP "$_LEFT$_SPACES$_RIGHT"
}

setopt prompt_subst
PROMPT="╰\$(prompt_str)"

autoload -U add-zsh-hook
add-zsh-hook precmd preprompt
