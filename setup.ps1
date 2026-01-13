# ========================================
# KB_VSCode_Arduino Setup Script
# สำหรับติดตั้ง NKP_ONE Library และสร้างโปรเจกต์อัตโนมัติ
# ========================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  KB_VSCode_Arduino Auto Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# ตรวจสอบว่ารัน PowerShell เป็น Administrator หรือไม่
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "⚠️  คำเตือน: แนะนำให้รัน PowerShell as Administrator" -ForegroundColor Yellow
    Write-Host ""
}

# ตัวแปรพื้นฐาน
$arduinoPath = "$env:USERPROFILE\Documents\Arduino"
$librariesPath = "$arduinoPath\libraries"
$nkpLibPath = "$librariesPath\NKP_ONE"
$tempPath = "$env:TEMP\NKP_ONE_Setup"

Write-Host "📂 ตรวจสอบโฟลเดอร์..." -ForegroundColor Yellow

# สร้างโฟลเดอร์ Arduino ถ้ายังไม่มี
if (-not (Test-Path $arduinoPath)) {
    Write-Host "   สร้างโฟลเดอร์: $arduinoPath" -ForegroundColor Gray
    New-Item -Path $arduinoPath -ItemType Directory -Force | Out-Null
}

if (-not (Test-Path $librariesPath)) {
    Write-Host "   สร้างโฟลเดอร์: $librariesPath" -ForegroundColor Gray
    New-Item -Path $librariesPath -ItemType Directory -Force | Out-Null
}

Write-Host "✅ โฟลเดอร์พร้อมใช้งาน" -ForegroundColor Green
Write-Host ""

# ดาวน์โหลด NKP_ONE Library
Write-Host "📥 ดาวน์โหลด NKP_ONE Library..." -ForegroundColor Yellow

if (Test-Path $nkpLibPath) {
    Write-Host "   ⚠️  พบ NKP_ONE Library อยู่แล้ว" -ForegroundColor Yellow
    $overwrite = Read-Host "   ต้องการติดตั้งใหม่หรือไม่? (y/n)"
    if ($overwrite -ne 'y') {
        Write-Host "   ข้าม NKP_ONE Library" -ForegroundColor Gray
        $skipLib = $true
    } else {
        Write-Host "   ลบ Library เดิม..." -ForegroundColor Gray
        Remove-Item -Path $nkpLibPath -Recurse -Force
        $skipLib = $false
    }
} else {
    $skipLib = $false
}

if (-not $skipLib) {
    try {
        # สร้างโฟลเดอร์ temp
        if (Test-Path $tempPath) {
            Remove-Item -Path $tempPath -Recurse -Force
        }
        New-Item -Path $tempPath -ItemType Directory -Force | Out-Null

        # ดาวน์โหลดไฟล์ ZIP
        $zipUrl = "https://github.com/PrinceBot-Ratthanin/NKP_ONE/archive/refs/heads/master.zip"
        $zipFile = "$tempPath\NKP_ONE.zip"
        
        Write-Host "   กำลังดาวน์โหลดจาก GitHub..." -ForegroundColor Gray
        Invoke-WebRequest -Uri $zipUrl -OutFile $zipFile -UseBasicParsing

        # แตกไฟล์ ZIP
        Write-Host "   แตกไฟล์..." -ForegroundColor Gray
        Expand-Archive -Path $zipFile -DestinationPath $tempPath -Force

        # ย้ายไฟล์ไปยัง libraries
        $extractedFolder = Get-ChildItem -Path $tempPath -Directory | Select-Object -First 1
        Move-Item -Path $extractedFolder.FullName -Destination $nkpLibPath -Force

        # ลบไฟล์ temp
        Remove-Item -Path $tempPath -Recurse -Force

        Write-Host "✅ ติดตั้ง NKP_ONE Library สำเร็จ" -ForegroundColor Green
    } catch {
        Write-Host "❌ เกิดข้อผิดพลาด: $_" -ForegroundColor Red
        Write-Host "   กรุณาดาวน์โหลดด้วยตนเองจาก: https://github.com/PrinceBot-Ratthanin/NKP_ONE" -ForegroundColor Yellow
    }
}
Write-Host ""

# สร้างโปรเจกต์ตัวอย่าง
Write-Host "📁 สร้างโปรเจกต์ใหม่..." -ForegroundColor Yellow
Write-Host ""

