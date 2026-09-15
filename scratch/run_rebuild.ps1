$pyPath = "$env:LOCALAPPDATA\Microsoft\WindowsApps\python.exe"
& $pyPath scratch/rebuild_clean_articles.py
Write-Host "Rebuild script executed."
