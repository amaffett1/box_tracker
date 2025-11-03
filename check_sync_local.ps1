Write-Host "=== Verifica sincronizzazione locale (Box Tracker) ===`n"

# Vai nella cartella del progetto (modifica il percorso se diverso)
Set-Location "C:\Users\Alessandro\lavori\server\box_tracker"

# Mostra la posizione corrente
Write-Host "?? Cartella corrente:" (Get-Location) "`n"

# Verifica connessione remota
Write-Host "?? Repository remoto:"
git remote -v | Select-String "origin"
Write-Host ""

# Aggiorna info dal remoto (solo controllo, non modifica nulla)
git fetch origin

# Mostra stato
Write-Host "?? Stato del branch:"
git status
Write-Host ""

# Mostra ultimo commit
Write-Host "?? Ultimo commit locale:"
git log -1 --pretty=oneline
Write-Host ""

# Mostra hash remoto
Write-Host "?? Ultimo commit su GitHub:"
$remote_commit = git ls-remote origin HEAD
Write-Host $remote_commit
Write-Host ""

# Confronta hash locale e remoto
$local_commit = (git rev-parse HEAD).Trim()
$remote_hash = ($remote_commit -split "`t")[0].Trim()

if ($local_commit -eq $remote_hash) {
    Write-Host "? Il repository locale è sincronizzato con GitHub."
} else {
    Write-Host "?? Differenza rilevata: eseguire 'git pull' o 'git push' per allineare."
}

Write-Host "`n=== Fine verifica ==="