# ถามชื่อโปรเจกต์
$createProject = Read-Host "ต้องการสร้างโปรเจกต์ใหม่หรือไม่? (y/n)"
if ($createProject -eq 'y') {
    $defaultName = "my_project_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    
    # ป้องกันการใช้ชื่อ example_project
    do {
        $projectName = Read-Host "ชื่อโปรเจกต์ (Enter = $defaultName)"
        
        if ([string]::IsNullOrWhiteSpace($projectName)) {
            $projectName = $defaultName
        }
        
        # แปลงชื่อให้ปลอดภัย (ลบอักขระพิเศษ)
        $projectName = $projectName -replace '[^\w\-_]', '_'
        
        # ตรวจสอบว่าไม่ใช่ชื่อ example_project
        if ($projectName -eq "example_project") {
            Write-Host "   ⚠️  ไม่สามารถใช้ชื่อ 'example_project' ได้ (ชื่อสงวนไว้สำหรับ template)" -ForegroundColor Red
            $projectName = $null
        }
    } while ([string]::IsNullOrWhiteSpace($projectName))
    
    $projectPath = Join-Path $PSScriptRoot $projectName
    
    if (Test-Path $projectPath) {
        Write-Host "   ⚠️  โปรเจกต์ '$projectName' มีอยู่แล้ว" -ForegroundColor Yellow
        $overwriteProject = Read-Host "   ต้องการเขียนทับหรือไม่? (y/n)"
        if ($overwriteProject -ne 'y') {
            Write-Host "   ยกเลิกการสร้างโปรเจกต์" -ForegroundColor Gray
            $skipProject = $true
            $projectPath = $null
        } else {
            Remove-Item -Path $projectPath -Recurse -Force
            $skipProject = $false
        }
    } else {
        $skipProject = $false
    }
    
    if (-not $skipProject) {
        # สร้างโครงสร้างโฟลเดอร์
        New-Item -Path $projectPath -ItemType Directory -Force | Out-Null
        
        # คัดลอกไฟล์จาก example_project
        $examplePath = Join-Path $PSScriptRoot "example_project"
        if (Test-Path $examplePath) {
            Write-Host "   📋 คัดลอกไฟล์ตัวอย่าง..." -ForegroundColor Gray
            
            # คัดลอก .vscode
            if (Test-Path "$examplePath\.vscode") {
                Copy-Item -Path "$examplePath\.vscode" -Destination $projectPath -Recurse -Force
            }
            
            # คัดลอกไฟล์ .ino
            $inoFiles = Get-ChildItem -Path $examplePath -Filter "*.ino"
            foreach ($file in $inoFiles) {
                $newInoName = "$projectName.ino"
                Copy-Item -Path $file.FullName -Destination "$projectPath\$newInoName" -Force
                Write-Host "   ✅ สร้างไฟล์: $newInoName" -ForegroundColor Gray
            }
            
            # คัดลอก README.md (ถ้ามี)
            if (Test-Path "$examplePath\README.md") {
                Copy-Item -Path "$examplePath\README.md" -Destination $projectPath -Force
            }
            
            # อัพเดท arduino.json ให้ชื่อ sketch ตรงกับโปรเจกต์
            $arduinoJsonPath = "$projectPath\.vscode\arduino.json"
            if (Test-Path $arduinoJsonPath) {
                $arduinoJson = Get-Content $arduinoJsonPath -Raw | ConvertFrom-Json
                $arduinoJson.sketch = "$projectName.ino"
                $arduinoJson | ConvertTo-Json -Depth 10 | Set-Content $arduinoJsonPath -Encoding UTF8
            }
        } else {
            Write-Host "   ⚠️  ไม่พบ example_project สร้างโปรเจกต์เปล่า" -ForegroundColor Yellow
            New-Item -Path "$projectPath\.vscode" -ItemType Directory -Force | Out-Null
        }
        
        Write-Host "✅ สร้างโปรเจกต์: $projectName" -ForegroundColor Green
    }
} else {
    Write-Host "   ข้ามการสร้างโปรเจกต์" -ForegroundColor Gray
    $skipProject = $true
    $projectPath = $null
}
Write-Host ""

# ตรวจสอบ VS Code
Write-Host "🔍 ตรวจสอบ VS Code..." -ForegroundColor Yellow
$vscodePath = Get-Command code -ErrorAction SilentlyContinue
if ($vscodePath) {
    Write-Host "✅ พบ VS Code: $($vscodePath.Source)" -ForegroundColor Green
} else {
    Write-Host "⚠️  ไม่พบ VS Code ใน PATH" -ForegroundColor Yellow
    Write-Host "   กรุณาติดตั้ง VS Code: https://code.visualstudio.com/" -ForegroundColor Yellow
}
Write-Host ""

# สรุป
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  🎉 ติดตั้งเสร็จสมบูรณ์!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "📍 ตำแหน่งที่สำคัญ:" -ForegroundColor Cyan
Write-Host "   • Arduino Libraries: $librariesPath" -ForegroundColor Gray
Write-Host "   • NKP_ONE Library: $nkpLibPath" -ForegroundColor Gray

if ($projectPath) {
    Write-Host "   • โปรเจกต์ที่สร้าง: $projectPath" -ForegroundColor Gray
    Write-Host ""
    Write-Host "🚀 ขั้นตอนถัดไป:" -ForegroundColor Cyan
    Write-Host "   1. เปิด VS Code" -ForegroundColor White
    Write-Host "   2. เปิดโฟลเดอร์: $projectPath" -ForegroundColor White
    Write-Host "   3. เลือก Board: ESP32 Dev Module" -ForegroundColor White
    Write-Host "   4. เลือก Port: COM#" -ForegroundColor White
    Write-Host "   5. กด Upload (Ctrl+Alt+U)" -ForegroundColor White
} else {
    Write-Host ""
    Write-Host "💡 หมายเหตุ:" -ForegroundColor Cyan
    Write-Host "   • รัน script อีกครั้งเพื่อสร้างโปรเจกต์ใหม่" -ForegroundColor White
    Write-Host "   • หรือคัดลอก example_project ไปใช้งาน" -ForegroundColor White
}
Write-Host ""

# เปิด VS Code (ถ้าต้องการ)
if ($vscodePath -and $projectPath -and (Test-Path $projectPath)) {
    $openVSCode = Read-Host "ต้องการเปิด VS Code ตอนนี้เลยหรือไม่? (y/n)"
    if ($openVSCode -eq 'y') {
        Write-Host "🚀 กำลังเปิด VS Code..." -ForegroundColor Yellow
        Start-Process "code" -ArgumentList "$projectPath"
        Start-Sleep -Seconds 2
    }
}

Write-Host ""
Write-Host "✨ ขอให้สนุกกับการเขียนโค้ด! ✨" -ForegroundColor Cyan
Write-Host ""
