# Acenoster ZSH Theme: A multipurpose ZSH theme.
# Much of the original codebase was copied from oh-my-zsh's agnoster theme (https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/agnoster.zsh-theme) and other oh-my-zsh themes and plugins.
# Visually simillar to oh-my-zsh's fino theme (https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/fino.zsh-theme)

# Toggles: Set to 0 for off, 1 for on.
  ZSH_THEME_ACENOSTER_ALWAYS_SHOW_USER=1
  ZSH_THEME_ACENOSTER_ALWAYS_SHOW_HOST=1
  ZSH_THEME_ACENOSTER_SHOW_HG_PROMPT=1
  ZSH_THEME_ACENOSTER_SHOW_BATTERY=1
  ZSH_THEME_ACENOSTER_SHOW_TIMER=1
  ZSH_THEME_ACENOSTER_FLUENT_FLOW=1
  ZSH_THEME_ACENOSTER_LESS_ICONS=0
  ZSH_THEME_ACENOSTER_FOLLOW_COLOR_SCHEME=1
  ZSH_THEME_ACENOSTER_COMPACT=0

# Battery levels:
  ZSH_THEME_ACENOSTER_BATTERY_HIGH=80
  ZSH_THEME_ACENOSTER_BATTERY_LOW=40
  ZSH_THEME_ACENOSTER_BATTERY_CRIT=20

# Icons:
TERMINAL=$(basename "/"$(ps -o cmd -f -p $(cat /proc/$(echo $$)/stat | cut -d \  -f 4) | tail -1 | sed 's/ .*$//'))
if [[ $TERMINAL = "login" ]]; then
  AT_ICON="@"
  AWS_SYMBOL="AWS:"

  PLUS_ICON="+"
  DELETED_ICON="×"
  REMOVED_ICON="-"
  CHECKMARK_ICON="•"
  UNKNOWN_ICON="?"
  BANG_ICON="!"
  STASH_ICON="…"
  DOWN_ICON="↓"
  UP_ICON="↑"

  SHOCK_ICON="⌁"

  GEAR_ICON="B"
  WRONG_ICON="×"
  PROMPT_CHAR="O "
else
  AT_ICON="\uf564"
  AWS_SYMBOL="\uf270"

  PLUS_ICON="\uF055 "
  DELETED_ICON="\uf057 "
  REMOVED_ICON="\uf056 "
  CHECKMARK_ICON="\uf058 "
  UNKNOWN_ICON="\uF059 "
  BANG_ICON="\uf06a "
  STASH_ICON="\uf01c "
  DOWN_ICON="\uF0ab "
  UP_ICON="\uF0aa "

  BATTERY_100_ICON="\uf578 "
  BATTERY_90_ICON="\uf581 "
  BATTERY_80_ICON="\uf580 "
  BATTERY_70_ICON="\uf57f "
  BATTERY_60_ICON="\uf57e "
  BATTERY_50_ICON="\uf57d "
  BATTERY_40_ICON="\uf57c "
  BATTERY_30_ICON="\uf57b "
  BATTERY_20_ICON="\uf57a "
  BATTERY_10_ICON="\uf579 "
  BATTERY_0_ICON="\uf58d "
  SHOCK_ICON="\ufd1e "

  GEAR_ICON="\uf013"
  WRONG_ICON="\uf468"
  PROMPT_CHAR="\uf62f "

  if [[ $TERMINAL = "konsole" ]]; then
    AT_ICON="\uf564 "
    AWS_SYMBOL="\uf270 "
    GEAR_ICON="\uf013 "
    WRONG_ICON="\uf468 "
  fi
fi

acenoster_update_icons () {
  if [[ $ZSH_THEME_ACENOSTER_LESS_ICONS -eq 0 ]]; then
    ROOT_USER_ICON="\ue614 "
    USER_ICON="\uf508 "
    HOST_ICON="\uf6c3 "
    DIR_ICON="\ufc6e "

    GIT_ICON="\uf7a1 "
    HG_ICON="\uf223 "

    EXE_TIME_ICON="\uf608 "
    CALENDAR_ICON="\uf5f5 "
  else
    unset ROOT_USER_ICON USER_ICON HOST_ICON DIR_ICON GIT_ICON HG_ICON EXE_TIME_ICON CALENDAR_ICON
  fi
}

