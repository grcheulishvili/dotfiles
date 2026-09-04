# deploy.ps1 - Dotfiles Deployment Script for Windows

$DotfilesDir = $PSScriptRoot

# 1. Deploy Neovim init.lua
$NvimDir = "$env:LOCALAPPDATA\nvim"
New-Item -ItemType Directory -Force -Path $NvimDir | Out-Null
Copy-Item -Path "$DotfilesDir\nvim\init.lua" -Destination "$NvimDir\init.lua" -Force
Write-Host "[+] Neovim configuration deployed to $NvimDir\init.lua" -ForegroundColor Green

# 2. Deploy PowerShell Profile
$ProfileDir = Split-Path -Path $PROFILE
New-Item -ItemType Directory -Force -Path $ProfileDir | Out-Null
Copy-Item -Path "$DotfilesDir\powershell\Microsoft.PowerShell_profile.ps1" -Destination $PROFILE -Force
Write-Host "[+] PowerShell profile deployed to $PROFILE" -ForegroundColor Green

# 3. Reload Shell Profile
. $PROFILE
Write-Host "[+] Environment successfully reloaded." -ForegroundColor Cyan