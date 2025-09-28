# Nexus VPS - Comprehensive Pentesting & Automation Installer (Ubuntu Edition)

## 📌 Overview
A powerful and **interactive bash script** designed to automate the installation and management of:

- Penetration testing tools  
- Workflow automation (n8n)  
- Graphical desktop environments (GNOME/XFCE)  
- Containerized AI assistants (Lily & Coder with Ollama)  
- System & network information utilities  

✅ Primarily tested on **Ubuntu 22.04 LTS**.  
✅ Built for **cybersecurity professionals, developers, and enthusiasts**.  

![Project Banner](Banner.jpg)

---

## ✨ Features
- **Interactive Menu System** – Simple, text-based navigation.  
- **Pentest Tools Installer** – Install individually or all at once.  
- **Dockerized AI Assistants** – Deploy Lily (cybersecurity AI) & Coder (developer AI).  
- **n8n Workflow Automation** – Manage with PM2 (install, run, update, stop).  
- **Graphical Desktop (GUI)** – Install GNOME or XFCE, with xRDP remote access support.  
- **System Info Menu** – Run speedtest, view system hardware & network info.  
- **Dependency Handling** – Installs Ruby (RVM), Go, Node.js (NVM), Docker automatically.  
- **Maintenance & Verification** – Check versions, reinstall all tools, verify installations.  

---

## 🛠 Tools & Services
| Category | Tools/Services |
|----------|----------------|
| Web App Analysis | SQLMap, Nikto, ffuf, Wfuzz, BeEF-XSS |
| Network Scanning | Nmap |
| Exploitation | Metasploit |
| Password Attacks | Hydra |
| Reconnaissance | Recon-ng |
| Workflow Automation | n8n (with PM2) |
| Services | Docker, Nginx, ProxyChains |
| Development | Neovim, Go, Ruby (RVM), Node.js (NVM) |
| AI Assistants | Lily (Cybersecurity), Coder (Programming) |
| GUI | GNOME (Ubuntu Desktop), XFCE (Xubuntu Desktop), xRDP |
| System Info | Speedtest, inxi, lshw |

---

## 📥 Installation & Usage
Clone the repo:
```bash
git clone https://github.com/nexus-arm/Nexus-VPS.git
cd Nexus-VPS
```

Make script executable:
```bash
chmod +x nexus-vps.sh
```

Run with sudo:
```bash
sudo ./nexus-vps.sh
```

You will see the **Main Menu** with options:
```
1) Pentest Tools
2) Graphical Environment (GUI)
3) AI Assistants (Lily/Coder)
4) n8n Management
5) Check Tool Versions
6) Re-install All Tools
7) System & Network Info
0) Exit
```

---

## 🔍 Menu Details
### 1. Pentest Tools
Install SQLMap, Hydra, Nmap, BeEF-XSS, ffuf, Docker, Neovim, Wfuzz, Metasploit, Nikto, Recon-ng, Nginx, ProxyChains.  
Option to **install all at once**.

### 2. Graphical Environment (GUI)
- Install **GNOME** (full Ubuntu desktop).  
- Install **XFCE** (lightweight).  
- Install & configure **xRDP** for remote access.  
- Check GUI installation status.  

⚠️ Reboot required after installation (`sudo reboot`).  

### 3. AI Assistants
Deploy AI inside a **shared Docker Ollama container**.  
- **Lily** – Cybersecurity AI (choose Q4 or Q5 model).  
- **Coder** – Programming AI (Qwen2-7B model).  

Global commands created:
```bash
lily "Explain Log4Shell vulnerability"
coder "Write a Python script for port scanning"
```

### 4. n8n Workflow Automation
Manage **n8n** with PM2:  
- Install, update, run, stop, check status.  
- Auto-start at boot.  
- Accessible at: `http://<server-ip>:5678`  

### 5. Check Tool Versions
Quick version check for all installed tools.  

### 6. Re-install All Tools
Completely removes and reinstalls all tools, AI assistants, and n8n.  

### 7. System & Network Info
- Run speedtest (Speedtest CLI).  
- View hardware summary (`inxi`).  
- Detailed hardware list (`lshw`).  

---

## ⚡ Troubleshooting
- **Command not found:** Restart terminal session.  
- **RVM/NVM errors:** Ensure sourced in `~/.bashrc` or `~/.zshrc`.  
- **Docker permission errors:**  
  ```bash
  sudo usermod -aG docker $USER
  ```
  Then re-login.  
- **Remote GUI not working:** Use GUI menu help to install/configure xRDP.  

---

## 🤝 Contributing
Pull requests and issues are welcome!  

---

## 📜 License
Licensed under **MIT License**. See `LICENSE` for details.  

---

## ☕ Support the Project
If you’d like to support further development, donate via TON:  

**UQBnoOaSb46CRspYXK_ha9tiD5yum-ZYUGAnhJCX5Urfffg9**

🙏 Thank you!  