# Colors:
  COLOR_AWS="%{$FG[130]%}"            # Used by the AWS icon and profile name text.
  COLOR_GIT="%{$FG[203]%}"            # Used by the git icon and branch name text.
  COLOR_HG="%{$FG[244]%}"             # Used by the mercurial icon and branch name text.
  COLOR_BATTERY_FULL="%{$FG[040]%}"   # Used by the battery full icon and "100%" text.
  COLOR_BATTERY_NORMAL="%{$FG[036]%}"
  COLOR_RESET="%{$reset_color%}"
  COLOR_DULL="%{$FG[239]%}"
  COLOR_RED="%{$FG[009]%}"
  COLOR_GREEN="%{$FG[047]%}"
  COLOR_BLUE="%{$FG[051]%}"
  COLOR_YELLOW="%{$FG[226]%}"

acenoster_update_colors () {
  if [[ ZSH_THEME_ACENOSTER_FOLLOW_COLOR_SCHEME -eq 1 ]]; then
    COLOR_BATTERY_NORMAL="%{$fg[cyan]%}"
    COLOR_DULL="%{$fg[black]%}"
    COLOR_RED="%{$fg[red]%}"
    COLOR_GREEN="%{$fg[green]%}"
    COLOR_BLUE="%{$fg[blue]%}"
    COLOR_YELLOW="%{$fg[yellow]%}"
  fi
}

# Format options:
  ZSH_THEME_ACENOSTER_USER_PROMPT_FORMAT="%n"
  ZSH_THEME_ACENOSTER_HOST_PROMPT_FORMAT="%m"
  ZSH_THEME_ACENOSTER_DIR_PROMPT_FORMAT="\"%d\""
  ZSH_THEME_ACENOSTER_CLOCK_PROMPT_TIME_FORMAT="%I:%M:%S %P"
  ZSH_THEME_ACENOSTER_CALENDAR_PROMPT_DATE_FORMAT="%a %b %d, %Y"

