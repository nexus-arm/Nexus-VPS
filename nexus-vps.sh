#!/bin/bash

# --- Global Variables and Colors ---
INSTALL_DIR="/opt"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# --- Logo Display Function ---
display_logo() {
    echo -e "${GREEN}"
    cat << "EOF"
  _        _______                 _______                 _______ _______  
( (     /|(  ____ \|\     /||\     /|(  ____ \       |\     /|(  ____ )(  ____ \ 
|  \   ( || (    \/( \   / )| )   ( || (    \/       | )   ( || (    )|| (    \/ 
|   \ | || (__      \ (_) / | |   | || (_____  _____ | |   | || (____)|| (_____  
| (\ \) ||  __)      ) _ (  | |   | |(_____  )(_____)( (   ) )|  _____)(_____  ) 
| | \   || (        / ( ) \ | |   | |      ) |         \ \_/ / | (            ) | 
| )  \  || (____/\( /   \ )| (___) |/\____) |          \   /  | )       /\____) | 
|/    )_)(_______/|/     \|(_______)\_______)           \_/   |/        \_______) 
                                                                                
EOF
    echo -e "${CYAN}          A Comprehensive Pentesting Tool Installer v2 (Ubuntu Edition)${NC}"
    echo ""
}

# --- Menu Display Functions ---
display_main_menu() {
    echo -e "${YELLOW}======================================================${NC}"
    echo -e "                      ${YELLOW}MAIN MENU${NC}"
    echo -e "${YELLOW}======================================================${NC}"
    echo " 1) Install Pentest Tools (Manual/All)"
    echo " 2) Install Graphical Environment (GUI)"
    echo " 3) Install AI Assistants (Lily/Coder)"
    echo " 4) Manage n8n (Automation Workflow)"
    echo " 5) Check Tool Versions"
    echo " 6) Re-install All Pentest Tools"
    echo " 7) System & Network Information"
    echo " 0) Exit"
    echo -e "${YELLOW}======================================================${NC}"
}

display_pentest_menu() {
    echo -e "${YELLOW}======================================================${NC}"
    echo -e "                   ${YELLOW}PENTEST TOOL INSTALLER${NC}"
    echo -e "${YELLOW}======================================================${NC}"
    echo " 1)  SQLMap          8)  Wfuzz"
    echo " 2)  Hydra           9)  Metasploit"
    echo " 3)  Nmap            10) Nikto"
    echo " 4)  BeEF-XSS        11) Recon-ng"
    echo " 5)  ffuf            12) Nginx"
    echo " 6)  Docker          13) ProxyChains"
    echo " 7)  Neovim          14) Install ALL Tools"
    echo ""
    echo " 0) Return to Main Menu"
    echo -e "${YELLOW}======================================================${NC}"
}

display_gui_menu() {
    echo -e "${YELLOW}======================================================${NC}"
    echo -e "               ${YELLOW}GRAPHICAL ENVIRONMENT (GUI) MENU${NC}"
    echo -e "${YELLOW}======================================================${NC}"
    echo " 1) Install Full GNOME Desktop (Standard Ubuntu)"
    echo " 2) Install Lightweight XFCE Desktop (Xubuntu)"
    echo "------------------------------------------------------"
    echo " 3) Install xRDP (for Remote Desktop Access)"
    echo " 4) Check GUI Installation Status"
    echo " 5) Help: How to Access GUI Remotely (xRDP)"
    echo ""
    echo " 0) Return to Main Menu"
    echo -e "${YELLOW}======================================================${NC}"
}

display_ai_menu() {
    echo -e "${YELLOW}======================================================${NC}"
    echo -e "                 ${YELLOW}AI ASSISTANT INSTALLER & STATUS${NC}"
    echo -e "${YELLOW}======================================================${NC}"
    echo " 1) Install Lily (Cybersecurity AI)"
    echo " 2) Install Coder (Programming AI)"
    echo "------------------------------------------------------"
    echo " 3) Check AI Assistants Status"
    echo ""
    echo " 0) Return to Main Menu"
    echo -e "${YELLOW}======================================================${NC}"
}

display_n8n_menu() {
    echo -e "${YELLOW}======================================================${NC}"
    echo -e "                         ${YELLOW}n8n MANAGEMENT MENU${NC}"
    echo -e "${YELLOW}======================================================${NC}"
    echo " 1) Install n8n"
    echo " 2) Update n8n"
    echo " 3) Check n8n Version"
    echo " 4) Run n8n (using PM2 process manager)"
    echo " 5) Check n8n Service Status (PM2)"
    echo " 6) Stop n8n Service (PM2)"
    echo ""
    echo " 0) Return to Main Menu"
    echo -e "${YELLOW}======================================================${NC}"
}

display_sysinfo_menu() {
    echo -e "${YELLOW}======================================================${NC}"
    echo -e "               ${YELLOW}SYSTEM & NETWORK INFORMATION${NC}"
    echo -e "${YELLOW}======================================================${NC}"
    echo " 1) Run Network Speed Test (Speedtest CLI)"
    echo " 2) Display System Hardware Information (inxi)"
    echo " 3) Display Detailed Hardware List (lshw)"
    echo ""
    echo " 0) Return to Main Menu"
    echo -e "${YELLOW}======================================================${NC}"
}


# --- Prerequisites and Individual Install Functions ---

install_prerequisites() {
    echo "[*] Updating package list and installing essential base dependencies for Ubuntu..."
    sudo apt-get update
    sudo apt-get install -y git curl wget build-essential libpq-dev libpcap-dev gnupg2 haveged libcurl4-openssl-dev python3-dev python3-pip python-is-python3 ca-certificates software-properties-common

    # --- Install latest Golang using official repository ---
    if ! command -v go &>/dev/null; then
        echo -e "${YELLOW}[*] Installing Golang from official repository...${NC}"
        # Add the Go repository
        sudo add-apt-repository -y ppa:longsleep/golang-backports
        sudo apt-get update
        # Install the latest Go version
        sudo apt-get install -y golang-go
        # Set up Go environment
        echo 'export GOPATH=$HOME/go' | sudo tee -a /etc/profile.d/golang.sh
        echo 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' | sudo tee -a /etc/profile.d/golang.sh
        source /etc/profile.d/golang.sh
        # Create Go workspace
        mkdir -p $HOME/go/{bin,src,pkg}
    fi

    # --- Install latest Ruby with RVM ---
    if ! command -v rvm &>/dev/null; then
        echo -e "${YELLOW}[*] Installing RVM...${NC}"
        curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
        curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
        curl -sSL https://get.rvm.io | bash -s stable
    fi
    source_rvm
    
    local RUBY_VERSION="3.2.4"
    if ! rvm list rubies | grep -q "ruby-${RUBY_VERSION}"; then
        rvm install "${RUBY_VERSION}"
    fi
    rvm use "${RUBY_VERSION}" --default
}

source_rvm() {
    if [ -f /usr/local/rvm/scripts/rvm ]; then
        source /usr/local/rvm/scripts/rvm
    elif [ -f "$HOME/.rvm/scripts/rvm" ]; then
        source "$HOME/.rvm/scripts/rvm"
    fi
}

install_sqlmap() {
    install_tool "sqlmap" "https://github.com/sqlmapproject/sqlmap.git" "sudo ln -sf \"$INSTALL_DIR/sqlmap/sqlmap.py\" /usr/local/bin/sqlmap"
}
install_hydra() {
    install_tool "thc-hydra" "https://github.com/vanhauser-thc/thc-hydra.git" "cd \"$INSTALL_DIR/thc-hydra\" && ./configure && make && sudo make install"
}
install_nmap() {
    install_tool "nmap" "https://github.com/nmap/nmap.git" "cd \"$INSTALL_DIR/nmap\" && ./configure && make && sudo make install"
}
install_beef() {
    install_tool "beef" "https://github.com/beefproject/beef.git" "cd \"$INSTALL_DIR/beef\" && rvm use 3.2.4 do bundle install"
}
install_ffuf() {
    if ! command -v ffuf &>/dev/null; then
        echo -e "${YELLOW}[*] Installing ffuf...${NC}"
        
        # Explicitly source the Go environment to ensure the 'go' command is in the PATH
        if [ -f "/etc/profile.d/golang.sh" ]; then
            source "/etc/profile.d/golang.sh"
        else
            # Fallback for safety
            export PATH=$PATH:/usr/local/go/bin
        fi

        if ! command -v go &>/dev/null; then
            echo -e "${RED}[-] 'go' command not found. Cannot install ffuf. Please run the prerequisites installation first (Option 1 in the Pentest Menu).${NC}"
            return 1
        fi
        
        go install github.com/ffuf/ffuf/v2@latest
        if [ $? -eq 0 ]; then
            sudo ln -sf "$HOME/go/bin/ffuf" /usr/local/bin/ffuf
            echo -e "${GREEN}[+] ffuf installed successfully.${NC}"
        else
            echo -e "${RED}[-] Failed to install ffuf using 'go install'.${NC}"
        fi
    else
        echo -e "${GREEN}[*] ffuf is already installed. Skipping.${NC}"
    fi
}
install_docker() {
    if ! command -v docker &>/dev/null; then
        echo -e "${YELLOW}[*] Installing Docker Engine for Ubuntu...${NC}"
        sudo apt-get install -y ca-certificates
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        sudo chmod a+r /etc/apt/keyrings/docker.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        echo -e "${GREEN}[+] Docker Engine installed successfully.${NC}"
    else
        echo -e "${GREEN}[*] Docker is already installed. Skipping.${NC}"
    fi
}
install_neovim() {
    if ! command -v nvim &>/dev/null; then
        echo -e "${YELLOW}[*] Installing Neovim via official PPA...${NC}"
        sudo add-apt-repository -y ppa:neovim-ppa/stable
        sudo apt-get update
        sudo apt-get install -y neovim
        if command -v nvim &>/dev/null; then
            echo -e "${GREEN}[+] Neovim installed successfully.${NC}"
        else
            echo -e "${RED}[-] Failed to install Neovim from PPA.${NC}"
        fi
    else
        echo -e "${GREEN}[*] Neovim is already installed. Skipping.${NC}"
    fi
}
install_wfuzz() {
    if ! command -v wfuzz &>/dev/null; then
        echo -e "${YELLOW}[*] Installing Wfuzz via apt...${NC}"
        sudo apt-get install -y wfuzz
        if command -v wfuzz &>/dev/null; then
            echo -e "${GREEN}[+] Wfuzz installed successfully.${NC}"
        else
            echo -e "${RED}[-] Failed to install Wfuzz.${NC}"
        fi
    else
        echo -e "${GREEN}[*] Wfuzz is already installed. Skipping.${NC}"
    fi
}
install_metasploit() {
    if ! command -v msfconsole &>/dev/null; then
        echo -e "${YELLOW}[*] Installing Metasploit Framework...${NC}"
        curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb | sudo bash
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}[+] Metasploit installed successfully.${NC}"
        else
            echo -e "${RED}[-] Metasploit installation failed.${NC}"
        fi
    else
        echo -e "${GREEN}[*] Metasploit is already installed. Skipping.${NC}"
    fi
}
install_nikto() {
    install_tool "nikto" "https://github.com/sullo/nikto.git" "sudo ln -sf \"$INSTALL_DIR/nikto/program/nikto.pl\" /usr/local/bin/nikto"
}
install_recon_ng() {
    if ! command -v recon-ng &>/dev/null; then
        echo -e "${YELLOW}[*] Installing Recon-ng via apt...${NC}"
        sudo apt-get install -y recon-ng
        if command -v recon-ng &>/dev/null; then
            echo -e "${GREEN}[+] Recon-ng installed successfully.${NC}"
        else
            echo -e "${RED}[-] Failed to install Recon-ng.${NC}"
        fi
    else
        echo -e "${GREEN}[*] Recon-ng is already installed. Skipping.${NC}"
    fi
}
install_nginx() {
    if ! command -v nginx &>/dev/null; then
        sudo apt-get install -y nginx
    else
        echo -e "${GREEN}[*] Nginx is already installed. Skipping.${NC}"
    fi
}
install_proxychains() {
    if ! command -v proxychains4 &>/dev/null; then
        sudo apt-get install -y proxychains4
    else
        echo -e "${GREEN}[*] ProxyChains is already installed. Skipping.${NC}"
    fi
}
install_gnome() {
    echo -e "${YELLOW}[*] Installing Full GNOME Desktop... This will take a significant amount of time and disk space.${NC}"
    read -p "Are you sure you want to continue? (y/n): " confirm
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        echo "[*] Enabling universe repository and updating package lists..."
        sudo add-apt-repository -y universe
        sudo apt-get update
        echo "[*] Starting GNOME installation..."
        sudo apt-get install -y ubuntu-desktop
        if dpkg -l | grep -q 'ubuntu-desktop'; then
             echo -e "${GREEN}[+] GNOME Desktop installation complete. Please run 'sudo reboot' to start the GUI.${NC}"
        else
             echo -e "${RED}[-] GNOME Desktop installation failed. The package 'ubuntu-desktop' could not be installed.${NC}"
        fi
    else
        echo "[*] Installation cancelled."
    fi
}
install_xfce() {
    echo -e "${YELLOW}[*] Installing Lightweight XFCE Desktop (Xubuntu)...${NC}"
    read -p "Are you sure you want to continue? (y/n): " confirm
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        echo "[*] Enabling universe repository and updating package lists..."
        sudo add-apt-repository -y universe
        sudo apt-get update
        echo "[*] Starting XFCE installation..."
        sudo apt-get install -y xubuntu-desktop
        if dpkg -l | grep -q 'xubuntu-desktop'; then
            echo -e "${GREEN}[+] XFCE Desktop installation complete. Please run 'sudo reboot' to start the GUI.${NC}"
        else
            echo -e "${RED}[-] XFCE Desktop installation failed. The package 'xubuntu-desktop' could not be installed.${NC}"
        fi
    else
        echo "[*] Installation cancelled."
    fi
}
# --- Generic Tool Installer with Error Handling ---
install_tool() {
    local name=$1; local repo=$2; local cmd=$3
    if [ ! -d "$INSTALL_DIR/$name" ]; then
        echo -e "${YELLOW}[*] Installing $name...${NC}"; 
        sudo git clone --depth=1 "$repo" "$INSTALL_DIR/$name"
        if [ -n "$cmd" ]; then 
            if (source_rvm && eval "$cmd"); then
                echo -e "${GREEN}[+] $name configured successfully.${NC}"
            else
                echo -e "${RED}[-] Configuration failed for $name.${NC}"
                return 1
            fi
        fi
        echo -e "${GREEN}[+] $name installed successfully.${NC}"
    else
        echo -e "${GREEN}[*] $name is already installed. Skipping.${NC}"
    fi
}

# --- Full Installation Function ---
full_install_all() {
    echo "[*] Starting full installation of all penetration testing tools..."
    install_prerequisites
    sudo mkdir -p $INSTALL_DIR; cd $INSTALL_DIR || exit
    install_sqlmap; install_hydra; install_nmap; install_beef; install_ffuf;
    install_docker; install_neovim; install_wfuzz; install_metasploit;
    install_nikto; install_recon_ng; install_nginx; install_proxychains
    verify_installations
}

# --- n8n Management Functions ---
install_nodejs_nvm() {
    # Check if NVM is sourced, if not, try to source it.
    if ! command -v nvm &>/dev/null; then
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    fi

    # Now, check again. If it's still not available, install it.
    if ! command -v nvm &>/dev/null; then
        echo -e "${YELLOW}[*] Installing NVM (Node Version Manager)...${NC}"
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        # Source it for the current session
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        echo -e "${GREEN}[+] NVM installed successfully.${NC}"
    fi
    
    # Install Node.js LTS if not installed
    if ! command -v node &>/dev/null; then
        echo -e "${YELLOW}[*] Installing Node.js (LTS)...${NC}"
        nvm install --lts
        nvm use --lts
        nvm alias default 'lts/*'
        echo -e "${GREEN}[+] Node.js installed successfully.${NC}"
    fi
}

install_n8n() {
    if ! command -v n8n &>/dev/null; then
        echo -e "${YELLOW}[*] Installing n8n and PM2 globally via npm...${NC}"
        npm install n8n -g
        npm install pm2 -g
        if command -v n8n &>/dev/null; then
            echo -e "${GREEN}[+] n8n and PM2 installed successfully.${NC}"
        else
            echo -e "${RED}[-] Failed to install n8n.${NC}"
        fi
    else
        echo -e "${GREEN}[*] n8n is already installed.${NC}"
    fi
}

update_n8n() {
    if command -v n8n &>/dev/null; then
        echo -e "${YELLOW}[*] Updating n8n to the latest version...${NC}"
        npm install n8n@latest -g
        echo -e "${GREEN}[+] n8n update complete.${NC}"
    else
        echo -e "${RED}[-] n8n is not installed. Please install it first.${NC}"
    fi
}

check_n8n_version() {
    if command -v n8n &>/dev/null; then
        echo -e "${CYAN}--- n8n Version ---${NC}"
        n8n --version
    else
        echo -e "${RED}[-] n8n is not installed.${NC}"
    fi
}

run_n8n() {
    if ! command -v n8n &>/dev/null; then echo -e "${RED}[-] n8n is not installed.${NC}"; return; fi
    if ! command -v pm2 &>/dev/null; then echo -e "${RED}[-] PM2 is not installed. Installing...${NC}"; npm install pm2 -g; fi
    
    echo -e "${YELLOW}[*] Starting n8n with PM2...${NC}"
    
    # First, delete any existing n8n process managed by PM2 to ensure a clean start with the new environment variable
    pm2 delete n8n &>/dev/null
    
    # FIX: Set N8N_SECURE_COOKIE to false to prevent issues when accessing via HTTP
    # This environment variable is passed to the n8n process started by pm2
    N8N_SECURE_COOKIE=false pm2 start n8n
    
    # Configure PM2 to start on system boot
    pm2 startup
    # Save the current process list to be resurrected on reboot
    pm2 save
    
    echo -e "${GREEN}[+] n8n has been started in the background.${NC}"
    echo "[*] You can access the n8n UI at: http://$(hostname -I | awk '{print $1}'):5678"
    echo "[*] Use the status option in this menu to check its status."
}

check_n8n_status() {
     if command -v pm2 &>/dev/null; then
         echo -e "${CYAN}--- n8n Service Status (via PM2) ---${NC}"
         pm2 list
    else
         echo -e "${RED}[-] PM2 is not installed. Cannot check status.${NC}"
    fi
}

stop_n8n() {
    if command -v pm2 &>/dev/null; then
        echo -e "${YELLOW}[*] Stopping n8n service...${NC}"
        pm2 stop n8n
        echo -e "${GREEN}[+] n8n service stopped.${NC}"
    else
        echo -e "${RED}[-] PM2 is not installed. Cannot stop service.${NC}"
    fi
}


# --- AI Assistant Installation Functions ---

# Generic function to set up a dockerized Ollama model
setup_ollama_model() {
    local assistant_name=$1
    local model_name=$2
    local model_file_url=$3
    local system_prompt=$4
    local command_name=$5

    echo "[*] Starting setup for ${assistant_name} (Dockerized AI Assistant)..."
    install_docker
    if ! command -v docker &>/dev/null; then echo -e "${RED}[-] Docker installation failed.${NC}"; return 1; fi
    if ! docker info &>/dev/null; then
        sudo systemctl start docker; sleep 5
        if ! docker info &>/dev/null; then echo -e "${RED}[-] Docker service is not running.${NC}"; return 1; fi
    fi

    # Use a single, shared container for all ollama models to save resources
    local container_name="ollama-service"
    if ! sudo docker ps -a --format '{{.Names}}' | grep -q "^${container_name}$"; then
        echo -e "${YELLOW}[*] Creating and starting a shared Ollama container...${NC}"
        local gpu_flag=""
        if command -v nvidia-smi &>/dev/null; then echo "[*] NVIDIA GPU detected."; gpu_flag="--gpus all"; else echo "[*] No NVIDIA GPU detected."; fi
        sudo docker pull ollama/ollama
        sudo docker run -d --restart always --name "$container_name" $gpu_flag -v ollama:/root/.ollama -p 11434:11434 ollama/ollama
        if [ $? -ne 0 ]; then echo -e "${RED}[-] Failed to start the Ollama container.${NC}"; return 1; fi
        echo "[*] Waiting for Ollama service inside Docker..."
        for i in {1..15}; do
            if sudo docker exec "$container_name" ollama list &>/dev/null; then echo -e "\n${GREEN}[+] Ollama service is active.${NC}"; break; fi
            echo -n "."; sleep 2
        done
        if ! sudo docker exec "$container_name" ollama list &>/dev/null; then echo -e "\n${RED}[-] Ollama service in Docker did not start.${NC}"; return 1; fi
    else
        echo -e "${GREEN}[*] Shared Ollama container is already running.${NC}"
    fi

    if ! sudo docker exec "$container_name" ollama list | grep -q "$model_name"; then
        echo -e "${YELLOW}[*] Setting up the ${assistant_name} AI model...${NC}"
        read -p "Do you want to continue with the download? (y/n): " confirm
        if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
            local model_file=$(basename "$model_file_url")
            echo -e "${YELLOW}[*] Downloading ${model_file} to host...${NC}"
            wget -O "/tmp/${model_file}" "$model_file_url"
            if [ ! -s "/tmp/${model_file}" ]; then echo -e "${RED}[-] Download failed.${NC}"; sudo rm -f "/tmp/${model_file}"; return 1; fi
            echo -e "${YELLOW}[*] Copying model into the container...${NC}"
            sudo docker cp "/tmp/${model_file}" "${container_name}:/root/${model_file}"
            if [ $? -ne 0 ]; then echo -e "${RED}[-] Failed to copy model to container.${NC}"; sudo rm -f "/tmp/${model_file}"; return 1; fi
            local modelfile_content="FROM /root/${model_file}\nSYSTEM \"${system_prompt}\""
            echo -e "$modelfile_content" | sudo docker exec -i "$container_name" tee /root/Modelfile > /dev/null
            echo -e "${YELLOW}[*] Creating model from local file inside container...${NC}"
            sudo docker exec "$container_name" ollama create "$model_name" -f /root/Modelfile
            sudo rm -f "/tmp/${model_file}"
            sudo docker exec "$container_name" rm "/root/${model_file}" "/root/Modelfile"
            if sudo docker exec "$container_name" ollama list | grep -q "$model_name"; then
                 echo -e "${GREEN}[+] ${assistant_name} AI model created successfully.${NC}"
            else
                 echo -e "${RED}[-] Failed to create the ${assistant_name} AI model.${NC}"; return 1
            fi
        else
            echo "[*] ${assistant_name} setup cancelled."; return
        fi
    else
        echo -e "${GREEN}[*] ${assistant_name} AI model already exists in the container.${NC}"
    fi

    echo -e "${YELLOW}[*] Creating a global '${command_name}' command...${NC}"
    # FIX: Use -it for an interactive TTY session
    echo -e "#!/bin/bash\nsudo docker exec -it \"$container_name\" ollama run $model_name \"\$@\"" | sudo tee "/usr/local/bin/${command_name}" > /dev/null
    sudo chmod +x "/usr/local/bin/${command_name}"
    echo -e "${GREEN}[+] Success! Type '${command_name}' to chat.${NC}"
}

setup_lily() {
    echo -e "${YELLOW}Please choose a Lily model version:${NC}"
    echo "  1) Lighter (Q4_K_M, ~4.4 GB)  2) Heavier (Q5_K_M, ~5.1 GB)"
    read -p "Enter your choice [1-2]: " model_choice
    local model_file
    case $model_choice in
        1) model_file="Lily-7B-Instruct-v0.2.Q4_K_M.gguf";;
        2) model_file="Lily-7B-Instruct-v0.2.Q5_K_M.gguf";;
        *) echo -e "${RED}Invalid. Defaulting to lighter.${NC}"; model_file="Lily-7B-Instruct-v0.2.Q4_K_M.gguf";;
    esac
    local url="https://huggingface.co/segolilylabs/Lily-Cybersecurity-7B-v0.2-GGUF/resolve/main/${model_file}"
    setup_ollama_model "Lily" "lily-cyber-local" "$url" "You are Lily, a specialized AI assistant for cybersecurity." "lily"
}

