<<<<<<< HEAD
# Nexus VPS - Comprehensive Pentesting & Automation Installer (Ubuntu Edition)
=======
# Nexus-vps

![Project Logo](Banner.jpg)

## Comprehensive Pentesting Tool Installer for Ubuntu
>>>>>>> 2bb13daa27578146971d45c6006763d48cf1a685

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

<<<<<<< HEAD
## ✨ Features
- **Interactive Menu System** – Simple, text-based navigation.  
- **Pentest Tools Installer** – Install individually or all at once.  
- **Dockerized AI Assistants** – Deploy Lily (cybersecurity AI) & Coder (developer AI).  
- **n8n Workflow Automation** – Manage with PM2 (install, run, update, stop).  
- **Graphical Desktop (GUI)** – Install GNOME or XFCE, with xRDP remote access support.  
- **System Info Menu** – Run speedtest, view system hardware & network info.  
- **Dependency Handling** – Installs Ruby (RVM), Go, Node.js (NVM), Docker automatically.  
- **Maintenance & Verification** – Check versions, reinstall all tools, verify installations.  
=======
## ☕ Support the Project

If you like this project and want to support its development, you can donate TON using the following key:

`UQBnoOaSb46CRspYXK_ha9tiD5yum-ZYUGAnhJCX5Urfffg9`

Thank you for your support! 🙏


## Features

- **Interactive Menu System**: A user-friendly, menu-driven interface to install tools individually or all at once.
- **Modular Installation**: Choose exactly which tools you need. No bloat.
- **Source & Package Installations**: Intelligently combines installations from official repositories (`apt`), `GitHub` (for the latest versions), and language managers `(RVM, Go toolchain)`.
- **Dockerized AI Assistant (Lily)**: Installs and configures "`Lily`" a cybersecurity-focused AI, inside a `Docker` container for complete system isolation and easy management.
- **GUI Installation**: Easily add a full desktop environment to your CLI-only server. Choose between the standard `GNOME` (full Ubuntu experience) or lightweight `XFCE`.
- **Automated Dependency Handling**: The script automatically installs all necessary prerequisites, including specific versions of `Ruby` (via RVM) and `Go`.
- **Verification & Maintenance**: Includes options to check tool versions and completely reinstall the toolkit.
>>>>>>> 2bb13daa27578146971d45c6006763d48cf1a685

---

## 🛠 Tools & Services

### Security & Penetration Testing
| Tool | Category | Description |
|------|----------|-------------|
| **Metasploit** | Exploitation Framework | Complete penetration testing platform |
| **Nmap** | Network Scanner | Port scanning and network discovery |
| **Hydra** | Password Cracker | Network logon cracker |
| **SQLMap** | Web Security | Automatic SQL injection tool |
| **BeEF-XSS** | Browser Exploitation | Cross-site scripting framework |
| **Nikto** | Web Scanner | Web server vulnerability scanner |
| **Recon-ng** | Reconnaissance | Web reconnaissance framework |
| **ffuf** | Web Fuzzer | Fast web fuzzer |
| **Wfuzz** | Web Fuzzer | Web application security fuzzer |
| **ProxyChains** | Network Tool | Proxy chains for anonymity |

### Development & Infrastructure
| Category | Tools |
|----------|-------|
| **Containers** | Docker, Docker Compose |
| **Web Server** | Nginx |
| **Editor** | Neovim (modern Vim) |
| **Languages** | Go, Ruby (via RVM), Node.js (via NVM) |
| **Process Manager** | PM2 (for n8n) |

### Automation & AI
| Service | Purpose | Access |
|---------|---------|--------|
| **n8n** | Workflow Automation | `http://<server-ip>:5678` |
| **Lily AI** | Cybersecurity Assistant | `lily "your query"` |
| **Coder AI** | Programming Assistant | `coder "your query"` |
| **Ollama** | AI Model Backend | Docker container |

### GUI & Remote Access
- **GNOME** - Full-featured Ubuntu Desktop environment
- **XFCE** - Lightweight Xubuntu Desktop environment
- **xRDP** - Remote Desktop Protocol server for Windows clients

