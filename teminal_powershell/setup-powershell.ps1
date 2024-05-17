# Atualiza o sistema
Write-Output "Atualizando o sistema..."
Start-Process "powershell" -ArgumentList "Update-Help" -Verb RunAs -Wait

# Instala o Chocolatey (se não estiver instalado)
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Output "Instalando Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex  ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
} else {
    Write-Output "Chocolatey já está instalado."
}

# Instala o oh-my-posh
Write-Output "Instalando oh-my-posh..."
choco install -y oh-my-posh

# Instala o PSReadLine
Write-Output "Instalando PSReadLine..."
Install-Module -Name PSReadLine -Force -SkipPublisherCheck

# Instala o Posh-Git
Write-Output "Instalando Posh-Git..."
Install-Module -Name Posh-Git -Force -SkipPublisherCheck

# Instala o Terminal-Icons
Write-Output "Instalando Terminal-Icons..."
Install-Module -Name Terminal-Icons -Force -SkipPublisherCheck

# Instala o z (jump around)
Write-Output "Instalando z (jump around)..."
Invoke-WebRequest -Uri https://raw.githubusercontent.com/rupa/z/master/z.sh -OutFile $HOME/z.sh

# Adiciona as configurações ao perfil do PowerShell
Write-Output "Configurando o perfil do PowerShell..."

$profileContent = @'
# Importa o oh-my-posh e carrega o tema
Import-Module oh-my-posh
& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" --print) -join "`n"))

# Importa os ícones do terminal
Import-Module Terminal-Icons

# Importa o PSReadLine e configura o autocomplete por histórico
Import-Module PSReadLine
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Importa o Posh-Git
Import-Module posh-git

# Configura o z (jump around)
. $HOME/z.sh
'@

# Adiciona o conteúdo ao perfil do PowerShell
$profilePath = "$PROFILE"
if (-Not (Test-Path -Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force
}
Add-Content -Path $profilePath -Value $profileContent

Write-Output "Configuração concluída! Reinicie o PowerShell para aplicar as mudanças."
