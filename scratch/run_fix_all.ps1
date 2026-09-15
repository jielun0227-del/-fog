$pyPath = "$env:LOCALAPPDATA\Microsoft\WindowsApps\python.exe"
& $pyPath scratch/fix_all_garbled.py
Write-Host "Fix script finished."