setup_coder() {
    echo -e "${YELLOW}[*] Setting up Coder AI (Qwen2 7B, ~5 GB)...${NC}"
    local model_file="qwen2-7b-instruct-q5_k_m.gguf"
    local url="https://huggingface.co/Qwen/Qwen2-7B-Instruct-GGUF/resolve/main/${model_file}"
    setup_ollama_model "Coder" "coder-local" "$url" "You are a world-class AI programmer. Provide clean, efficient, and well-documented code." "coder"
}

# --- GUI Helper Functions ---
check_gui_install() {
    echo -e "${CYAN}[*] Checking GUI Installation Status...${NC}"
    if dpkg -l | grep -q 'ubuntu-desktop'; then
        echo -e "${GREEN}[+] Full GNOME Desktop (ubuntu-desktop) is installed.${NC}"
        echo "[*] To enter the GUI, please reboot your system with 'sudo reboot'."
    elif dpkg -l | grep -q 'xubuntu-desktop'; then
        echo -e "${GREEN}[+] Lightweight XFCE Desktop (xubuntu-desktop) is installed.${NC}"
        echo "[*] To enter the GUI, please reboot your system with 'sudo reboot'."
    else
        echo -e "${YELLOW}[-] No recognized desktop environment was found.${NC}"
    fi
}

