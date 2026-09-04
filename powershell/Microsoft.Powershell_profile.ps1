# Force Neovim over Git Bash MSYS2 binaries
Set-Alias -Name vim -Value "C:\Program Files\Neovim\bin\nvim.exe" -Option AllScope -Force
Set-Alias -Name vi  -Value "C:\Program Files\Neovim\bin\nvim.exe" -Option AllScope -Force
Set-Alias -Name v   -Value "C:\Program Files\Neovim\bin\nvim.exe" -Option AllScope -Force

# Target Tracking System
function Set-Target ($ip) {
    $env:TARGET = $ip
    Write-Host "[+] Target locked: $ip" -ForegroundColor Green
}

function Unset-Target {
    Remove-Item env:TARGET -ErrorAction Ignore
    Write-Host "[-] Target cleared." -ForegroundColor Red
}

function Get-Target {
    if ($env:TARGET) {
        Write-Host "Current Target: $env:TARGET" -ForegroundColor Red
    } else {
        Write-Host "Current Target: None Set" -ForegroundColor Yellow
    }
}

Set-Alias -Name target -Value Get-Target

# Engagement Directory Structure
function mkengagement ($targetName) {
    if (-not $targetName) {
        Write-Host "Usage: mkengagement <target_name>" -ForegroundColor Yellow
        return
    }
    $dirs = @("scans", "loot", "exploits", "proofs")
    foreach ($d in $dirs) {
        New-Item -ItemType Directory -Path "$targetName\$d" -Force | Out-Null
    }
    Set-Location $targetName
    Write-Host "[+] Engagement structure created in: $(Get-Location)" -ForegroundColor Green
}

# Network Ports Inspection
function Get-ListeningPorts {
    Get-NetTCPConnection -State Listen | Select-Object LocalAddress, LocalPort, OwningProcess | Sort-Object LocalPort
}
Set-Alias -Name ports -Value Get-ListeningPorts

# HTTP Local Host
function mksrv ($port = 8000) {
    Write-Host "[*] Hosting $(Get-Location) on port $port..." -ForegroundColor Cyan
    python -m http.server $port
}

# Directory Navigation Shortcuts
function mkcd ($dir) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
    Set-Location $dir
}