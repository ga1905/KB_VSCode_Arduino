# ========================================
# List Serial Ports
# แสดงรายการ Serial Ports ที่พร้อมใช้งาน
# ========================================

Write-Host "📟 ค้นหา Serial Ports..." -ForegroundColor Cyan
Write-Host ""

# แสดงผ่าน arduino-cli
Write-Host "🔍 ผ่าน Arduino CLI:" -ForegroundColor Yellow
arduino-cli board list

Write-Host ""

# แสดงผ่าน Windows
Write-Host "🔍 ผ่าน Windows Device Manager:" -ForegroundColor Yellow
try {
    Get-WmiObject Win32_SerialPort | ForEach-Object {
        Write-Host "   $($_.DeviceID) - $($_.Description)" -ForegroundColor Gray
    }
} catch {
    Write-Host "   ไม่พบ Serial Port" -ForegroundColor Gray
}

Write-Host ""