gui_help() {
    echo -e "${CYAN}======================================================${NC}"
    echo -e "           ${CYAN}Help: Accessing Your GUI on a Remote Server${NC}"
    echo -e "${CYAN}======================================================${NC}"
    echo "This script installs the desktop environment, but to access it"
    echo "remotely (e.g., from your computer to a VPS), you need a"
    echo "remote desktop service like xRDP."
    echo ""
    echo -e "${YELLOW}--- Installation Steps for xRDP ---${NC}"
    echo "1. Install the xRDP service:"
    echo -e "   ${GREEN}sudo apt install xrdp -y${NC}"
    echo ""
    echo "2. Add the xrdp user to the 'ssl-cert' group (important):"
    echo -e "   ${GREEN}sudo adduser xrdp ssl-cert${NC}"
    echo ""
    echo "3. Enable the service to start on boot:"
    echo -e "   ${GREEN}sudo systemctl enable xrdp --now${NC}"
    echo ""
    echo "After these steps, you can connect to your server's IP address"
    echo "using a Remote Desktop client. You may also need to open"
    echo -e "port ${YELLOW}3389${NC} in your cloud provider's firewall."
    echo -e "${CYAN}======================================================${NC}"
}

install_xrdp() {
    if ! command -v xrdp &>/dev/null; then
        echo -e "${YELLOW}[*] Installing xRDP for remote desktop access...${NC}"
        sudo apt-get install -y xrdp
        echo "[*] Configuring permissions and restarting service..."
        sudo adduser xrdp ssl-cert
        sudo systemctl restart xrdp
        sudo systemctl enable xrdp
        if systemctl is-active --quiet xrdp; then
            echo -e "${GREEN}[+] xRDP installed and enabled successfully.${NC}"
            echo -e "[*] You can now connect to your server's IP address using a Remote Desktop client."
            echo -e "[*] You may need to open port ${YELLOW}3389${NC} in your cloud provider's firewall."
        else
            echo -e "${RED}[-] Failed to install or start xRDP.${NC}"
        fi
    else
        echo -e "${GREEN}[*] xRDP is already installed.${NC}"
        echo "[*] Restarting service to ensure correct permissions are applied..."
        sudo systemctl restart xrdp
        echo "[*] Service status:"
        sudo systemctl status xrdp --no-pager
    fi
}


