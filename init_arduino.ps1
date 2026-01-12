# ========================================
# Arduino Environment Initialization
# รันสคริปต์นี้เมื่อเปิด PowerShell terminal ใหม่
# ========================================

Write-Host "🔧 กำลังโหลด Arduino environment..." -ForegroundColor Cyan

# รีโหลด PATH environment variable
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# ตรวจสอบว่า arduino-cli พร้อมใช้งาน
try {
    $version = arduino-cli version 2>&1
    if ($version -match "Version:") {
        Write-Host "✅ Arduino CLI พร้อมใช้งาน: " -ForegroundColor Green -NoNewline
        Write-Host ($version -split "`n")[0] -ForegroundColor Gray
        
        # แสดง ESP32 boards ที่ติดตั้ง
        Write-Host "📟 ESP32 Boards: " -ForegroundColor Yellow -NoNewline
        $cores = arduino-cli core list | Select-String "esp32"
        if ($cores) {
            Write-Host "ติดตั้งแล้ว" -ForegroundColor Green
        } else {
            Write-Host "ยังไม่ได้ติดตั้ง" -ForegroundColor Red
        }
    }
} catch {
    Write-Host "❌ ไม่พบ Arduino CLI - กรุณาติดตั้งก่อน" -ForegroundColor Red
}

# โหลด Serial Monitor helper functions
. "$PSScriptRoot\serial_monitor.ps1"

Write-Host "💡 คำสั่งที่ใช้ได้:" -ForegroundColor Cyan
Write-Host "   monitor          - เปิด Serial Monitor (default: COM13, 115200)" -ForegroundColor Gray
Write-Host "   monitor COM13    - เปิด Serial Monitor ที่ port ที่กำหนด" -ForegroundColor Gray
Write-Host ""
