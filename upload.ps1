# ========================================
# Upload Arduino Sketch
# สำหรับ upload sketch ผ่าน arduino-cli
# ========================================

param(
    [string]$SketchPath = ".",
    [string]$Port = "",
    [string]$Board = "esp32:esp32:esp32"
)

Write-Host "📤 กำลัง Upload Arduino Sketch..." -ForegroundColor Cyan
Write-Host ""

# หาไฟล์ .ino
$inoFiles = Get-ChildItem -Path $SketchPath -Filter "*.ino" -File
if ($inoFiles.Count -eq 0) {
    Write-Host "❌ ไม่พบไฟล์ .ino ในโฟลเดอร์นี้" -ForegroundColor Red
    exit 1
}

$sketch = $inoFiles[0].FullName

# ถ้าไม่ได้ระบุ port ให้แสดงรายการ port ที่มี
if ([string]::IsNullOrEmpty($Port)) {
    Write-Host "📟 ค้นหา Serial Ports..." -ForegroundColor Yellow
    arduino-cli board list
    Write-Host ""
    $Port = Read-Host "กรุณาระบุ Port (เช่น COM13)"
}

Write-Host "   Sketch: $($inoFiles[0].Name)" -ForegroundColor Gray
Write-Host "   Port: $Port" -ForegroundColor Gray
Write-Host "   Board: $Board" -ForegroundColor Gray
Write-Host ""

try {
    # Upload sketch
    arduino-cli upload -p $Port --fqbn $Board $sketch --verbose
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✅ Upload สำเร็จ!" -ForegroundColor Green
        Write-Host ""
        
        # ถามว่าต้องการเปิด Serial Monitor หรือไม่
        $openMonitor = Read-Host "ต้องการเปิด Serial Monitor หรือไม่? (y/n)"
        if ($openMonitor -eq 'y') {
            & "$PSScriptRoot\serial_monitor.ps1" -Port $Port
        }
    } else {
        Write-Host ""
        Write-Host "❌ Upload ล้มเหลว" -ForegroundColor Red
        exit $LASTEXITCODE
    }
} catch {
    Write-Host "❌ เกิดข้อผิดพลาด: $_" -ForegroundColor Red
    exit 1
}