# Appearance:
acenoster_update_appearance () {
  ZSH_THEME_ACENOSTER_USER_PROMPT_PREFIX="$COLOR_GREEN$USER_ICON"
  ZSH_THEME_ACENOSTER_USER_PROMPT_SUFFIX=""
  ZSH_THEME_ACENOSTER_ROOT_USER_PROMPT_PREFIX="$COLOR_RED$ROOT_USER_ICON"
  ZSH_THEME_ACENOSTER_ROOT_USER_PROMPT_SUFFIX="$ZSH_THEME_ACENOSTER_USER_SUFFIX"

  ZSH_THEME_ACENOSTER_HOST_PROMPT_PREFIX="$COLOR_DULL$AT_ICON$COLOR_BLUE"
  ZSH_THEME_ACENOSTER_HOST_PROMPT_SUFFIX=""

  ZSH_THEME_AWS_PREFIX=" $COLOR_AWS$AWS_SYMBOL "
  ZSH_THEME_AWS_SUFFIX=""

  ZSH_THEME_ACENOSTER_DIR_PROMPT_PREFIX=" $DIR_ICON"
  ZSH_THEME_ACENOSTER_DIR_PROMPT_SUFFIX=""

  ZSH_THEME_GIT_PROMPT_PREFIX=""
  ZSH_THEME_GIT_PROMPT_SUFFIX=""
  ZSH_THEME_GIT_PROMPT_SEPARATOR=""
  ZSH_THEME_GIT_PROMPT_BRANCH=" $COLOR_GIT$GIT_ICON"
  ZSH_THEME_GIT_PROMPT_BEHIND=" $COLOR_RED$DOWN_ICON"
  ZSH_THEME_GIT_PROMPT_AHEAD=" $COLOR_BLUE$UP_ICON"
  ZSH_THEME_GIT_PROMPT_STAGED=" $COLOR_GREEN$PLUS_ICON"
  ZSH_THEME_GIT_PROMPT_CONFLICTS=" $COLOR_RED$BANG_ICON"
  ZSH_THEME_GIT_PROMPT_CHANGED=" $COLOR_YELLOW$PLUS_ICON"
  ZSH_THEME_GIT_PROMPT_UNTRACKED=" $COLOR_RED$UNKNOWN_ICON"
  ZSH_THEME_GIT_PROMPT_STASHED=" $COLOR_BLUE$STASH_ICON"
  ZSH_THEME_GIT_PROMPT_CLEAN=" $COLOR_GREEN$CHECKMARK_ICON"

  ZSH_THEME_HG_PROMPT_PREFIX="$ZSH_THEME_GIT_PROMPT_PREFIX"
  ZSH_THEME_HG_PROMPT_SUFFIX="$ZSH_THEME_GIT_PROMPT_SUFFIX"
  ZSH_THEME_HG_PROMPT_SEPARATOR="$ZSH_THEME_GIT_PROMPT_SEPARATOR"
  ZSH_THEME_HG_PROMPT_BRANCH=" $COLOR_HG$HG_ICON"
  ZSH_THEME_HG_PROMPT_BEHIND="$ZSH_THEME_GIT_PROMPT_BEHIND"
  ZSH_THEME_HG_PROMPT_AHEAD="$ZSH_THEME_GIT_PROMPT_AHEAD"
  ZSH_THEME_HG_PROMPT_MODIFIED=" $COLOR_GREEN$PLUS_ICON"
  ZSH_THEME_HG_PROMPT_ADDED=" $COLOR_YELLOW$PLUS_ICON"
  ZSH_THEME_HG_PROMPT_REMOVED=" $COLOR_YELLOW$REMOVED_ICON"
  ZSH_THEME_HG_PROMPT_DELETED=" $COLOR_RED$DELETED_ICON"
  ZSH_THEME_HG_PROMPT_UNKNOWN="$ZSH_THEME_GIT_PROMPT_UNTRACKED"
  ZSH_THEME_HG_PROMPT_CLEAN="$ZSH_THEME_GIT_PROMPT_CLEAN"

  ZSH_THEME_VIRTUALENV_PREFIX=" ["
  ZSH_THEME_VIRTUALENV_SUFFIX="] "

  ZSH_THEME_ACENOSTER_TIMER_PROMPT_PREFIX=" $COLOR_BLUE$EXE_TIME_ICON"
  ZSH_THEME_ACENOSTER_TIMER_PROMPT_SUFFIX=""

  ZSH_THEME_ACENOSTER_EMOJI_CLOCK_PROMPT_PREFIX=" "
  ZSH_THEME_ACENOSTER_EMOJI_CLOCK_PROMPT_SUFFIX=""

  ZSH_THEME_ACENOSTER_CLOCK_PROMPT_PREFIX=""
  ZSH_THEME_ACENOSTER_CLOCK_PROMPT_SUFFIX=""

  ZSH_THEME_ACENOSTER_CALENDAR_PROMPT_PREFIX=" $CALENDAR_ICON"
  ZSH_THEME_ACENOSTER_CALENDAR_PROMPT_SUFFIX=""

  ZSH_THEME_ACENOSTER_BACK_JOB_PROMPT_PREFIX="<$COLOR_BLUE$GEAR_ICON:"
  ZSH_THEME_ACENOSTER_BACK_JOB_PROMPT_SUFFIX=">─"
  ZSH_THEME_ACENOSTER_STRING_PROMPT="$COLOR_GREEN$PROMPT_CHAR"
  ZSH_THEME_ACENOSTER_ERROR_STRING_PROMPT_PREFIX="<$COLOR_RED$WRONG_ICON:"
  ZSH_THEME_ACENOSTER_ERROR_STRING_PROMPT_SUFFIX="> "

  if [[ $ZSH_THEME_ACENOSTER_FLUENT_FLOW -eq 1 ]]; then
    ZSH_THEME_ACENOSTER_HOST_PROMPT_PREFIX="$COLOR_DULL at$COLOR_RESET $COLOR_BLUE$HOST_ICON"
    ZSH_THEME_ACENOSTER_DIR_PROMPT_PREFIX="$COLOR_DULL in$COLOR_RESET$ZSH_THEME_ACENOSTER_DIR_PROMPT_PREFIX"
    ZSH_THEME_GIT_PROMPT_PREFIX="$COLOR_DULL on$COLOR_RESET$ZSH_THEME_GIT_PROMPT_PREFIX"
    ZSH_THEME_HG_PROMPT_PREFIX="$ZSH_THEME_GIT_PROMPT_PREFIX"
    ZSH_THEME_VIRTUALENV_PREFIX="$COLOR_DULL using$COLOR_RESET$ZSH_THEME_VIRTUALENV_PREFIX"
    ZSH_THEME_ACENOSTER_TIMER_PROMPT_PREFIX="$COLOR_DULL took$COLOR_RESET$ZSH_THEME_ACENOSTER_TIMER_PROMPT_PREFIX"
    ZSH_THEME_ACENOSTER_EMOJI_CLOCK_PROMPT_PREFIX="$COLOR_DULL at$COLOR_RESET$ZSH_THEME_ACENOSTER_EMOJI_CLOCK_PROMPT_PREFIX"
    ZSH_THEME_ACENOSTER_CALENDAR_PROMPT_PREFIX="$COLOR_DULL on$COLOR_RESET$ZSH_THEME_ACENOSTER_CALENDAR_PROMPT_PREFIX"
    ZSH_THEME_ACENOSTER_FLUENT_FLOW_BEFORE=$ZSH_THEME_ACENOSTER_FLUENT_FLOW
  fi
}