### System Information
- **Speedtest CLI** - Network speed testing
- **inxi** - System information tool
- **lshw** - Hardware lister

---

## 📥 Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/nexus-arm/Nexus-VPS.git
cd Nexus-VPS

# Make the script executable
chmod +x nexus-vps.sh

# Run with sudo privileges
sudo ./nexus-vps.sh
```

### First Launch

Upon execution, you'll see the interactive main menu:

```
================================================================
                          MAIN MENU
================================================================
1) Install Pentest Tools (Manual/All)
2) Install Graphical Environment (GUI)
3) Install AI Assistants (Lily/Coder)
4) Manage n8n (Automation Workflow)
5) Check Tool Versions
6) Re-install All Pentest Tools
7) System & Network Information
0) Exit
================================================================
Please enter your choice:
```

---

## 🔍 Menu Details

### 1️⃣ Pentest Tools Installation

Choose between individual tool installation or bulk deployment:

**Individual Installation**
- Select specific tools from the comprehensive list
- Installs dependencies automatically
- Skips already-installed tools

**Bulk Installation (Install All)**
- One-command deployment of all security tools
- Automated dependency resolution
- Progress indicators for each tool

**Available Tools**: SQLMap, Hydra, Nmap, BeEF-XSS, ffuf, Docker, Neovim, Wfuzz, Metasploit, Nikto, Recon-ng, Nginx, ProxyChains

---

### 2️⃣ Graphical Environment (GUI)

Transform your VPS into a full desktop environment:

#### GNOME Desktop
- Complete Ubuntu desktop experience
- Modern interface with extensive features
- Resource: ~2GB RAM minimum

#### XFCE Desktop
- Lightweight alternative to GNOME
- Ideal for low-resource VPS
- Resource: ~1GB RAM minimum

#### xRDP Remote Access
- Enable Windows Remote Desktop connections
- Automatic configuration
- Default port: 3389

#### Post-Installation
⚠️ **Important**: Reboot required after GUI installation
```bash
sudo reboot
```

**Connection**: Use Windows Remote Desktop or Remmina to connect to `<server-ip>:3389`

---

### 3️⃣ AI Assistants (Lily & Coder)

Deploy AI-powered assistants in isolated Docker containers:

#### Lily - Cybersecurity AI
- **Model Options**: Q4 (faster) or Q5 (more accurate)
- **Specialization**: Vulnerability analysis, exploit research, security best practices
- **Use Cases**: 
  - Threat intelligence queries
  - CVE explanations
  - Security tool guidance

**Example Usage**:
```bash
lily "Explain the OWASP Top 10 vulnerabilities"
lily "How does a SQL injection attack work?"
lily "Best practices for securing SSH"
```

#### Coder - Programming AI
- **Model**: Qwen2-7B (optimized for code)
- **Specialization**: Code generation, debugging, algorithm design
- **Use Cases**:
  - Script automation
  - Code review
  - Programming tutorials

**Example Usage**:
```bash
coder "Write a Python port scanner"
coder "Debug this bash script: [paste code]"
coder "Explain asyncio in Python"
```

#### Architecture
- **Backend**: Ollama running in shared Docker container
- **Persistence**: Models stored in Docker volumes
- **Performance**: GPU acceleration if available, CPU fallback

---

### 4️⃣ n8n Workflow Automation

Manage your n8n instance with PM2 process management:

#### Features
- **Install**: Fresh n8n deployment with PM2
- **Update**: Pull latest n8n version
- **Control**: Start, stop, restart, status checks
- **Auto-Start**: Configured to launch on system boot
- **Web Interface**: `http://<server-ip>:5678`

#### Management Commands
```bash
# Via script menu (recommended)
Select option 4 from main menu

# Direct PM2 commands
pm2 list                 # View all processes
pm2 logs n8n            # View n8n logs
pm2 restart n8n         # Restart n8n
pm2 stop n8n            # Stop n8n
```

#### Use Cases
- Webhook automation
- Data integration pipelines
- Scheduled task execution
- API orchestration

