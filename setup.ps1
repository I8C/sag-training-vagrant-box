# Useful apps
choco install -y boxstarter
choco install -y googlechrome
choco install -y firefox
choco install -y 7zip
choco install -y notepadplusplus
choco install git -y -params '"/GitAndUnixToolsOnPath /NoAutoCrlf"'

Set-TimeZone -Name "Romance Standard Time"
Set-WinHomeLocation 21
Set-WinSystemLocale -SystemLocale en-BE
Set-WinLogonLanguageList -LanguageList en-BE -Force
Set-WinUserLanguageList -LanguageList en-BE -Force 
Rename-Computer -NewName "sagbase" -Force