# Username
acenoster_prompt_user () {
  [[ -z $ZSH_THEME_ACENOSTER_USER_PROMPT_FORMAT ]] && return
  if [[ $EUID -eq 0 ]]; then
    echo "$COLOR_RESET$ZSH_THEME_ACENOSTER_ROOT_USER_PROMPT_PREFIX$ZSH_THEME_ACENOSTER_USER_PROMPT_FORMAT$COLOR_RESET$ZSH_THEME_ACENOSTER_ROOT_USER_PROMPT_SUFFIX$COLOR_RESET"
  elif [[ $ZSH_THEME_ACENOSTER_ALWAYS_SHOW_USER != 0 || -n "$SSH_CLIENT" ]]; then
    echo "$COLOR_RESET$ZSH_THEME_ACENOSTER_USER_PROMPT_PREFIX$ZSH_THEME_ACENOSTER_USER_PROMPT_FORMAT$COLOR_RESET$ZSH_THEME_ACENOSTER_USER_PROMPT_SUFFIX$COLOR_RESET"
  fi
}

# Hostname
acenoster_prompt_host () {
  [[ -z $ZSH_THEME_ACENOSTER_HOST_PROMPT_FORMAT ]] && return
  if [[ $ZSH_THEME_ACENOSTER_ALWAYS_SHOW_HOST != 0 || -n "$SSH_CLIENT" ]]; then
    echo "$COLOR_RESET$ZSH_THEME_ACENOSTER_HOST_PROMPT_PREFIX$ZSH_THEME_ACENOSTER_HOST_PROMPT_FORMAT$COLOR_RESET$ZSH_THEME_ACENOSTER_HOST_PROMPT_SUFFIX$COLOR_RESET"
  fi
}

# AWS Profile
acenoster_aws_prompt_info () {
  if type aws_prompt_info > /dev/null; then
    echo "$COLOR_RESET$(aws_prompt_info)$COLOR_RESET"
  fi
}

# Current Working Directory
acenoster_prompt_dir () {
  [[ -z $ZSH_THEME_ACENOSTER_DIR_PROMPT_FORMAT ]] && return
  echo "$COLOR_RESET$ZSH_THEME_ACENOSTER_DIR_PROMPT_PREFIX$COLOR_RESET$ZSH_THEME_ACENOSTER_DIR_PROMPT_FORMAT$COLOR_RESET$ZSH_THEME_ACENOSTER_DIR_PROMPT_SUFFIX$COLOR_RESET"
}

