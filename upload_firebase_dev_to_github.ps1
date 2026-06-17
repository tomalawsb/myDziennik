param([switch]$NoPause)
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root
$repo = 'https://github.com/tomalawsb/myDziennik.git'
$branch = 'firebase-dev'
try {
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw 'Brak programu Git.' }
    if (-not (Test-Path '.git')) { git init }
    git config user.name 'tomalawsb'
    git config user.email 'tomalawsb@users.noreply.github.com'
    $origin = git remote get-url origin 2>$null
    if ($LASTEXITCODE -ne 0) { git remote add origin $repo } elseif ($origin -ne $repo) { git remote set-url origin $repo }
    git fetch origin main $branch 2>$null
    git checkout -B $branch
    git add .
    git diff --cached --quiet
    if ($LASTEXITCODE -ne 0) { git commit -m 'Etap 1-2 DEV PROD' }
    git push -u origin $branch
    if ($LASTEXITCODE -ne 0) { throw 'Wysylka na GitHub nie powiodla sie.' }
    Write-Host 'GOTOWE: firebase-dev' -ForegroundColor Green
} catch {
    Write-Host ('BLAD: ' + $_.Exception.Message) -ForegroundColor Red
    if (-not $NoPause) { pause }
    exit 1
}
if (-not $NoPause) { pause }