check_ai_status() {
    echo -e "${CYAN}======================================================${NC}"
    echo -e "                 ${CYAN}AI ASSISTANTS STATUS CHECK${NC}"
    echo -e "${CYAN}======================================================${NC}"

    local container_name="ollama-service"

    if ! command -v docker &>/dev/null || ! docker info &>/dev/null; then
        echo -e "${RED}[-] Docker is not installed or the service is not running.${NC}"
        return
    fi

    echo -e "${YELLOW}--- Ollama Docker Container ---${NC}"
    if sudo docker ps -a --format '{{.Names}}' | grep -q "^${container_name}$"; then
        local status=$(sudo docker ps -a --filter "name=${container_name}" --format "{{.Status}}")
        echo -e "[+] Container '${container_name}' exists."
        echo -e "   - Status: ${GREEN}${status}${NC}"
        echo -e "\n${YELLOW}--- Installed AI Models ---${NC}"
        local models_list=$(sudo docker exec "$container_name" ollama list 2>/dev/null)
        
        if echo "$models_list" | grep -q "lily-cyber-local"; then
            echo -e "[+] Lily Model (lily-cyber-local): ${GREEN}Installed.${NC}"
        else
            echo -e "[-] Lily Model (lily-cyber-local): ${RED}Not installed.${NC}"
        fi

        if echo "$models_list" | grep -q "coder-local"; then
            echo -e "[+] Coder Model (coder-local): ${GREEN}Installed.${NC}"
        else
            echo -e "[-] Coder Model (coder-local): ${RED}Not installed.${NC}"
        fi
    else
        echo -e "${RED}[-] The Ollama container ('${container_name}') has not been installed yet.${NC}"
    fi
    echo -e "${CYAN}======================================================${NC}"
}

