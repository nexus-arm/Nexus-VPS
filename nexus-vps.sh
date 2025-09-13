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
  _        _______                    _______                  _______  _______  
( (    /|(  ____ \|\     /||\     /|(  ____ \       |\     /|(  ____ )(  ____ \ 
|  \  ( || (    \/( \   / )| )   ( || (    \/       | )   ( || (    )|| (    \/ 
|   \ | || (__     \ (_) / | |   | || (_____  _____ | |   | || (____)|| (_____  
| (\ \) ||  __)     ) _ (  | |   | |(_____  )(_____)( (   ) )|  _____)(_____  ) 
| | \   || (       / ( ) \ | |   | |      ) |        \ \_/ / | (            ) | 
| )  \  || (____/\( /   \ )| (___) |/\____) |         \   /  | )      /\____) | 
|/    )_)(_______/|/     \|(_______)\_______)          \_/   |/       \_______) 
                                                                                
EOF
    echo -e "${CYAN}             A Comprehensive Pentesting Tool Installer (Ubuntu Edition)${NC}"
    echo ""
}

# --- Menu Display Functions ---
display_main_menu() {
    echo -e "${YELLOW}======================================================${NC}"
    echo -e "                    ${YELLOW}MAIN MENU${NC}"
    echo -e "${YELLOW}======================================================${NC}"
    echo " 1) Install Pentest Tools (Manual/All)"
    echo " 2) Install Graphical Environment (GUI)"
    echo " 3) Install Lily (Cybersecurity AI Assistant)"
    echo " 4) Check Tool Versions"
    echo " 5) Re-install All Pentest Tools"
    echo " 0) Exit"
    echo -e "${YELLOW}======================================================${NC}"
}

display_pentest_menu() {
    echo -e "${YELLOW}======================================================${NC}"
    echo -e "                 ${YELLOW}PENTEST TOOL INSTALLER${NC}"
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
    echo -e "            ${YELLOW}GRAPHICAL ENVIRONMENT INSTALLER${NC}"
    echo -e "${YELLOW}======================================================${NC}"
    echo " 1) Install Full GNOME Desktop (Standard Ubuntu Experience)"
    echo " 2) Install Lightweight XFCE Desktop (Xubuntu)"
    echo ""
    echo " 0) Return to Main Menu"
    echo -e "${YELLOW}======================================================${NC}"
}

# --- Prerequisites and Individual Install Functions ---

install_prerequisites() {
    echo "[*] Updating package list and installing essential base dependencies for Ubuntu..."
    sudo apt-get update
    # Added python-is-python3 for sqlmap compatibility
    sudo apt-get install -y git curl wget build-essential libpq-dev libpcap-dev gnupg2 haveged libcurl4-openssl-dev python3-dev python3-pip python-is-python3 ca-certificates software-properties-common
    
    # --- Install latest Golang ---
    if ! command -v go &>/dev/null; then
        echo -e "${YELLOW}[*] Installing Golang...${NC}"
        local GO_VERSION="1.22.5"
        wget "https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz" -O /tmp/go.tar.gz
        sudo rm -rf /usr/local/go
        sudo tar -C /usr/local -xzf /tmp/go.tar.gz; rm /tmp/go.tar.gz
        echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee /etc/profile.d/golang.sh
        export PATH=$PATH:/usr/local/go/bin
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
        (export PATH=$PATH:/usr/local/go/bin && go install github.com/ffuf/ffuf/v2@latest)
        sudo ln -sf "$HOME/go/bin/ffuf" /usr/local/bin/ffuf
        echo -e "${GREEN}[+] ffuf installed successfully.${NC}"
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
        sudo apt-get install -y ubuntu-desktop
        echo -e "${GREEN}[+] GNOME Desktop installation complete. Please run 'sudo reboot' to start the GUI.${NC}"
    else
        echo "[*] Installation cancelled."
    fi
}
install_xfce() {
    echo -e "${YELLOW}[*] Installing Lightweight XFCE Desktop (Xubuntu)...${NC}"
    read -p "Are you sure you want to continue? (y/n): " confirm
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        sudo apt-get install -y xubuntu-desktop
        echo -e "${GREEN}[+] XFCE Desktop installation complete. Please run 'sudo reboot' to start the GUI.${NC}"
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

# --- Lily AI Installation Function (DOCKERIZED) ---
install_lily() {
    echo "[*] Starting setup for Lily (Dockerized AI Assistant)..."

    # 1. Ensure Docker is installed and running
    install_docker
    if ! command -v docker &>/dev/null; then echo -e "${RED}[-] Docker installation failed.${NC}"; return 1; fi
    if ! docker info &>/dev/null; then
        sudo systemctl start docker; sleep 5
        if ! docker info &>/dev/null; then echo -e "${RED}[-] Docker service is not running.${NC}"; return 1; fi
    fi

    local container_name="ollama-lily"
    
    # 2. Start the Ollama container
    if ! sudo docker ps -a --format '{{.Names}}' | grep -q "^${container_name}$"; then
        echo -e "${YELLOW}[*] Creating and starting Ollama container...${NC}"
        local gpu_flag=""
        if command -v nvidia-smi &>/dev/null; then echo "[*] NVIDIA GPU detected."; gpu_flag="--gpus all"; else echo "[*] No NVIDIA GPU detected."; fi
        
        sudo docker pull ollama/ollama
        sudo docker run -d --name "$container_name" $gpu_flag -v ollama:/root/.ollama -p 11434:11434 ollama/ollama
        if [ $? -ne 0 ]; then echo -e "${RED}[-] Failed to start the Ollama container.${NC}"; return 1; fi
        
        echo "[*] Waiting for Ollama service inside Docker..."
        for i in {1..15}; do
            if sudo docker exec "$container_name" ollama list &>/dev/null; then echo -e "\n${GREEN}[+] Ollama service is active.${NC}"; break; fi
            echo -n "."; sleep 2
        done
        if ! sudo docker exec "$container_name" ollama list &>/dev/null; then echo -e "\n${RED}[-] Ollama service in Docker did not start.${NC}"; return 1; fi
    else
        echo -e "${GREEN}[*] Ollama container is already running.${NC}"
    fi

    # 3. Create the Lily model inside the container
    local model_name="lily-cyber-local"
    if ! sudo docker exec "$container_name" ollama list | grep -q "$model_name"; then
        echo -e "${YELLOW}[*] Setting up the Lily AI model...${NC}"
        read -p "Do you want to continue? (y/n): " confirm
        if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
            echo -e "${YELLOW}Please choose a model version:${NC}"
            echo "  1) Lighter (Q4_K_M, ~4.4 GB)  2) Heavier (Q5_K_M, ~5.1 GB)"
            read -p "Enter your choice [1-2]: " model_choice
            local model_file
            case $model_choice in
                1) model_file="Lily-7B-Instruct-v0.2.Q4_K_M.gguf";;
                2) model_file="Lily-7B-Instruct-v0.2.Q5_K_M.gguf";;
                *) echo -e "${RED}Invalid. Defaulting to lighter.${NC}"; model_file="Lily-7B-Instruct-v0.2.Q4_K_M.gguf";;
            esac
            
            local download_url="https://huggingface.co/segolilylabs/Lily-Cybersecurity-7B-v0.2-GGUF/resolve/main/${model_file}"
            
            echo -e "${YELLOW}[*] Downloading ${model_file} to host...${NC}"
            wget -O "/tmp/${model_file}" "$download_url"
            if [ ! -s "/tmp/${model_file}" ]; then echo -e "${RED}[-] Download failed.${NC}"; sudo rm -f "/tmp/${model_file}"; return 1; fi

            echo -e "${YELLOW}[*] Copying model into the container...${NC}"
            sudo docker cp "/tmp/${model_file}" "${container_name}:/root/${model_file}"
            if [ $? -ne 0 ]; then echo -e "${RED}[-] Failed to copy model to container.${NC}"; sudo rm -f "/tmp/${model_file}"; return 1; fi
            
            # Create a Modelfile inside the container pointing to the local .gguf file
            local modelfile_content="FROM /root/${model_file}\nSYSTEM \"You are Lily, a specialized AI assistant for cybersecurity.\""
            echo -e "$modelfile_content" | sudo docker exec -i "$container_name" tee /root/Modelfile > /dev/null

            echo -e "${YELLOW}[*] Creating model from local file inside container...${NC}"
            # Execute the create command using the newly created Modelfile
            sudo docker exec "$container_name" ollama create "$model_name" -f /root/Modelfile

            # Cleanup files from host and container
            sudo rm -f "/tmp/${model_file}"
            sudo docker exec "$container_name" rm "/root/${model_file}" "/root/Modelfile"

            if sudo docker exec "$container_name" ollama list | grep -q "$model_name"; then
                 echo -e "${GREEN}[+] Lily AI model created successfully.${NC}"
            else
                 echo -e "${RED}[-] Failed to create the Lily AI model.${NC}"; return 1
            fi
        else
            echo "[*] Lily setup cancelled."; return
        fi
    else
        echo -e "${GREEN}[*] Lily AI model already exists in the container.${NC}"
    fi

    # 4. Create the 'lily' command on the host system
    echo -e "${YELLOW}[*] Creating a global 'lily' command...${NC}"
    echo -e "#!/bin/bash\nsudo docker exec -i \"$container_name\" ollama run $model_name \"\$@\"" | sudo tee /usr/local/bin/lily > /dev/null
    sudo chmod +x /usr/local/bin/lily
    echo -e "${GREEN}[+] Success! Type 'lily' to chat.${NC}"
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
}
check_version() {
    local tool=$1; local cmd=$2
    if command -v $tool &>/dev/null; then echo -e "${GREEN}--- $tool ---${NC}"; eval $cmd; else echo -e "${RED}--- $tool not found ---${NC}"; fi; echo ""
}
reinstall_tools() {
    echo -e "${RED}WARNING: This will remove and re-install all tools.${NC}"
    read -p "Are you sure? (y/n): " confirm
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        echo "[*] Removing directories and symlinks..."; sudo rm -rf $INSTALL_DIR/{sqlmap,thc-hydra,nmap,beef,wfuzz,nikto,recon-ng}
        sudo rm -f /usr/local/bin/{sqlmap,hydra,nmap,ffuf,wfuzz,nikto,recon-ng,msfconsole,msfvenom,nvim}
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
    echo -e "${YELLOW}--- Verification Complete ---${NC}"
}
check_command() {
    local tool=${2:-$1}
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
        read -p "Select a desktop environment to install [0-2]: " choice
        case $choice in
            1) install_gnome; break ;;
            2) install_xfce; break ;;
            0) break ;;
            *) echo -e "${RED}Invalid option.${NC}" ;;
        esac
    done
}

# --- Main Program Loop ---
while true; do
    clear; display_logo; display_main_menu
    read -p "Please enter your choice: " choice
    case $choice in
        1) pentest_menu ;;
        2) gui_menu ;;
        3) install_lily ;;
        4) check_versions ;;
        5) reinstall_tools ;;
        0) echo "Exiting. Goodbye!"; exit 0 ;;
        *) echo -e "${RED}Invalid option. Please try again.${NC}" ;;
    esac
    echo ""; read -p "Press [Enter] to return to the menu..."
done