---

### 5️⃣ Check Tool Versions

Quick verification of installed tools and their versions:

**Output Example**:
```
Docker: 24.0.5
Nmap: 7.94
Metasploit: 6.3.15
Python3: 3.10.12
Node.js: v20.11.0
Go: 1.21.5
```

---

### 6️⃣ Re-install All Tools

Complete system refresh:
- Removes all installed tools cleanly
- Reinstalls from scratch
- Useful for:
  - Fixing corrupted installations
  - Updating to latest versions
  - Starting fresh after experiments

⚠️ **Warning**: This will remove existing configurations and data

---

### 7️⃣ System & Network Information

Comprehensive diagnostics suite:

#### Speedtest
- Internet connection speed (up/down)
- Latency measurements
- ISP information

#### Hardware Summary (inxi)
- CPU, RAM, storage overview
- Operating system details
- Kernel version

#### Detailed Hardware (lshw)
- Complete hardware inventory
- Device drivers
- System architecture

---

## ⚙️ Advanced Configuration

### Environment Variables

Tools like RVM and NVM modify shell configurations. Ensure your shell profile is sourced:

```bash
# For bash users
source ~/.bashrc

# For zsh users
source ~/.zshrc
```

### Docker Post-Install

Add user to docker group to avoid sudo:
```bash
sudo usermod -aG docker $USER
newgrp docker
```

### Firewall Configuration

If using UFW, allow necessary ports:
```bash
sudo ufw allow 5678/tcp   # n8n
sudo ufw allow 3389/tcp   # xRDP
sudo ufw reload
```

### Custom Tool Paths

Tools are installed in standard locations:
- **System tools**: `/usr/bin`, `/usr/local/bin`
- **RVM**: `~/.rvm`
- **NVM**: `~/.nvm`
- **Go**: `/usr/local/go`

---

## ⚡ Troubleshooting

### Common Issues & Solutions

#### "Command not found" after installation
**Cause**: Shell environment not refreshed  
**Solution**: 
```bash
# Reload shell configuration
source ~/.bashrc  # or ~/.zshrc

# Or start a new terminal session
exit
# Login again
```

#### RVM/NVM errors
**Cause**: Environment not properly sourced  
**Solution**:
```bash
# Check if RVM is in PATH
echo $PATH | grep rvm

# Manually source RVM
source ~/.rvm/scripts/rvm

# Check if NVM is loaded
command -v nvm

# Manually source NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```

#### Docker permission errors
**Cause**: User not in docker group  
**Solution**:
```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Apply group changes (logout/login alternative)
newgrp docker

# Verify
docker ps
```

#### n8n won't start
**Cause**: Port 5678 already in use  
**Solution**:
```bash
# Check what's using the port
sudo lsof -i :5678

# Kill the process or change n8n port
pm2 stop n8n
# Edit n8n configuration to use different port
```

#### Remote GUI (xRDP) not working
**Cause**: Service not running or firewall blocking  
**Solution**:
```bash
# Check xRDP status
sudo systemctl status xrdp

# Restart xRDP
sudo systemctl restart xrdp

# Check firewall
sudo ufw status
sudo ufw allow 3389/tcp
```

#### AI assistants not responding
**Cause**: Ollama container not running or out of memory  
**Solution**:
```bash
# Check Docker containers
docker ps

# Check Ollama logs
docker logs ollama

# Restart Ollama container
docker restart ollama

# Check available memory
free -h
```

#### Metasploit database errors
**Cause**: PostgreSQL not initialized  
**Solution**:
```bash
# Initialize Metasploit database
msfdb init

# Or reinitialize
msfdb reinit
```

### Getting Help

