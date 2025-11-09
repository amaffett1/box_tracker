param (
    [string]$msg = "Aggiornamento"
)

git status
git add .
git commit -m $msg
git push origin main
Write-Host "✅ Push completato!"
