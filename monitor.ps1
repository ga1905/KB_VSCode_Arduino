# ========================================
# Serial Monitor
# เปิด Serial Monitor ผ่าน arduino-cli
# ========================================

param(
    [string]$Port = "",
    [int]$BaudRate = 115200
)

# ถ้าไม่ได้ระบุ port ให้แสดงรายการ port ที่มี
if ([string]::IsNullOrEmpty($Port)) {
    Write-Host "📟 ค้นหา Serial Ports..." -ForegroundColor Yellow
    arduino-cli board list
    Write-Host ""
    $Port = Read-Host "กรุณาระบุ Port (เช่น COM13)"
}

Write-Host "🔌 เปิด Serial Monitor..." -ForegroundColor Cyan
Write-Host "   Port: $Port" -ForegroundColor Gray
Write-Host "   Baud Rate: $BaudRate" -ForegroundColor Gray
Write-Host "   กด Ctrl+C เพื่อออก" -ForegroundColor Yellow
Write-Host ""

try {
    arduino-cli monitor -p $Port -c baudrate=$BaudRate
} catch {
    Write-Host ""
    Write-Host "❌ ไม่สามารถเปิด Serial Monitor ได้" -ForegroundColor Red
    Write-Host "   กรุณาตรวจสอบว่า Port ถูกต้องและไม่มีโปรแกรมอื่นใช้งานอยู่" -ForegroundColor Yellow
}