1. **Check logs**: Most tools have detailed logs in `/var/log/` or `~/.pm2/logs/`
2. **Verbose mode**: Run tools with `-v` or `--verbose` flags
3. **GitHub Issues**: Report bugs at [github.com/nexus-arm/Nexus-VPS/issues](https://github.com/nexus-arm/Nexus-VPS/issues)
4. **Community**: Join discussions in the repository

---

## 🛡️ Security Considerations

### Best Practices

1. **Firewall**: Configure UFW to restrict unnecessary ports
2. **SSH**: Disable password authentication, use key-based auth only
3. **Updates**: Regularly update all tools and the system
4. **Isolation**: Use Docker for potentially risky tools
5. **Monitoring**: Enable system logging and monitoring

### Responsible Use

⚠️ **Important**: This toolkit is designed for:
- Authorized penetration testing
- Security research in controlled environments
- Educational purposes with proper lab setup
- Professional security assessments with written permission

**Unauthorized use of these tools against systems you don't own or have explicit permission to test is illegal and unethical.**

---

## 🤝 Contributing

We welcome contributions! Here's how you can help:

### Ways to Contribute

- **🐛 Bug Reports**: Open an issue with detailed reproduction steps
- **✨ Feature Requests**: Suggest new tools or improvements
- **📝 Documentation**: Improve README or add guides
- **💻 Code**: Submit pull requests with enhancements

### Contribution Guidelines

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Setup

```bash
# Clone your fork
git clone https://github.com/nexus-arm/Nexus-VPS.git
cd Nexus-VPS

# Create a test branch
git checkout -b test-feature

# Make changes and test
sudo ./nexus-vps.sh

# Test in a clean environment (recommended)
# Use a VM or Docker container
```

---

## 📜 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for full details.

### MIT License Summary
✅ Commercial use  
✅ Modification  
✅ Distribution  
✅ Private use  

❗ License and copyright notice must be included  
❗ Software is provided "as is" without warranty

---

## 🌟 Acknowledgments

### Built With
- **Bash** - Shell scripting
- **Docker** - Containerization
- **Ollama** - AI model serving
- **n8n** - Workflow automation
- **PM2** - Process management

### Special Thanks
- The open-source security community
- Contributors to all integrated tools
- Ubuntu and Debian maintainers
- Everyone who has starred or contributed to this project

---

## 💬 Support

### Get Help
- **📖 Documentation**: You're reading it! Check the sections above
- **🐛 Bug Reports**: [GitHub Issues](https://github.com/nexus-arm/Nexus-VPS/issues)

### Connect
- **GitHub**: [nexus-arm](https://github.com/nexus-arm)
- **Project**: [Nexus-VPS](https://github.com/nexus-arm/Nexus-VPS)

---

## ☕ Support the Project

If you find Nexus VPS useful and would like to support continued development, donations are greatly appreciated!

**Donate via TON Blockchain**:
```
UQBnoOaSb46CRspYXK_ha9tiD5yum-ZYUGAnhJCX5Urfffg9
```

Your support helps:
- 🔧 Maintain and update tools
- 📚 Improve documentation
- ✨ Add new features
- 🐛 Fix bugs faster

---

## 📊 Project Stats

<div align="center">

![GitHub stars](https://img.shields.io/github/stars/nexus-arm/Nexus-VPS?style=social)
![GitHub forks](https://img.shields.io/github/forks/nexus-arm/Nexus-VPS?style=social)
![GitHub issues](https://img.shields.io/github/issues/nexus-arm/Nexus-VPS)
![GitHub last commit](https://img.shields.io/github/last-commit/nexus-arm/Nexus-VPS)

**Made with ❤️ for the cybersecurity community**

</div>

---

## 📝 Changelog

### Version 3.0 (Current)
- ✨ Added AI assistants (Lily & Coder)
- 🔧 Improved menu navigation
- 📦 Enhanced dependency management
- 🐛 Bug fixes and stability improvements

### Previous Versions
See [CHANGELOG.md](CHANGELOG.md) for full version history

---

<div align="center">

**⭐ Star this repo if you find it useful! ⭐**

**[🏠 View on GitHub](https://github.com/nexus-arm/Nexus-VPS)**

[Report Bug](https://github.com/nexus-arm/Nexus-VPS/issues) • [Request Feature](https://github.com/nexus-arm/Nexus-VPS/issues/new?labels=enhancement) • [Discussions](https://github.com/nexus-arm/Nexus-VPS/discussions)

</div>
