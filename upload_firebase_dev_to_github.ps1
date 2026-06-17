param(
    [switch]$NoPause
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ProjectRoot
$RepoUrl = 'https://github.com/tomalawsb/myDziennik.git'
$Branch = 'firebase-dev'
$ImportBranch = 'firebase-dev-local-import'

function Ensure-Command([string]$Name, [string]$WingetId) {
    if (Get-Command $Name -ErrorAction SilentlyContinue) { return }
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        throw "Brak programu $Name i brak winget do automatycznej instalacji."
    }
    winget install --id $WingetId --exact --accept-source-agreements --accept-package-agreements
    if ($LASTEXITCODE -ne 0) { throw "Instalacja programu $Name nie powiodla sie." }
    $env:Path = [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' + [Environment]::GetEnvironmentVariable('Path', 'User')
}

try {
    Ensure-Command 'git' 'Git.Git'
    Ensure-Command 'gh' 'GitHub.cli'

    gh auth status *> $null
    if ($LASTEXITCODE -ne 0) {
        gh auth login --web --git-protocol https
        if ($LASTEXITCODE -ne 0) { throw 'Logowanie do GitHub nie powiodlo sie.' }
    }

    if (-not (Test-Path (Join-Path $ProjectRoot '.git'))) {
        git init
        if ($LASTEXITCODE -ne 0) { throw 'Nie udalo sie utworzyc lokalnego repozytorium.' }
    }

    git config user.name 'tomalawsb'
    git config user.email 'tomalawsb@users.noreply.github.com'

    $origin = git remote get-url origin 2>$null
    if ($LASTEXITCODE -ne 0) {
        git remote add origin $RepoUrl
    }
    elseif ($origin -ne $RepoUrl) {
        git remote set-url origin $RepoUrl
    }

    git checkout -B $ImportBranch
    if ($LASTEXITCODE -ne 0) { throw 'Nie udalo sie utworzyc galezi importowej.' }
    git add -A
    git diff --cached --quiet
    if ($LASTEXITCODE -ne 0) {
        git commit -m 'Import oczyszczonego projektu DEV PROD'
        if ($LASTEXITCODE -ne 0) { throw 'Nie udalo sie zapisac lokalnego commita.' }
    }

    git fetch origin main $Branch
    if ($LASTEXITCODE -ne 0) { throw 'Nie udalo sie pobrac galezi z GitHub.' }

    git checkout -B $Branch ("origin/" + $Branch)
    if ($LASTEXITCODE -ne 0) { throw 'Nie udalo sie otworzyc galezi firebase-dev.' }

    git merge $ImportBranch --allow-unrelated-histories -X theirs -m 'Etap 1-2: pelny oczyszczony projekt DEV PROD'
    if ($LASTEXITCODE -ne 0) { throw 'Scalanie pelnego projektu nie powiodlo sie.' }

    git push -u origin $Branch
    if ($LASTEXITCODE -ne 0) {
        throw 'Wysylka galezi firebase-dev nie powiodla sie. Nie wykonano force push.'
    }

    Write-Host ''
    Write-Host 'GOTOWE.' -ForegroundColor Green
    Write-Host 'Pelny projekt wyslano na galaz firebase-dev.' -ForegroundColor Green
}
catch {
    Write-Host ''
    Write-Host ('BLAD: ' + $_.Exception.Message) -ForegroundColor Red
    if (-not $NoPause) { pause }
    exit 1
}

if (-not $NoPause) { pause }
