# Touchscreen-Toggle (PowerShell version)
# This script toggles the touch screen interface (in Windows, it's a "device") on the Windows client between enabled and disabled states
# This preserves digitizer stylus input for drawing, while eliminating false finger/hand touch input entirely when disabled
# Created by Amphyvi
# https://amphy.fyi
# https://github.com/amphyvi/touchscreen-toggle
#
# Want to use Windows notifications (defaults to $true), or want to use console output instead (set to $false)?
$useNotifications = $true

# ------------------------------------------------------------------

# Check if running as administrator
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script requires administrator privileges. Relaunching..." -ForegroundColor Yellow
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Variables
$scriptTitle = "Touchscreen Toggle"
$autoCloseTimer = 5
$failedTextAppend = "`nIs this being run as admin? (Automatically closing in $($autoCloseTimer) seconds)"

# Show notifications in Windows 10/11
# Thanks, Den! - https://den.dev/blog/powershell-windows-notification
function Show-Notification {
    [cmdletbinding()]
    Param (
        [string]
        $ToastTitle,
        [string]
        [parameter(ValueFromPipeline)]
        $ToastText
    )

    [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null
    $Template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)

    $RawXml = [xml] $Template.GetXml()
    ($RawXml.toast.visual.binding.text | Where-Object {$_.id -eq "1"}).AppendChild($RawXml.CreateTextNode($ToastTitle)) > $null
    ($RawXml.toast.visual.binding.text | Where-Object {$_.id -eq "2"}).AppendChild($RawXml.CreateTextNode($ToastText)) > $null

    $SerializedXml = New-Object Windows.Data.Xml.Dom.XmlDocument
    $SerializedXml.LoadXml($RawXml.OuterXml)

    $Toast = [Windows.UI.Notifications.ToastNotification]::new($SerializedXml)
    $Toast.Tag = "PowerShell"
    $Toast.Group = "PowerShell"
    $Toast.ExpirationTime = [DateTimeOffset]::Now.AddMinutes(1)

    $Notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("$($scriptTitle)")
    $Notifier.Show($Toast);
}

# Get all touch screen devices
$touchscreenDevices = Get-PnpDevice | Where-Object { $_.FriendlyName -like "*touch screen*" }

# If no touch screen devices found, notify user and exit
if (-not $touchscreenDevices) {
    if ($useNotifications) {
        Show-Notification -ToastTitle "$([char]0x26A0) No touch screen found" -ToastText "$($scriptTitle) took no action."
        exit 1
    } else {
        Write-Host "$([char]0x26A0) No touch screen device(s) found $($failedTextAppend)" -ForegroundColor Yellow
        Start-Sleep -Seconds 3
        exit 1
    }   
}

# Check for enabled devices and disable them
$enabledDevices = $touchscreenDevices | Where-Object { $_.Status -eq "OK" }
try {
    if ($enabledDevices) {
        if($useNotifications) {
            # Only sending one notif at a time to avoid clogging user's notif history
            $enabledDevices | Disable-PnpDevice -Confirm:$false
            Show-Notification -ToastTitle "$([char]0x2705) Touch turned off" -ToastText "Touch screen(s) successfully disabled."
        } else {
            Write-Host "Found enabled touch screen device(s). Disabling..."
            $enabledDevices | Disable-PnpDevice -Confirm:$false
            Write-Host "$([char]0x2713) Touch screen(s) successfully turned off (disabled)" -ForegroundColor Green
        }
    }
}
catch {
    if ($useNotifications) {
        Show-Notification -ToastTitle "$([char]0x274C) Failed" -ToastText "$scriptTitle couldn't turn touch off."
    } else {
        Write-Host "$([char]0x2715) Failed to disable touch screen(s) $($failedTextAppend)" -ForegroundColor Red
        Start-Sleep -Seconds $autoCloseTimer
        exit 1
    }
}

# Check for disabled devices and enable them
$disabledDevices = $touchscreenDevices | Where-Object { $_.Status -ne "OK" }
try {
    if ($disabledDevices) {
        if ($useNotifications) {
            # Only sending one notif at a time to avoid clogging user's notif history
            $disabledDevices | Enable-PnpDevice -Confirm:$false
            Show-Notification -ToastTitle "$([char]0x2705) Touch turned on" -ToastText "Touch screen(s) successfully enabled."
        } else {
            Write-Host "> Found disabled touch screen device(s). Enabling..."
            $disabledDevices | Enable-PnpDevice -Confirm:$false
            Write-Host "$([char]0x2713) Touch screen(s) successfully turned on (enabled)" -ForegroundColor Green
        }
    }
}
catch {
    if ($useNotifications) {
        Show-Notification -ToastTitle "$([char]0x274C) Failed" -ToastText "$scriptTitle couldn't turn touch on."
    } else {
        Write-Host "$([char]0x2715) Failed to enable touch screen(s) $($failedTextAppend)" -ForegroundColor Red
        Start-Sleep -Seconds $autoCloseTimer
        exit 1
    }
}

# >>> Comment out to close the script immediately as soon as the toggle takes place
Start-Sleep -Seconds 1.5
exit 0