# git branch, tracking and local status
acenoster_git_super_status () {
  if type git_super_status > /dev/null; then
    echo "$COLOR_RESET$(git_super_status)$COLOR_RESET"
  fi
}

# Mercurial  branch, tracking and local status
acenoster_prompt_hg () {
  [[ $ZSH_THEME_ACENOSTER_SHOW_HG_PROMPT = 0 ]] && return
  (( $+commands[hg] )) || return
  if $(hg id >/dev/null 2>&1); then
    local rev="$(hg id -n 2>/dev/null | sed 's/[^-0-9]//g')"
    local branch="$(hg id -b 2>/dev/null)"
    local hg_status=`hg st`
    local hg_rev_branch="${rev:gs/%/%%}@${branch:gs/%/%%}"
    local hg_unknown="$(echo $hg_status | grep "^\?" | wc -l)"
    local hg_modified="$(echo $hg_status | grep "^\M" | wc -l)"
    local hg_added="$(echo $hg_status | grep "^\A" | wc -l)"
    local hg_removed="$(echo $hg_status | grep "^\R" | wc -l)"
    local hg_deleted="$(echo $hg_status | grep "^\!" | wc -l)"
    local hg_ahead="$(hg log -r "draft()" | grep "summary" | wc -l)"
    # local hg_behind="$(hg incoming | grep "summary" | wc -l)"

    local hg_status="%{${reset_color}%}$ZSH_THEME_HG_PROMPT_PREFIX%{${reset_color}%}$ZSH_THEME_HG_PROMPT_BRANCH$hg_rev_branch%{${reset_color}%}"
    if [[ "$hg_behind" -ne "0" ]]; then
      hg_status="$hg_status$ZSH_THEME_HG_PROMPT_BEHIND$hg_behind%{$reset_color%}"
    fi
    if [[ "$hg_ahead" -ne "0" ]]; then
      hg_status="$hg_status$ZSH_THEME_HG_PROMPT_AHEAD$hg_ahead%{$reset_color%}"
    fi
    hg_status="$hg_status$ZSH_THEME_HG_PROMPT_SEPARATOR"
    if [[ "$hg_modified" -ne "0" ]]; then
      hg_status="$hg_status$ZSH_THEME_HG_PROMPT_MODIFIED$hg_modified%{$reset_color%}"
    fi
    if [[ "$hg_added" -ne "0" ]]; then
      hg_status="$hg_status$ZSH_THEME_HG_PROMPT_ADDED$hg_added%{$reset_color%}"
    fi
    if [[ "$hg_removed" -ne "0" ]]; then
      hg_status="$hg_status$ZSH_THEME_HG_PROMPT_REMOVED$hg_removed%{$reset_color%}"
    fi
    if [[ "$hg_deleted" -ne "0" ]]; then
      hg_status="$hg_status$ZSH_THEME_HG_PROMPT_DELETED$hg_deleted%{$reset_color%}"
    fi
    if [[ "$hg_unknown" -ne "0" ]]; then
      hg_status="$hg_status$ZSH_THEME_HG_PROMPT_UNKNOWN$hg_unknown%{$reset_color%}"
    fi
    if [[ "$hg_modified" -eq "0" && "$hg_added" -eq "0" && "$hg_removed" -eq "0" && "$hg_deleted" -eq "0" && "$hg_unknown" -eq "0" ]]; then
      hg_status="$hg_status$ZSH_THEME_HG_PROMPT_CLEAN%{${reset_color}%}"
    fi
    hg_status="$hg_status$ZSH_THEME_HG_PROMPT_SUFFIX%{${reset_color}%}"
    echo "$hg_status"
  fi
}

# Virtual environment name
acenoster_virtualenv_prompt_info () {
  if type virtualenv_prompt_info > /dev/null; then
    echo "$COLOR_RESET$(virtualenv_prompt_info)$COLOR_RESET"
  fi
}

