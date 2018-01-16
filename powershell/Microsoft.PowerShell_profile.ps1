echo "Loading profile: [$profile]"

# Use UTF-8 instead of MS-DOS codepages
#chcp 65001 > $null

$env:PATH = "C:\Perl\bin;$env:PATH"
$env:PATHEXT="$env:PATHEXT;.PL"
$env:HGEDITOR="subl -w"


# See if this makes tab complete less horrible
Set-PSReadlineKeyHandler -Key Tab -Function Complete

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
function code { Set-Location ~\code }
function cases { Set-Location ~\code\cases }
function unity { Set-Location c:\unity }
function unity1 { Set-Location c:\unity }
function unity2 { Set-Location c:\unity2 }
function serve
{
    echo "Address: http://$(ip4):80/"
    hg serve --address $(ip4) --port 80

    # Don't think this can work on windows :(
    # Only cmdserver mode supported is pipe
    # and that uses stdin and out to communicate with client
}

function new_case
{
    if(! $args)
    {
        echo "Please provide a case name."
        return
    }
    $case_name = $args[0]
    $folder = "~\code\cases\$case_name"
    $srcdir = "~\code\dotfiles\unity"

    echo "Creating new case at: [$folder]"
    New-Item -ItemType Directory -Force -Path $folder

    # 1. Init as a mercurial repro
    cd $folder
    hg init

    # 2. Copy over .hgignore
    Copy-Item "$srcdir\hgignore" "$folder\.hgignore"

    # 3. Copy over the hgrc file
    Copy-Item "$srcdir\hgrc" "$folder\.hg\hgrc"

    # 4. Create a README.md
    Copy-Item "$srcdir\default_readme" "$folder\README.md"

    # 5. Create a project folder
    New-Item -ItemType Directory -Force -Path "$folder\_unityproj"

    # 6. Create a builds folder
    New-Item -ItemType Directory -Force -Path "$folder\builds"

    # 7. First commit
    hg add .
    hg commit -m "Opening new case."
}

function tsubl
{
    touch @args
    subl @args
}

function hgrc
{
    subl $env:userprofile\mercurial.ini
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
