# Zinit ====================================================

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
  command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
  command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk
zinit light zsh-users/zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
zinit light zsh-users/zsh-autosuggestions

# ===========================================================


# Basin Settings ============================================

export PATH=$PATH:/usr/bin:/user/sbin
export PATH=$PATH:$HOME/bin:$HOME/opt/bin
export LANG=ja_JP.UTF-8
export LC_ALL=en_US.UTF-8
export HISTSIZE=100000
export SAVEHIST=100000
export EDITOR=nvim
bindkey -e # emacs LIKEなキーバインド(これがないと^F -> とかが使えない)

setopt auto_list # 補完候補が複数あるときに一覧表示
setopt auto_menu # Tabで補完候補を順に補完(よくわからん)
setopt auto_pushd # cdを行なった際、元いたディレクトリをスタック
setopt pushd_ignore_dups
setopt correct # 自動修正
setopt correct_all
setopt complete_aliases #aliasも補完(多分)
setopt auto_param_keys # 入力補助(あんまり使いどころはわからん)
setopt auto_param_slash # ディレクトリの補完で自動的に'/'を入れる
setopt mark_dirs # ファイル名の展開でディレクトリにマッチした場合末尾に'/'を付加する
setopt list_types # 補完候補に識別マークを表示(== ls -F)
setopt auto_cd # ディレクトリ名だけで移動できる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時、大文字小文字を区別しない
zstyle ':completion:*:default' menu select=1 # 補完候補をハイライト
setopt list_packed
setopt nolistbeep # ビープOFF
setopt complete_in_word # 語の途中でもカーソル位置で補完
setopt always_last_prompt # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt print_eight_bit  #日本語ファイル名等8ビットを通す
setopt magic_equal_subst     # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt globdots # 明確なドットの指定なしで.から始まるファイルをマッチ
setopt share_history # history share
# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin


zstyle ':completion:*:processes' command 'ps x -o pid,s,args' # ps コマンドのプロセス名補完

# history search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# 補完機能有効にする
autoload -U compinit
compinit -u

# 補完候補に色つける
autoload -U colors
colors
zstyle ':completion:*' list-colors "${LS_COLORS}"

# cd後自動でls
chpwd() {
  if [[ $(pwd) != $HOME ]]; then;
    ls -GF
  fi
}

# alias
alias ls="ls -GF"

# ===========================================================


# PATH ======================================================
#
# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# pyenv
export PATH=$HOME/.pyenv/bin:$PATH
eval "$(pyenv init -)"
export PATH=$HOME/.pyenv/shims:$PATH
eval "$(pyenv virtualenv-init -)"

# pipenv
# export PIPENV_VENV_IN_PROJECT=true
#
# nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# Flutter
export PATH="$PATH:$HOME/development/flutter/bin"

# Original Commands
export PATH="$HOME/dotfiles/bin:$PATH"

# ===========================================================


# Others ==================================================

# vim config
alias vimconf="cd ~/.config/vim && nvim ."
# nVim config
alias nvimconf="cd ~/.config/nvim && nvim ."
alias vim="nvim"

# tmux
# tmux自動起動
count=`ps aux | grep tmux | grep -v grep | wc -l`
if test $count -eq 0; then
    echo `tmux`
elif test $count -eq 1; then
    echo `tmux a`
fi

# fzf settings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fvim() {
  files=$(git ls-files) &&
  selected_files=$(echo "$files" | fzf -m --preview 'head -100 {}') &&
  vim $selected_files
}

# ag
alias ag="ag --pager 'less -R'"

# direnv
eval "$(direnv hook zsh)"

#============================================================


# prompt ====================================================
function custom_prompt {
  local branch_name st branch_status status_color

  text_color='%{\e[38;5;'
  back_color='%{\e[30;48;5;'

  c_gold='221m%}'
  c_black='000m%}'
  c_white='255m%}'
  c_cyan='051m%}'
  c_dark_cyan='004m%}'
  c_light_green='014m%}'
  c_red='001m%}'
  c_danger='052m%}'
  c_danger_t='009m%}'

  reset='%{\e[0m%}'
  sharp='\uE0B0'
  arrow='\u232A'
  branch='\ue0a0'
  bold='%{\e[1m%}'

  separator=${back_color}${c_black}${text_color}${c_dark_cyan}${sharp}${reset}
  separator_none=${back_color}${c_white}${text_color}${c_dark_cyan}${sharp}${reset}
  separator_confrict=${back_color}${c_danger}${text_color}${c_dark_cyan}${sharp}${reset}

  branch_name=`git symbolic-ref --short HEAD 2> /dev/null`
  if [ -z $branch_name ]; then
    # git 管理されていないディレクトリは何も返さない
    branch_status="${separator_none}${text_color}${c_white}${sharp}${reset}"
  else
    st=`git status 2> /dev/null`
    if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
      # 全て commit されてクリーンな状態
      branch_status="${separator}${back_color}${c_black}${text_color}${c_cyan} ${branch} ${branch_name} ${back_color}${c_cyan}${text_color}${c_black}${sharp}${reset}${text_color}${c_cyan}${sharp}${reset}"

    elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
      # git 管理されていないファイルがある状態
      branch_status="${separator}${back_color}${c_black}${text_color}${c_red} ${branch} [?] ${branch_name} ${back_color}${c_red}${text_color}${c_black}${sharp}${reset}${text_color}${c_red}${sharp}${reset}"

    elif [[ -n `echo "$st" | grep "^Unmerged paths"` ]]; then
      # コンフリクト状態
      branch_status="${separator_confrict}${back_color}${c_danger}${text_color}${c_danger_t} ${branch} [!!] ${branch_name} ${reset}${back_color}${c_danger_t}${text_color}${c_danger}${sharp}${reset}${text_color}${c_danger_t}${sharp}${reset}"

    elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
      # git add されていないファイルがある状態
      branch_status="${separator}${back_color}${c_black}${text_color}${c_red} ${branch} [+] ${branch_name} ${back_color}${c_red}${text_color}${c_black}${sharp}${reset}${text_color}${c_red}${sharp}${reset}"

    elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
      # git commit されていないファイルがある状態
      branch_status="${separator}${back_color}${c_black}${text_color}${c_gold} ${branch} [!] ${branch_name} ${back_color}${c_gold}${text_color}${c_black}${sharp}${reset}${text_color}${c_gold}${sharp}${reset}"

    else
      # 上記以外の状態の場合
      branch_status="${separator_confrict}${back_color}${c_danger}${text_color}${c_danger_t} ${branch} [!!] ${branch_name} ${reset}${back_color}${c_danger_t}${text_color}${c_danger}${sharp}${reset}${text_color}${c_danger_t}${sharp}${reset}"

    fi
  fi

  dir_color="${back_color}${c_dark_cyan}${text_color}${c_white}"
  arrow_color="${text_color}${c_light_green}"

  # プロジェクトルートからのPATHを取得
  chpwd () {
    git_root=$PWD
    while [[ $git_root != / && ! -e $git_root/.git ]]; do
      git_root=$git_root:h
    done
    if [[ $git_root = / ]]; then
      unset git_root
      Prompt_short_dir=%~
    else
      Prompt_short_dir=${PWD#$git_root:h/}
    fi
  }
  chpwd

  echo "${dir_color} ${Prompt_short_dir} ${branch_status}\n${arrow_color}${arrow}${reset}"

}

# コマンドの実行ごとに改行
function precmd() {
    if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
        NEW_LINE_BEFORE_PROMPT=1
    elif [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
        echo ""
    fi
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

PROMPT='`custom_prompt`'

# ===========================================================