# --- System & Network Information Functions ---
install_sysinfo_tools() {
    local tools_to_install=""
    if ! command -v speedtest &>/dev/null; then tools_to_install+="speedtest-cli "; fi
    if ! command -v inxi &>/dev/null; then tools_to_install+="inxi "; fi
    if ! command -v lshw &>/dev/null; then tools_to_install+="lshw "; fi

    if [ -n "$tools_to_install" ]; then
        echo -e "${YELLOW}[*] Installing system information tools: ${tools_to_install}...${NC}"
        sudo apt-get install -y $tools_to_install
    fi
}

run_speedtest() {
    echo -e "${CYAN}[*] Running network speed test...${NC}"
    speedtest-cli
}

display_inxi() {
    echo -e "${CYAN}[*] Displaying system hardware summary (inxi)...${NC}"
    inxi -Fz
}

display_lshw() {
    echo -e "${CYAN}[*] Displaying detailed hardware list (lshw)...${NC}"
    sudo lshw -short
}


# --- Verification and Maintenance Functions ---
check_versions() {
    echo -e "${CYAN}[*] Checking installed tool versions...${NC}"; source_rvm
    export PATH=$PATH:/usr/local/go/bin
    check_version "sqlmap" "sqlmap --version"
    check_version "nmap" "nmap --version"
    check_version "hydra" "hydra -h | head -n 2"
    check_version "ffuf" "ffuf -V"
    check_version "wfuzz" "wfuzz --version"
    check_version "msfconsole" "msfconsole --version"
    check_version "nikto" "nikto -V"
    check_version "recon-ng" "recon-ng --version"
    check_version "nginx" "nginx -v"
    check_version "docker" "docker --version"
    check_version "nvim" "nvim --version"
    check_version "proxychains4" "proxychains4"
    check_version "n8n" "n8n --version"
}
check_version() {
    local tool=$1; local cmd=$2
    # Source NVM for node-based tools
    if [[ "$tool" == "n8n" ]]; then
        if [ -s "$HOME/.nvm/nvm.sh" ]; then source "$HOME/.nvm/nvm.sh"; fi
    fi
    if command -v $tool &>/dev/null; then echo -e "${GREEN}--- $tool ---${NC}"; eval $cmd; else echo -e "${RED}--- $tool not found ---${NC}"; fi; echo ""
}
reinstall_tools() {
    echo -e "${RED}WARNING: This will remove and re-install all tools.${NC}"
    read -p "Are you sure? (y/n): " confirm
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        echo "[*] Removing directories and symlinks..."; 
        sudo rm -rf $INSTALL_DIR/{sqlmap,thc-hydra,nmap,beef,wfuzz,nikto,recon-ng}
        sudo rm -f /usr/local/bin/{sqlmap,hydra,nmap,ffuf,wfuzz,nikto,recon-ng,msfconsole,msfvenom,nvim,lily,coder}
        if sudo docker ps -a --format '{{.Names}}' | grep -q "^ollama-service$"; then
            echo "[*] Stopping and removing the shared Ollama Docker container..."
            sudo docker stop ollama-service && sudo docker rm ollama-service
        fi
        if command -v n8n &>/dev/null; then
            echo "[*] Uninstalling n8n and pm2..."
            source "$HOME/.nvm/nvm.sh"
            npm uninstall n8n -g
            npm uninstall pm2 -g
        fi
        echo "[*] Starting re-installation..."; full_install_all
    else
        echo "[*] Re-installation cancelled."
    fi
}
verify_installations() {
    echo -e "\n${YELLOW}--- Verifying installations ---${NC}"; source_rvm
    export PATH=$PATH:/usr/local/go/bin
    check_command "sqlmap"; check_command "hydra"; check_command "nmap"; check_command "ffuf"; check_command "wfuzz"
    check_command "msfconsole" "Metasploit"; check_command "nikto"; check_command "recon-ng"
    check_manual_tool "$INSTALL_DIR/beef/beef" "Beef-XSS"
    check_command "nginx"; check_command "docker"; check_command "nvim" "Neovim"; check_command "proxychains4" "ProxyChains"
    check_command "lily"; check_command "coder"; check_command "n8n"
    echo -e "${YELLOW}--- Verification Complete ---${NC}"
}
check_command() {
    local tool=${2:-$1}
    if [[ "$tool" == "n8n" ]]; then
        if [ -s "$HOME/.nvm/nvm.sh" ]; then source "$HOME/.nvm/nvm.sh"; fi
    fi
    if command -v "$1" &>/dev/null; then echo -e "[${GREEN}+${NC}] $tool is available."; else echo -e "[${RED}-${NC}] $tool FAILED."; fi
}
check_manual_tool() {
    if [ -e "$1" ]; then echo -e "[${GREEN}+${NC}] $2 is available."; else echo -e "[${RED}-${NC}] $2 FAILED."; fi
}

