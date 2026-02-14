# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# 主题
ZSH_THEME="robbyrussell"

# 插件
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    z
    docker
    kubectl
)

# 用户配置
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:$HOME/bin:$HOME/.local/bin"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/usr/lib64/mysql/

# 加载 oh-my-zsh
source $ZSH/oh-my-zsh.sh

# 编辑器
export EDITOR='nvim'
export VISUAL='nvim'

# 语言环境
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ===== 别名 =====
# 基础命令
alias vi='nvim'
alias vim='nvim'

# ls 别名 (兼容 macOS 和 Linux)
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS: 使用 -G 或检查是否有 GNU ls
    if command -v gls &> /dev/null; then
        alias ls='gls --color=auto -p'
    else
        alias ls='ls -Gp'
    fi
else
    # Linux
    alias ls='ls --color=auto -p'
fi
alias l='ls'
alias ll='ls -alF'
alias la='ls -A'
alias grep='grep --color=auto'
alias tmux='tmux -2'

# 目录导航
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git 别名
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gp='git push'
alias gpl='git pull --rebase'
alias gl='git log --oneline -10'
alias glg='git log --graph --oneline --decorate -10'
alias ga='git add'
alias gaa='git add --all'
alias gco='git checkout'
alias gsw='git switch'
alias gb='git branch'
alias gst='git stash'
alias gstp='git stash pop'

# 实用别名
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias week='date +%V'
alias ports='netstat -tulanp'
alias df='df -h'
alias du='du -h'
alias free='free -h'

# ===== 实用函数 =====
# 创建目录并进入
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# 解压各种格式
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.tar.xz)    tar xJf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# 快速查找文件
ff() {
    find . -type f -iname "*$1*"
}

# 快速查找目录
fd() {
    find . -type d -iname "*$1*"
}

# 在文件中搜索
search() {
    grep -rn "$1" .
}

# ===== 其他配置 =====
# pyenv (如果安装了)
if command -v pyenv &> /dev/null; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# fzf (如果安装了)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Homebrew (macOS)
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 历史记录配置
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