# Battery percentage and status
acenoster_prompt_battery () {
  [[ $ZSH_THEME_ACENOSTER_SHOW_BATTERY = 0 ]] && return
  (( $+commands[acpi] )) || return
  if [[ $OSTYPE = linux* ]]; then
    local out col="$COLOR_BATTERY_NORMAL" bat=$( acpi | grep -o "[0-9]**%" | grep -o "[0-9]**" )
    if [[ "$(acpi | grep -o "Charging")" = "Charging" ]]; then
      out="$COLOR_YELLOW$SHOCK_ICON$COLOR_RESET"
      if [[ $bat -ge $ZSH_THEME_ACENOSTER_BATTERY_HIGH ]]; then
        col="$COLOR_GREEN"
      fi
    elif [[ $bat = 100 ]]; then
      out="$COLOR_YELLOW$SHOCK_ICON$COLOR_RESET"
      col="$COLOR_BATTERY_FULL"
    elif [[ $bat -ge $ZSH_THEME_ACENOSTER_BATTERY_HIGH ]]; then
      col="$COLOR_GREEN"
    elif [[ $bat > $ZSH_THEME_ACENOSTER_BATTERY_CRIT && $bat -le $ZSH_THEME_ACENOSTER_BATTERY_LOW ]]; then
      col="$COLOR_YELLOW"
    elif [[ $bat -le $ZSH_THEME_ACENOSTER_BATTERY_CRIT ]]; then
      col="$COLOR_RED"
    fi

    if [[ $bat > 95 || $bat = "100" ]]; then
      out+="$col$BATTERY_100_ICON$bat%%$COLOR_RESET"
    elif [[ $bat < 96 && $bat > 85 ]]; then
      out+="$col$BATTERY_90_ICON$bat%%$COLOR_RESET"
    elif [[ $bat < 86 && $bat > 75 ]]; then
      out+="$col$BATTERY_80_ICON$bat%%$COLOR_RESET"
    elif [[ $bat < 76 && $bat > 65 ]]; then
      out+="$col$BATTERY_70_ICON$bat%%$COLOR_RESET"
    elif [[ $bat < 66 && $bat > 55 ]]; then
      out+="$col$BATTERY_60_ICON$bat%%$COLOR_RESET"
    elif [[ $bat < 56 && $bat > 45 ]]; then
      out+="$col$BATTERY_50_ICON$bat%%$COLOR_RESET"
    elif [[ $bat < 46 && $bat > 35 ]]; then
      out+="$col$BATTERY_40_ICON$bat%%$COLOR_RESET"
    elif [[ $bat < 36 && $bat > 25 ]]; then
      out+="$col$BATTERY_30_ICON$bat%%$COLOR_RESET"
    elif [[ $bat < 26 && $bat > 15 ]]; then
      out+="$col$BATTERY_20_ICON$bat%%$COLOR_RESET"
    elif [[ $bat < 16 && $bat > 5 ]]; then
      out+="$col$BATTERY_10_ICON$bat%%$COLOR_RESET"
    else
      out+="$col$BATTERY_0_ICON$bat%%$COLOR_RESET"
    fi
    echo " $out"
  fi
}

timer_current_time() {
  zmodload zsh/datetime
  echo $EPOCHREALTIME
}

timer_format_duration() {
  local mins=$(printf '%.0f' $(($1 / 60)))
  local secs=$(printf "%.${TIMER_PRECISION:-3}f" $(($1 - 60 * mins)))
  local duration_str=$(echo "${mins}m ${secs}s")
  echo "${duration_str#0m }"
}

# Last command execution time
acenoster_prompt_timer () {
  [[ $ZSH_THEME_ACENOSTER_SHOW_TIMER = 0 ]] && return
  if [ -n "${timer_cmd_start_time}" ]; then
    local cmd_end_time=$(timer_current_time)
    local tdiff=$((cmd_end_time - timer_cmd_start_time))
    if [[ -z "${TIMER_THRESHOLD}" || ${tdiff} -ge "${TIMER_THRESHOLD}" ]]; then
        local tdiffstr=$(timer_format_duration ${tdiff})
        echo  "$COLOR_RESET$ZSH_THEME_ACENOSTER_TIMER_PROMPT_PREFIX${tdiffstr}$COLOR_RESET$ZSH_THEME_ACENOSTER_TIMER_PROMPT_SUFFIX$COLOR_RESET"
    fi
  fi
}

