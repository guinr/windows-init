param(
	[Parameter(Mandatory=$False,Position=1)]
	[string]$candyland
)

$candyland = $PSBoundParameters.ContainsKey('candyland')

function ChocoInstallPackages {
	$Packages = ''
	
	If($candyland) {
		$Packages = 'googlechrome', 'winrar', 'steam', 'spotify', 'discord', 'vscode', 'notepadplusplus', 'git', 'tortoisegit', 'insomnia-rest-api-client', 'intellijidea-ultimate', 'datagrip', 'liberica8jdk', 'php', 'composer'
	} Else {
		$Packages = 'googlechrome', 'winrar', 'vscode', 'notepadplusplus', 'git', 'tortoisegit', 'insomnia-rest-api-client', 'intellijidea-ultimate', 'datagrip', 'liberica8jdk,' 'php', 'composer'
	}
	
	ForEach ($PackageName in $Packages)
	{
		choco install $PackageName -y
	}
}

function ChocoInstall {
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
	ChocoInstallPackages
}

function ChocoStart {
	If(Test-Path -Path "$env:ProgramData\Chocolatey") {
		Write-Output "Chocolatey is already installed"
		ChocoInstallPackages
	} Else {
		Write-Output "Chocolatey installation not found, this "
		ChocoInstall
	}
}

Write-Output "Welcome this installer will get you ready to go with less effort. Hope you like it =)"
ChocoStart
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
$email = Read-Host -Prompt "Please input your e-mail, it will be used to configure your git"
ssh-keygen -t ed25519 -C $email
git config --global user.email $email
$user = Read-Host -Prompt "Please input your name, it will be used to configure your git too"
git config --global user.name $user
Write-Output "Everything done, you can now start configuring your programs =D"