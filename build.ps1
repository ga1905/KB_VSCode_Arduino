# ========================================
# Build Arduino Sketch
# สำหรับ compile sketch ผ่าน arduino-cli
# ========================================

param(
    [string]$SketchPath = ".",
    [string]$Board = "esp32:esp32:esp32"
)

Write-Host "🔨 กำลัง Build Arduino Sketch..." -ForegroundColor Cyan
Write-Host "   Sketch: $SketchPath" -ForegroundColor Gray
Write-Host "   Board: $Board" -ForegroundColor Gray
Write-Host ""

# หาไฟล์ .ino
$inoFiles = Get-ChildItem -Path $SketchPath -Filter "*.ino" -File
if ($inoFiles.Count -eq 0) {
    Write-Host "❌ ไม่พบไฟล์ .ino ในโฟลเดอร์นี้" -ForegroundColor Red
    exit 1
}

# ถ้ามีหลายไฟล์ ใช้ไฟล์แรก
$sketch = $inoFiles[0].FullName
Write-Host "📄 Sketch: $($inoFiles[0].Name)" -ForegroundColor Yellow
Write-Host ""

try {
    # Compile sketch
    arduino-cli compile --fqbn $Board $sketch --verbose
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✅ Build สำเร็จ!" -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "❌ Build ล้มเหลว" -ForegroundColor Red
        exit $LASTEXITCODE
    }
} catch {
    Write-Host "❌ เกิดข้อผิดพลาด: $_" -ForegroundColor Red
    exit 1
}
