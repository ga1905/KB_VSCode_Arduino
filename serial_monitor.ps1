# ========================================
# Serial Monitor Helper Scripts
# ========================================

# เปิด Serial Monitor ด้วย baud rate 115200
function Start-SerialMonitor {
    param(
        [string]$Port = "COM13",
        [int]$BaudRate = 115200
    )
    
    Write-Host "🔌 เปิด Serial Monitor..." -ForegroundColor Cyan
    Write-Host "   Port: $Port" -ForegroundColor Gray
    Write-Host "   Baud Rate: $BaudRate" -ForegroundColor Gray
    Write-Host "   กด Ctrl+C เพื่อออก" -ForegroundColor Yellow
    Write-Host ""
    
    arduino-cli monitor -p $Port -c baudrate=$BaudRate
}

# Alias สำหรับเรียกใช้งาน
Set-Alias -Name monitor -Value Start-SerialMonitor

# Export functions
Export-ModuleMember -Function Start-SerialMonitor -Alias monitor