# --- Menu Logic ---
pentest_menu() {
    install_prerequisites
    while true; do
        clear; display_logo; display_pentest_menu
        read -p "Select a tool to install [0-14]: " choice
        case $choice in
            1) install_sqlmap ;; 2) install_hydra ;; 3) install_nmap ;;
            4) install_beef ;; 5) install_ffuf ;; 6) install_docker ;;
            7) install_neovim ;; 8) install_wfuzz ;; 9) install_metasploit ;;
            10) install_nikto ;; 11) install_recon_ng ;; 12) install_nginx ;;
            13) install_proxychains ;; 14) full_install_all; break ;;
            0) break ;;
            *) echo -e "${RED}Invalid option.${NC}" ;;
        esac
        [ "$choice" != "14" ] && read -p "Press [Enter] to continue..."
    done
}
gui_menu() {
    while true; do
        clear; display_logo; display_gui_menu
        read -p "Select an option [0-5]: " choice
        case $choice in
            1) install_gnome; break ;;
            2) install_xfce; break ;;
            3) install_xrdp ;;
            4) check_gui_install ;;
            5) gui_help ;;
            0) break ;;
            *) echo -e "${RED}Invalid option.${NC}" ;;
        esac
        if [[ "$choice" != "0" && "$choice" != "1" && "$choice" != "2" ]]; then
            read -p "Press [Enter] to continue..."
        fi
    done
}

