# Цвета для промпта
RED='\[\e[0;31m\]'
GREEN='\[\e[0;32m\]'
YELLOW='\[\e[0;33m\]'
BLUE='\[\e[0;34m\]'
MAGENTA='\[\e[0;35m\]'
CYAN='\[\e[0;36m\]'
WHITE='\[\e[1;37m\]'
RESET='\[\e[0m\]'  # Сброс цвета

# Функция для отображения текущей ветки Git
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Функция для формирования промпта (вызывается каждый раз)
build_prompt() {
    local git_branch=$(parse_git_branch)
    PS1="${GREEN}\u${RESET}@${BLUE}\h${RESET} "
    PS1+="${YELLOW}\w${RESET}"
    if [ -n "$git_branch" ]; then
        PS1+=" ${CYAN}${git_branch}${RESET}"
    fi
    PS1+="\n"
    PS1+="${MAGENTA}❯${RESET} "
}

# Устанавливаем PROMPT_COMMAND — вызываем build_prompt перед каждым промптом
# Цвета для алиасов
export LS_COLORS='di=34:fi=00:ln=36:pi=33:so=32:bd=34;46:cd=34;43:or=31;43:mi=01;05;37:ex=35:*.cmd=35:*.exe=35:*.bat=35:*.com=35:*.dll=35:*.reg=35:*.msi=35:*.tar=31:*.tgz=31:*.arj=31:*.taz=31:*.lzh=31:*.zip=31:*.z=31:*.Z=31:*.gz=31:*.jpg=31'


# Цветные версии стандартных команд
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias lh='ls -lh --color=auto'
alias lr='ls -R --color=auto'
alias tree='ls -R | grep "/$" | sed "s/[^-][^\/]*\//--/g" | sed "s/^/ /"'

# Поиск с цветом
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Системные команды с форматированием и цветом
alias df='df -h --color=auto'
alias du='du -h --color=auto'
alias free='free -h'

# Навигация
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'

# Управление процессами
alias ps='ps auxf'
alias psg='ps aux | grep'
alias top='htop'

# Сетевые команды
alias ping='ping -c 5'
alias traceroute='traceroute -I'

# Архивы
alias tarls='tar -tf'
alias targz='tar -xzvf'
alias tarbz2='tar -xjvf'
alias gzip='gzip -9n'

# История команд
alias history='history | grep'  # Быстрый поиск в истории

# Git (цветные и удобные)
alias gs='git status --short'
alias gl='git log --oneline --decorate'
alias gd='git diff --color'
alias ga='git add'
alias gc='git commit -m'
alias gb='git branch'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gp='git push'
alias gpl='git pull'
alias gr='git remote -v'
alias gt='git tag'
alias gst='git status'
alias gcam='git commit -am'
alias gm='git merge'
alias grb='git rebase'
alias gch='git cherry-pick'
alias gf='git fetch'
alias gcl='git clone'
alias gclean='git clean -fd'
alias gstash='git stash'
alias gpop='git stash pop'

# Python
alias py='python'
alias py3='python3'
alias pip='pip --no-cache-dir'
alias pipi='pip install'
alias pipl='pip list'
alias pipu='pip install --upgrade'
alias venv='python -m venv'

# Node.js/NPM
alias npmls='npm list --depth=0'
alias npmu='npm update'
alias nps='npm start'
alias npt='npm test'
alias npr='npm run'

# Docker
alias d='docker'
alias dps='docker ps'
alias dimages='docker images'
alias dlogs='docker logs'
alias dex='docker exec -it'
alias dst='docker stats'
alias drm='docker rm'
alias dkill='docker kill'

# Kubernetes
alias k='kubectl'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kl='kubectl logs'
alias ke='kubectl edit'
alias ka='kubectl apply -f'
alias kdel='kubectl delete'

# Дополнительные полезные алиасы
alias mkdir='mkdir -p'
alias chmod='chmod --verbose'
alias chown='chown --verbose'

# Информация о системе
alias uptime='uptime -p'
alias mem='free -mt'
alias ports='netstat -tulanp'
alias ipinfo='curl ifconfig.me'

# Очистка терминала
alias c='clear'
alias cl='clear'



retry() {
    local command="$*"
    local attempt=1

    while true; do
        echo "Попытка $attempt: $command"
        eval "$command"

        if [ $? -eq 0 ]; then
            echo "Команда выполнена успешно на попытке $attempt"
            return 0
        else
            echo "Ошибка на попытке $attempt, повтор через 1 секунду..."
            sleep 1
        fi

        ((attempt++))
    done
}

edit() {
    code ~/.bashrc
}


restart() {
    clear
    source ~/.bashrc
    echo "Изменения из .bashrc применены."
}

alias reload='restart'

e() {
    code .
}
clear() {
    # Пытаемся использовать команду clear
    if command -v clear &> /dev/null; then
        command clear
        return
    fi

    # Если clear нет, используем управляющие коды ANSI
    printf '\033[2J\033[H'  # Очистить экран и переместить курсор в начало
}



command -v zoxide &> /dev/null && eval "$(zoxide init bash)"