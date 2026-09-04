# Dotfiles

Personal cross-platform dotfiles tailored for security audits, penetration testing, and software engineering. Designed for clean deployments across fresh Windows installations, FlareVM setups, and Arch / BlackArch Linux environments.

## Quick Deployment

### Fresh Windows Installation

Run PowerShell 7 with script execution permitted to deploy Neovim, PowerShell profile, and aliases:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
git clone https://github.com/grcheulishvili/dotfiles.git
cd dotfiles
.\deploy.ps1

```

> **Windows Terminal Setup:** Copy `windows-terminal/settings.json` contents directly into Windows Terminal Settings (`Ctrl + Shift + ,`).

---

### FlareVM Automated Setup

Copy `flarevm/flarevm_config.xml` into your FlareVM installation directory or feed it directly to the automated installer CLI:

```powershell
# Copy custom configuration into FlareVM installer context
Copy-Item .\flarevm\flarevm_config.xml C:\ProgramData\FLARE\config.xml

```

---

### Fresh Arch / BlackArch Linux Setup

Deploy the Neovim configuration and custom `.bashrc`:

```bash
git clone https://github.com/grcheulishvili/dotfiles.git
cd dotfiles
mkdir -p ~/.config/nvim
cp nvim/init.lua ~/.config/nvim/init.lua
cp bash/.bashrc ~/.bashrc
source ~/.bashrc

```