ai_assistant_menu() {
    while true; do
        clear; display_logo; display_ai_menu
        read -p "Select an option [0-3]: " choice
        case $choice in
            1) setup_lily ;;
            2) setup_coder ;;
            3) check_ai_status ;;
            0) break ;;
            *) echo -e "${RED}Invalid option.${NC}" ;;
        esac
        if [ "$choice" != "0" ]; then
            read -p "Press [Enter] to continue..."
        fi
    done
}

n8n_menu() {
    install_nodejs_nvm
    # Ensure nvm is sourced for the sub-menu shell
    if [ -s "$HOME/.nvm/nvm.sh" ]; then source "$HOME/.nvm/nvm.sh"; fi
    while true; do
        clear; display_logo; display_n8n_menu
        read -p "Select an option [0-6]: " choice
        case $choice in
            1) install_n8n ;;
            2) update_n8n ;;
            3) check_n8n_version ;;
            4) run_n8n ;;
            5) check_n8n_status ;;
            6) stop_n8n ;;
            0) break ;;
            *) echo -e "${RED}Invalid option.${NC}" ;;
        esac
        if [ "$choice" != "0" ]; then
            read -p "Press [Enter] to continue..."
        fi
    done
}

sysinfo_menu() {
    install_sysinfo_tools
    while true; do
        clear; display_logo; display_sysinfo_menu
        read -p "Select an option [0-3]: " choice
        case $choice in
            1) run_speedtest ;;
            2) display_inxi ;;
            3) display_lshw ;;
            0) break ;;
            *) echo -e "${RED}Invalid option.${NC}" ;;
        esac
        if [ "$choice" != "0" ]; then
            read -p "Press [Enter] to continue..."
        fi
    done
}


# --- Main Program Loop ---
while true; do
    clear; display_logo; display_main_menu
    read -p "Please enter your choice: " choice
    case $choice in
        1) pentest_menu ;;
        2) gui_menu ;;
        3) ai_assistant_menu ;;
        4) n8n_menu ;;
        5) check_versions ;;
        6) reinstall_tools ;;
        7) sysinfo_menu ;;
        0) echo "Exiting. Goodbye!"; exit 0 ;;
        *) echo -e "${RED}Invalid option. Please try again.${NC}" ;;
    esac
    echo ""; read -p "Press [Enter] to return to the menu..."
done

