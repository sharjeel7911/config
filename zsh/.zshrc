# Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Environment Variables & PATH setup
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/.local/zed.app/bin:$PATH"
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Linuxbrew
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
fi

# Custom Prompt
export PROMPT="%F{cyan}%1~%f -> "

#----------------------------------------------

# Aliases: System & Package Management
alias uppac='sudo pacman -Syu'
alias upaur='yay -Sua'
alias arpac='sudo pacman -Rns $(pacman -Qdtq)'
alias araur='yay -Yc'
alias checkpac='checkupdates'
alias checkaur='yay -Qua'

alias snap-list='sudo timeshift --list'
alias snap-restore='sudo timeshift --restore'
snap() {
    local today=$(date +'%Y-%m-%d')
    local comment="${1:-Pre-Update $today}"
    sudo timeshift --delete-all && sudo timeshift --create --comments "$comment"
}

#----------------------------------------------

alias cl='clear'
alias cl='printf "\e[H\e[2J\e[3J"'
alias ll='eza -la'
alias ls='eza'
alias oz='nano ~/.zshrc'
alias sz='source ~/.zshrc'
alias logout='gnome-session-quit --logout'
alias fs-ca='rm -rf ~/.local/state/noctalia/plugins/data/nightwatch75/file-search/*'
alias v='nvim'
#alias cat='bat'
alias og='XDG_CURRENT_DESKTOP=GNOME gnome-control-center'
alias vir='source .venv/bin/activate'

# Aliases: Git
alias gpom='git pull origin main'
alias gs='git status'
alias gc='git clone'
gacp() {
    local msg="${1:-.}"
    git add . && git commit -m "$msg" && git push origin main
}

# Aliases: Navigation
alias /="cd $HOME/"
alias uni="cd $HOME/0uni"
alias rep="cd $HOME/0repos"
alias pr="cd $HOME/0repos/projects"
alias sem="cd $HOME/0repos/semesters"
alias s5="cd $HOME/0repos/semesters/semester-05"
alias ai="cd $HOME/0repos/ai"
alias cs50="cd $HOME/0repos/ai/cs50-ai"
alias zoom="cd $HOME/0repos/ai/zoomcamp"
alias port="cd $HOME/0repos/portfolios"
alias neet="cd $HOME/0repos/neetcode-submissions/'Data Structures & Algorithms'"

# Custom Functions
run() {
  if [ -f "$1.cpp" ]; then
    g++ "$1.cpp" -o x && ./x
  elif [ -f "$1.c" ]; then
    gcc "$1.c" -o x && ./x
  elif [ -f "$1.py" ]; then
    python3 "$1.py"
  else
    echo "Custom Error: File '$1' (.cpp, .c, .py) not found"
  fi
}

ff() {
  local file
  file=$(find "$HOME" -type f 2>/dev/null | fzf --preview 'bat --color=always --style=numbers {}')
  [[ -n "$file" ]] && xdg-open "$file" >/dev/null 2>&1 &
}



#---------------------------------------------------------------------------------

# Aliases: MySQL / XAMPP
alias sql='mysql -u root -p -P 3306'
alias xampp='mysql -h 127.0.0.1 -P 3307 -u root'
alias start_sql='sudo systemctl start mysql'
alias start_xampp='sudo /opt/lampp/lampp start'
alias stop_sql='sudo systemctl stop mysql'
alias stop_xampp='sudo /opt/lampp/lampp stop'
alias status_sql='sudo systemctl status mysql'
alias status_xampp='sudo /opt/lampp/lampp status'

# Docker
alias start_dock="sudo systemctl start docker"
alias stop_dock="sudo systemctl stop docker"
alias stop_dock_c="sudo systemctl stop docker docker.socket"

eval "$(zoxide init zsh)"
export PATH="/usr/local/bin:$PATH"

# ==============================================================================================
ram() {
  smem -c "name pss" -H -k | awk '
  BEGIN {
    while (("cat /proc/meminfo" | getline) > 0) {
      mem[$1] = $2
    }
  }
  {
    p=$2; unit=substr(p, length(p)); num=substr(p, 1, length(p)-1)+0;
    if (unit=="K") num/=1024; else if (unit=="G") num*=1024;
    a[$1]+=num; total_pss+=num
  } 
  END {
    tot = mem["MemTotal:"]/1024/1024;
    free = mem["MemFree:"]/1024/1024;
    cache = (mem["Cached:"] + mem["Buffers:"])/1024/1024;
    kernel = (mem["Slab:"] + mem["PageTables:"])/1024/1024;
    shmem = mem["Shmem:"]/1024/1024;
    app_pss = total_pss/1024;
    
    used = tot - free;
    other_sys = used - (app_pss + cache + kernel + shmem);
    if (other_sys < 0) other_sys = 0;
    
    swaptot = mem["SwapTotal:"]/1024/1024;
    swapfree = mem["SwapFree:"]/1024/1024;
    swapused = swaptot - swapfree;

    ram_str = sprintf("%.2f / %.2f GB", used, tot);
    swap_str = sprintf("%.2f / %.2f GB", swapused, swaptot);

    # Header
    printf "┌─────────────────────────────────────────┬──────────────────────┐\n";
    printf "│ %-39s │ %20s │\n", "TOP 20 PROCESSES", "PSS RAM";
    printf "├─────────────────────────────────────────┼──────────────────────┤\n";

    # Sort processes internally inside awk
    n = 0;
    for (i in a) {
      n++;
      keys[n] = i;
      vals[n] = a[i];
    }
    for (i = 1; i <= n; i++) {
      for (j = i + 1; j <= n; j++) {
        if (vals[i] < vals[j]) {
          tmp_v = vals[i]; vals[i] = vals[j]; vals[j] = tmp_v;
          tmp_k = keys[i]; keys[i] = keys[j]; keys[j] = tmp_k;
        }
      }
    }

    # Print Top 20
    limit = (n < 20) ? n : 20;
    for (i = 1; i <= limit; i++) {
      val_str = sprintf("%.2f MB", vals[i]);
      printf "│ %-39s │ %20s │\n", substr(keys[i], 1, 39), val_str;
    }

    # Summary Section
    printf "├─────────────────────────────────────────┴──────────────────────┤\n";
    printf "│ %-62s │\n", "SYSTEM MEMORY SUMMARY";
    printf "├─────────────────────────────────────────┬──────────────────────┤\n";
    printf "│ %-39s │ %20s │\n", "1. User Apps (PSS)", sprintf("%.2f GB", app_pss);
    printf "│ %-39s │ %20s │\n", "2. System Cache/Buffers", sprintf("%.2f GB", cache);
    printf "│ %-39s │ %20s │\n", "3. Kernel (Slab/PageTables)", sprintf("%.2f GB", kernel);
    printf "│ %-39s │ %20s │\n", "4. Shared Memory (Shmem)", sprintf("%.2f GB", shmem);
    printf "│ %-39s │ %20s │\n", "5. Other System Services", sprintf("%.2f GB", other_sys);
    printf "│ %-39s │ %20s │\n", "6. Unused / Free RAM", sprintf("%.2f GB", free);
    printf "├─────────────────────────────────────────┼──────────────────────┤\n";
    printf "│ %-39s │ %20s │\n", "TOTAL ACTIVE RAM USED", ram_str;
    printf "│ %-39s │ %20s │\n", "SWAP STORAGE USED", swap_str;
    printf "└─────────────────────────────────────────┴──────────────────────┘\n";
  }'
}


# bun completions
[ -s "/home/shar/.bun/_bun" ] && source "/home/shar/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share:/usr/local/share:/usr/share"
