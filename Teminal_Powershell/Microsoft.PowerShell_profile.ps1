# Import-Module oh-my-posh ecarregar tema
& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" --print) -join "`n"))
#Import-Module de Icones do terminal
Import-Module Terminal-Icons

#import do autocomplete por historico
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# import do autocomplete do git
Import-Module Posh-Git

#Uso o  para não ficar poluido o terminal
clear-host

#Alias do git, não ter que digitar git no lugar só coloco g
Set-Alias g git

#Alias do chocolatey(Só use se tiver o chocolatey)
function Install-Choco {
    choco install $args
}

Set-Alias install Install-Choco

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

