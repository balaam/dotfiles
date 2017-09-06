# 
# Symlinks dot file to a place where Powershell will pick up the settings.
#

if (Test-Path $profile )
{
	Remove-Item $profile	
}

invoke-expression "cmd /c mklink /H $profile $PSScriptRoot\Microsoft.PowerShell_profile.ps1"
echo "symlinked profile"
