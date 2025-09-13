Comprehensive Pentesting Tool Installer for Ubuntu

<!-- You can create a screenshot of the logo and add it here -->

A powerful and interactive bash script designed to automate the installation and management of a wide range of penetration testing tools, services, a full graphical desktop environment, and a containerized AI assistant on fresh Ubuntu systems (primarily tested on Ubuntu 22.04 LTS).

This script is built for cybersecurity professionals, students, and enthusiasts who want to set up their testing environment quickly and efficiently, without the hassle of manual installations and dependency management.

Features

Interactive Menu System: A user-friendly, menu-driven interface to install tools individually or all at once.

Modular Installation: Choose exactly which tools you need. No bloat.

Source & Package Installations: Intelligently combines installations from official repositories (apt), GitHub (for the latest versions), and language managers (rvm, go).

Dockerized AI Assistant (Lily): Installs and configures "Lily," a cybersecurity-focused AI, inside a Docker container for complete system isolation and easy management.

GUI Installation: Easily add a full desktop environment to your CLI-only server. Choose between the standard GNOME (full Ubuntu experience) or lightweight XFCE.

Automated Dependency Handling: The script automatically installs all necessary prerequisites, including specific versions of Ruby (via RVM) and Go.

Verification & Maintenance: Includes options to check tool versions and completely reinstall the toolkit.

Tools & Services Included

The script provides a comprehensive suite of tools for various security domains:

Category

Tools

Web App Analysis

SQLMap, Nikto, ffuf, Wfuzz, BeEF-XSS

Network Scanning

Nmap, Masscan (via Nmap scripts)

Exploitation

Metasploit Framework

Password Attacks

Hydra

Reconnaissance

Recon-ng

System Services

Docker Engine, Nginx, ProxyChains

Development

Neovim, Go, Ruby (RVM)

AI Assistant

Lily (Cybersecurity LLM via Ollama)

Desktop Environments

GNOME (Standard), XFCE (Lightweight)

Prerequisites

An Ubuntu-based system (VPS or local machine). Tested primarily on Ubuntu 22.04 LTS.

sudo or root privileges.

A stable internet connection for downloading packages and source code.

Installation & Usage

Clone the repository:

git clone <your-github-repo-url> cd <your-repo-name> 

Make the script executable:

chmod +x nexus-vps.sh

Run the script with sudo privileges:

sudo ./nexus-vps.sh

Follow the on-screen menus:

The main menu will appear, allowing you to navigate to different sub-menus for installing pentesting tools, a GUI, or the Lily AI assistant.

Key Feature Details

Pentest Tool Installer

Select option 1 from the main menu to access the tool installation sub-menu. From here, you can:

Install tools one by one by selecting their corresponding number.

Install all tools at once by selecting the "Install ALL Tools" option.

Lily - The Dockerized AI Assistant

Select option 3 to install Lily. The script will:

Automatically install Docker if it's not already present.

Create and run a dedicated ollama container.

Prompt you to choose between a lighter (~4.4 GB) or heavier (~5.1 GB) version of the Lily language model.

Download the model, set it up inside the container, and perform cleanup.

Create a global lily command on your system.

After installation, you can chat with the AI from anywhere in your terminal by simply typing:

lily "your cybersecurity question here" 

Graphical Environment (GUI)

If you are running this script on a CLI-only server, you can easily install a desktop environment by selecting option 2. You have two choices:

GNOME: The full, standard Ubuntu desktop. Recommended for systems with sufficient resources.

XFCE: A lightweight, fast, and resource-friendly desktop. Ideal for VPS with limited RAM.

After installation, simply sudo reboot your system to boot into the graphical login screen.

Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the issues page.

License

This project is licensed under the MIT License. See the LICENSE file for details.