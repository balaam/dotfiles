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

# Gets the ip4 address, extracted from ipconfig
function ip4 { (ipconfig)-like'*IPv4*'|%{($_-split': ')[-1]}}
function open { ii @args }
function code { Set-Location ~\Code }
function serve
{
	echo "Address: http://$(ip4):8000/mercurial"
	hg serve --prefix mercurial --address  $(ip4)
}
Set-Alias refresh Reload-Profile

# Load posh-hg example profile
if (Test-path 'C:\Users\danielsc\code\posh-hg\profile.example.ps1')
{
	. 'C:\Users\danielsc\code\posh-hg\profile.example.ps1'
}

code
