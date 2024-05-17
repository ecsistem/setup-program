# Lê os nomes dos programas a serem instalados do arquivo 'programs.txt'
$programsToInstall = Get-Content -Path "programs.config"

# Verificar se o script está sendo executado com privilégios de administrador
function Test-AdministratorPrivileges {
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host -ForegroundColor Red "Este script precisa ser executado com privilégios de administrador."
        # Aguardar a entrada do usuário para fechar o terminal
        Write-Host "Pressione qualquer tecla para fechar o terminal..."
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
        exit
    }
}

# Instala o Chocolatey, se necessário
function Install-Chocolatey{
    if (Test-Path "$env:ProgramData\chocolatey\choco.exe") {
        Write-Host "Chocolatey já está instalado." -ForegroundColor Green
    } else {
        Write-Host "Instalando o Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        
        if (Test-Path "$env:ProgramData\chocolatey\choco.exe") {
            Write-Host "Chocolatey foi instalado." -ForegroundColor Green
        } else {
            Write-Host "Não foi possível instalar o Chocolatey. Saindo..." -ForegroundColor Red
            exit
        }
    }
}

# Instalação de programas via Chocolatey
function Install-Programs {
    param (
        [string[]] $programs
    )

    foreach ($program in $programs) {
        Write-Host "Instalando $program..."
        choco install $program -y
        if ($LASTEXITCODE -eq 0) {
            Write-Host "$program foi instalado." -ForegroundColor Green
        } else {
            Write-Host "Não foi possível instalar $program." -ForegroundColor Red
        }
    }
}


# Verificar se o script está sendo executado com privilégios de administrador
Test-AdministratorPrivileges

# Verificar e instalar o Chocolatey
Install-Chocolatey

# Instalar os programas usando Chocolatey
Install-Programs -programs $programsToInstall

Write-Host "Todos os programas foram instalados." -ForegroundColor Yellow

# Aguardar a entrada do usuário para fechar o terminal
Write-Host "Pressione qualquer tecla para fechar o terminal..."
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')