# Emoji clock
acenoster_emoji-clock () {
  echo "$COLOR_RESET$ZSH_THEME_ACENOSTER_EMOJI_CLOCK_PROMPT_PREFIX$(emoji-clock)$COLOR_RESET$ZSH_THEME_ACENOSTER_EMOJI_CLOCK_PROMPT_SUFFIX$COLOR_RESET"
}

# Digital clock
acenoster_prompt_clock () {
  if [[ -z $ZSH_THEME_ACENOSTER_CLOCK_PROMPT_TIME_FORMAT ]] && return
  local time="$(date "+$ZSH_THEME_ACENOSTER_CLOCK_PROMPT_TIME_FORMAT")"
  echo "$COLOR_RESET$ZSH_THEME_ACENOSTER_CLOCK_PROMPT_PREFIX$time$COLOR_RESET$ZSH_THEME_ACENOSTER_CLOCK_PROMPT_SUFFIX$COLOR_RESET"
}

# Calendar
acenoster_prompt_calendar () {
  if [[ -z $ZSH_THEME_ACENOSTER_CALENDAR_PROMPT_DATE_FORMAT ]] && return
  local date="$(date "+$ZSH_THEME_ACENOSTER_CALENDAR_PROMPT_DATE_FORMAT")"
  echo "$COLOR_RESET$ZSH_THEME_ACENOSTER_CALENDAR_PROMPT_PREFIX$date$COLOR_RESET$ZSH_THEME_ACENOSTER_CALENDAR_PROMPT_SUFFIX$COLOR_RESET"
}

# Number of background processes
acenoster_prompt_back_task () {
  if [[ $BACKGROUND_TASKS -eq "0" ]]; then
    return
  else
    echo "$COLOR_RESET$ZSH_THEME_ACENOSTER_BACK_JOB_PROMPT_PREFIX$BACKGROUND_TASKS$COLOR_RESET$ZSH_THEME_ACENOSTER_BACK_JOB_PROMPT_SUFFIX$COLOR_RESET"
  fi
}

# Last command error code
acenoster_prompt_str () {
  if [[ $LAST_EXIT_CODE -eq "0" ]]; then
    echo "$ZSH_THEME_ACENOSTER_STRING_PROMPT$COLOR_RESET"
  else
    echo "$ZSH_THEME_ACENOSTER_ERROR_STRING_PROMPT_PREFIX$LAST_EXIT_CODE$COLOR_RESET$ZSH_THEME_ACENOSTER_ERROR_STRING_PROMPT_SUFFIX$COLOR_RESET"
  fi
}

preexec () {
  timer_cmd_start_time=$(timer_current_time)
}

## Main prompt

get_space () {
  local str=$1$2
  local zero='%([BSUbfksu]|([FB]|){*})'
  local len=${#${(S%%)str//$~zero/}}
  local spaces=$(( COLUMNS - len -1 ))
  (( spaces > 0 )) || return
  printf ' %.0s' {1..$spaces}
}

precmd () {
  LAST_EXIT_CODE=$?
  BACKGROUND_TASKS=$(jobs -l | wc -l)
  acenoster_update_icons
  acenoster_update_colors
  acenoster_update_appearance
  local left="╭─$(acenoster_prompt_user)$(acenoster_prompt_host)$(acenoster_aws_prompt_info)$(acenoster_prompt_dir)$(acenoster_git_super_status)$(acenoster_prompt_hg)$(acenoster_virtualenv_prompt_info)"
  local right="$(acenoster_prompt_battery)$(acenoster_prompt_timer)$(acenoster_emoji-clock)$(acenoster_prompt_clock)$(acenoster_prompt_calendar)"
  local spaces=$(get_space $left $right)
  if [[ $ZSH_THEME_ACENOSTER_COMPACT -eq 0 ]]; then print; fi
  print -P "$left$spaces$right"
  unset timer_cmd_start_time
}

PROMPT="╰─\$(acenoster_prompt_back_task)\$(acenoster_prompt_str)"
RPROMPT=""
