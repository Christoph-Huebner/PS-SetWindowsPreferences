# -----------------------------------------------------------------------------------
# Header
# -----------------------------------------------------------------------------------
# Programname: PS-SetWindowsPreferences 
# Current version: v0.1
# Owner: C. Huebner
# Creation date: 2023-07-23
# -----------------------------------------------------------------------------------
# Changes
#
# -----------------------------------------------------------------------------------
# Parameter
# -----------------------------------------------------------------------------------
# Only messages will displayed if this is set to true => no actions taking place
[boolean]$DEBUG = $false;
# Set you computername
[string]$computerName = "MyPC";
# Get windows key
#wmic path softwarelicensingservice get OA3xOriginalProductKey;
[string]$windowsKey = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
# -----------------------------------------------------------------------------------
try {

    Write-Host "Start to set the generally windows preferences.`n" -ForegroundColor Magenta;
    Write-Host "Start to set the SSD hard drive settings (disable: defragmatation, hibernate mode, prefetcher, superfetch, fast startup, windows indexing; activate: AHCI mode)..." -ForegroundColor White;

    if (!$DEBUG) {

        # SSD optimizations
        # ----------------
        # Disable defragmatation
        SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\Defrag\ScheduledDefrag";

        # Disable the hibernate option
        POWERCFG /HIBERNATE /OFF;

        # Disable prefetcher
        REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" `
            /v EnablePrefetcher /t REG_DWORD /d 0 /f;

        # Disable superfetch
        REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" `
            /v EnableSuperfetch /t REG_DWORD /d 0 /f;

        # Disable fast startup
        REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Power" `
            /v HiberbootEnabled /t REG_DWORD /d 0 /f;

        # Activate AHCI modus
        REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iaStorV" `
            /v Start /t REG_DWORD /d 0 /f;

        # Disable windows indexing
        Stop-Service -Name "WSearch" -Force;
        Set-Service -Name "WSearch" -StartupType Disabled;
    }
    Write-Host "Finish with the SSD hard drive settings (see above)." -ForegroundColor DarkGreen;

    Write-Host "Start to set the energy settings (never change to energy saving mode or shut off the monitor, noting happens if the laptop will closed)..." -ForegroundColor White;
    if (!$DEBUG) {

        # Energy settings
        # ----------------
        # Change all energy settings to never 
        POWERCFG /CHANGE /monitor-timeout-ac 0;
        POWERCFG /CHANGE /monitor-timeout-dc 0;
        POWERCFG /CHANGE /standby-timeout-ac 0;
        POWERCFG /CHANGE /standby-timeout-dc 0;

        # Set to nothing happens when the laptop will closed
        POWERCFG /SETACVALUEINDEX SCHEME_CURRENT SUB_BUTTONS LIDACTION 0
        POWERCFG /SETDCVALUEINDEX SCHEME_CURRENT SUB_BUTTONS LIDACTION 0
    }
    Write-Host "Finish with the energy settings (see above)." -ForegroundColor DarkGreen;

    Write-Host "Set computername to $($computerName) and windows key & activation and require 'strg+alt+del' for login..." -ForegroundColor White;
    if (!$DEBUG) {

        # Rename the computer
        Rename-Computer -NewName $computerName;

        # Set windows key and activate this
        slmgr /upk;
        slmgr /ipk $windowsKey;
        slmgr /ato;
        
        # Strg + alt + del windows logon is needed 
        REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" `
            /v DisableCAD /t REG_DWORD /d 0 /f;
    }
    Write-Host "Finish with the settings (see above) and windows is activated." -ForegroundColor DarkGreen;

    Write-Host "Start with the data policity settings (deny all, send basic telemetry data)..." -ForegroundColor White;
    if (!$DEBUG) {

        # Data policity
        # ---------------

            # Windows policity
            # ----------------

            # Disable relevant ads for all users
            REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" `
                /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f;

            # Disable Privacy Settings Experience
            REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OOBE" `
                /v DisablePrivacyExperience /t REG_DWORD /d 1 /f;
        
            # Send only the basic telemetry data (0 - disabled, 1 - basic, 2 - advanced, 3 - full)
            REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" `
                /v AllowTelemetry /t REG_DWORD /d 1 /f;

            # App Policity
            # -------------
            # Disable 'let windows apps activate with voice' for All Users
            REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" `
                /v LetAppsActivateWithVoice /t REG_DWORD /d 2 /f;
        
            # Disable location service
            REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" `
                /v Value /t REG_SZ /d "deny" /f;

        # Update & Security
        # -----------------
        # Turn off find my device
        REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MdmCommon\SettingValues" `
            /v LocationSyncEnabled /t REG_DWORD /d 0 /f;
    }
    Write-Host "Finish with the data policity settings (see above)." -ForegroundColor DarkGreen;

    Write-Host "`nFinish with the windows preferences.`n" -ForegroundColor DarkGray;
}
catch {

    $e = $_.Exception;
    $line = $_.InvocationInfo.ScriptLineNumber;
    $msg = $e.Message;

    Write-Error "In script main.ps $($msg) see line $($line)" -Category InvalidOperation -TargetObject $e;
}
finally {

    #    Write-Host "Done";
}