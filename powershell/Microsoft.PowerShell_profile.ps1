echo "Loading profile: [$profile]"

# Use UTF-8 instead of MS-DOS codepages
#chcp 65001 > $null

$env:PATH = "C:\Perl\bin;$env:PATH"
$env:PATHEXT="$env:PATHEXT;.PL"

function Reload-Profile {
    @(
        $Profile.AllUsersAllHosts,
        $Profile.AllUsersCurrentHost,
        $Profile.CurrentUserAllHosts,
        $Profile.CurrentUserCurrentHost
    ) | % {
        if(Test-Path $_){
            Write-Verbose "Running $_"
            . $_
        }
    }    
}

function Touch-File
{
    $file = $args[0]
    if($file -eq $null) {
        throw "No filename supplied"
    }

    if(Test-Path $file)
    {
        (Get-ChildItem $file).LastWriteTime = Get-Date
    }
    else
    {
        echo $null > $file
    }
}

# Gets the ip4 address, extracted from ipconfig
function ip4 { (ipconfig)-like'*IPv4*'|%{($_-split': ')[-1]}}
function open 
{ 
    if(Test-Path $args[0] -PathType Leaf)
    {
        Invoke-Item $args[0]
    }
    else
    {
        ii @args 
    }
}
function code { Set-Location ~\Code }
function serve
{
    echo "Address: http://$(ip4):8000/mercurial"
    hg serve --prefix mercurial --address  $(ip4)
}

function dinit
{
   echo "Initialising a mercurial checkout for a unity project" 
}

function tsubl
{
    touch @args
    subl @args
}

Set-Alias refresh Reload-Profile
Set-Alias touch Touch-File

# Load posh-hg example profile
if (Test-path 'C:\Users\danielsc\code\posh-hg\profile.example.ps1')
{
    . 'C:\Users\danielsc\code\posh-hg\profile.example.ps1'
}

# Jump in the code directory by default
code

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
