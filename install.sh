#!/bin/bash

echo "[*] Starting installation..."

# Basic packages (only essentials from repo)
sudo apt update && sudo apt install -y git curl wget python3 python3-pip golang build-essential ruby ruby-dev

INSTALL_DIR="/opt"
sudo mkdir -p $INSTALL_DIR

# --- sqlmap ---
if [ ! -d "$INSTALL_DIR/sqlmap" ]; then
    echo "[*] Installing sqlmap..."
    sudo git clone --depth=1 https://github.com/sqlmapproject/sqlmap.git $INSTALL_DIR/sqlmap
    sudo ln -sf $INSTALL_DIR/sqlmap/sqlmap.py /usr/local/bin/sqlmap
fi

# --- Hydra ---
if ! command -v hydra &>/dev/null; then
    echo "[*] Installing Hydra..."
    cd $INSTALL_DIR
    sudo git clone https://github.com/vanhauser-thc/thc-hydra.git
    cd thc-hydra
    ./configure && make && sudo make install
    cd -
fi

# --- Nmap ---
if ! command -v nmap &>/dev/null; then
    echo "[*] Installing Nmap..."
    cd $INSTALL_DIR
    sudo git clone https://github.com/nmap/nmap.git
    cd nmap
    ./configure && make && sudo make install
    cd -
fi

# --- Beef-XSS ---
if [ ! -d "$INSTALL_DIR/beef" ]; then
    echo "[*] Installing Beef-XSS..."
    sudo git clone https://github.com/beefproject/beef.git $INSTALL_DIR/beef
    cd $INSTALL_DIR/beef
    sudo gem install bundler
    bundle install
    cd -
fi

# --- ffuf ---
if ! command -v ffuf &>/dev/null; then
    echo "[*] Installing ffuf..."
    go install github.com/ffuf/ffuf/v2@latest
    sudo ln -sf ~/go/bin/ffuf /usr/local/bin/ffuf
fi

# --- sqlsus ---
if [ ! -d "$INSTALL_DIR/sqlsus" ]; then
    echo "[*] Installing sqlsus..."
    sudo git clone https://github.com/emericdombo/sqlsus.git $INSTALL_DIR/sqlsus
fi

# --- wfuzz ---
if ! command -v wfuzz &>/dev/null; then
    echo "[*] Installing wfuzz..."
    sudo git clone https://github.com/xmendez/wfuzz.git $INSTALL_DIR/wfuzz
    cd $INSTALL_DIR/wfuzz
    sudo pip3 install -r requirements.txt
    sudo python3 setup.py install
    cd -
fi

# --- Metasploit Framework ---
if ! command -v msfconsole &>/dev/null; then
    echo "[*] Installing Metasploit Framework..."
    curl https://raw.githubusercontent.com/rapid7/metasploit-framework/master/msfinstall | sh
fi

# --- Nikto ---
if [ ! -d "$INSTALL_DIR/nikto" ]; then
    echo "[*] Installing Nikto..."
    sudo git clone https://github.com/sullo/nikto.git $INSTALL_DIR/nikto
    sudo ln -sf $INSTALL_DIR/nikto/program/nikto.pl /usr/local/bin/nikto
fi

# --- Recon-ng ---
if [ ! -d "$INSTALL_DIR/recon-ng" ]; then
    echo "[*] Installing Recon-ng..."
    sudo git clone https://github.com/lanmaster53/recon-ng.git $INSTALL_DIR/recon-ng
    sudo ln -sf $INSTALL_DIR/recon-ng/recon-ng /usr/local/bin/recon-ng
fi

echo "=================================================="
echo " All tools installed in $INSTALL_DIR"
echo " Use: sqlmap, hydra, nmap, ffuf, wfuzz, msfconsole, nikto, recon-ng"
echo " Beef-XSS and sqlsus are in /opt, run manually from there."
echo "=================================================="
