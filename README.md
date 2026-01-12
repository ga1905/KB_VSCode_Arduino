# KB_VSCode_Arduino

Setup อัตโนมัติสำหรับพัฒนาบอร์ด NKP_ONE ด้วย VS Code + Arduino Extension

## 🎯 คุณสมบัติ

- ✅ ติดตั้ง NKP_ONE Library อัตโนมัติ
- ✅ สร้างโปรเจกต์ตัวอย่างพร้อมใช้งาน
- ✅ ตั้งค่า IntelliSense สำหรับ ESP32
- ✅ พร้อม Build และ Flash ได้ทันที
- ✅ รองรับ GitHub Copilot

## 🚀 วิธีใช้งาน

### ขั้นตอนที่ 1: รัน Setup Script

เปิด PowerShell และรันคำสั่ง:

```powershell
cd D:\GitHubRepos\__kidbright\KB_VSCode_Arduino
.\setup.ps1
```

ถ้ายังไม่มี Arduino CLI ติดตั้งไว้ ให้รัน:

```powershell
winget install -e --id ArduinoSA.CLI
```

ติดตั้ง Arduino CLI สำเร็จแล้ว ตอนนี้ให้ตั้งค่าและติดตั้ง ESP32 board
```
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli version

arduino-cli config init

arduino-cli config add board_manager.additional_urls https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json

arduino-cli core update-index

arduino-cli core install esp32:esp32@2.0.14

arduino-cli core list



```

หรือ **คลิกขวาที่ setup.ps1 → Run with PowerShell**

### ขั้นตอนที่ 2: ตอบคำถาม

Script จะถาม:
- ติดตั้ง Library ใหม่หรือไม่? (y/n)
- สร้างโปรเจกต์ใหม่หรือไม่? (y/n)
- เปิด VS Code ตอนนี้เลยหรือไม่? (y/n)

### ขั้นตอนที่ 3: เริ่มใช้งาน

1. **เปิด VS Code** (ถ้ายังไม่ได้เปิด)
2. **เปิดโฟลเดอร์** `example_project`
3. **เลือก Board**: ESP32 Dev Module
4. **เลือก Port**: COM# (ที่บอร์ดเสียบอยู่)
5. **Upload**: กด `Ctrl + Alt + U`

## 📦 สิ่งที่ Script ทำ

### 1. ติดตั้ง Library
- ดาวน์โหลด NKP_ONE จาก GitHub
- แตกไฟล์และติดตั้งไปที่ Arduino libraries
- ตำแหน่ง: `%USERPROFILE%\Documents\Arduino\libraries\NKP_ONE`

### 2. สร้างโปรเจกต์ตัวอย่าง
```
example_project/
├── NKP_ONE_Example.ino      # โปรแกรมตัวอย่าง
├── .vscode/
│   ├── arduino.json          # ตั้งค่า Arduino
│   ├── c_cpp_properties.json # ตั้งค่า IntelliSense
│   └── settings.json         # ตั้งค่า VS Code
└── README.md                 # เอกสาร
```

### 3. ตั้งค่าอัตโนมัติ
- ✅ Board: ESP32 Dev Module
- ✅ IntelliSense สำหรับ ESP32
- ✅ Serial Monitor
- ✅ Build output folder

## 📋 ข้อกำหนดเบื้องต้น

ก่อนรัน script ต้องมี:

1. ✅ **VS Code** ติดตั้งแล้ว
2. ✅ **Arduino Extension** ติดตั้งแล้ว
3. ✅ **ESP32 Board** ติดตั้งแล้ว (ผ่าน Board Manager)
4. ✅ **Internet** สำหรับดาวน์โหลด Library

### ตรวจสอบ VS Code Extension

เปิด VS Code → Extensions (`Ctrl + Shift + X`):
- ✅ Arduino (by Microsoft)
- ✅ C/C++ (by Microsoft)
- ⭐ GitHub Copilot (optional แต่แนะนำ)

### ติดตั้ง ESP32 Board

ใน VS Code:
1. กด `Ctrl + Shift + P`
2. พิมพ์: `Arduino: Board Manager URLs`
3. เพิ่ม:
   ```
   https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
   ```
4. กด `Ctrl + Shift + P` → `Arduino: Board Manager`
5. ค้นหา "esp32" → Install

## 🎮 โปรแกรมตัวอย่าง

โปรเจกต์ตัวอย่างทำอะไร:
1. แสดงข้อความบน OLED
2. ทดสอบมอเตอร์ (เดินหน้า-หยุด)
3. ทดสอบ Servo (0°, 90°, 180°)
4. อ่านค่า Analog sensor
5. ส่งเสียง Beep

## 🔧 การปรับแต่ง

### เปลี่ยน COM Port

แก้ไขในไฟล์ `.vscode/arduino.json`:
```json
{
    "port": "COM5"  // เปลี่ยนตามที่ใช้งาน
}
```

### เพิ่มโปรเจกต์ใหม่

คัดลอกโฟลเดอร์ `example_project`:
```powershell
Copy-Item -Path "example_project" -Destination "my_project" -Recurse
```

## 🤖 ใช้งานกับ Copilot

### 1. แนะนำโค้ดอัตโนมัติ
```cpp
// พิมพ์ comment: ให้รถเลี้ยวซ้าย
// Copilot จะแนะนำโค้ดให้
```

### 2. Chat กับ Copilot
- กด `Ctrl + I`
- พิมพ์: "เขียนโค้ดให้รถหลบสิ่งกีดขวาง"

### 3. แก้ bug
- เลือกโค้ดที่มีปัญหา
- กด `Ctrl + I` → "แก้ bug"

## 🖥️ ใช้งานผ่าน Command Line (ไม่ต้องใช้ Extension)

หาก Arduino Extension ใช้งานไม่ได้ คุณสามารถใช้ **arduino-cli** ผ่าน Command Line ได้เลย:

### 📋 คำสั่งที่ใช้ได้

#### 1. Build (Compile) โปรแกรม
```powershell
# Build โปรเจกต์ปัจจุบัน
.\build.ps1

# Build โปรเจกต์ที่ระบุ
.\build.ps1 -SketchPath ".\blink"
```

#### 2. Upload โปรแกรม
```powershell
# Upload (จะถามว่าต้องการใช้ Port ไหน)
.\upload.ps1

# Upload ไปที่ Port ที่ระบุ
.\upload.ps1 -Port COM13

# Upload โปรเจกต์ที่ระบุ
.\upload.ps1 -SketchPath ".\blink" -Port COM13
```

#### 3. Build + Upload ในคำสั่งเดียว
```powershell
# Build และ Upload
.\build_upload.ps1

# แบบระบุ Port
.\build_upload.ps1 -Port COM13
```

#### 4. Serial Monitor
```powershell
# เปิด Serial Monitor
.\monitor.ps1

# เปิด Serial Monitor ที่ Port ที่ระบุ
.\monitor.ps1 -Port COM13

# เปิดด้วย Baud Rate ที่ต่างออกไป
.\monitor.ps1 -Port COM13 -BaudRate 9600
```

#### 5. ตรวจสอบ Serial Ports
```powershell
# แสดงรายการ Serial Ports ที่พร้อมใช้งาน
.\list_ports.ps1
```

### 🔄 Workflow ปกติ

```powershell
# 1. ดูว่ามี Port อะไรบ้าง
.\list_ports.ps1

# 2. Build และ Upload ในคำสั่งเดียว
.\build_upload.ps1 -Port COM13

# 3. เปิด Serial Monitor ดูผลลัพธ์
.\monitor.ps1 -Port COM13
```

### ⚙️ ตั้งค่า Board แบบ Manual

```powershell
# Build สำหรับ ESP32 Dev Module (default)
.\build.ps1 -Board "esp32:esp32:esp32"

# Upload สำหรับ ESP32 Dev Module
.\upload.ps1 -Port COM13 -Board "esp32:esp32:esp32"
```

## 🆘 แก้ปัญหา

### ❌ PowerShell บล็อก script
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### ❌ ดาวน์โหลด Library ไม่ได้
ดาวน์โหลดด้วยตนเอง:
1. ไปที่: https://github.com/PrinceBot-Ratthanin/NKP_ONE
2. Code → Download ZIP
3. แตกไฟล์ไปที่ `%USERPROFILE%\Documents\Arduino\libraries\NKP_ONE`

### ❌ Upload ไม่ได้
1. ตรวจสอบ COM Port
2. ติดตั้ง Driver (FTDI/Cypress)
3. กดปุ่ม BOOT บนบอร์ดขณะ Upload

### ❌ IntelliSense ไม่ทำงาน
```
Ctrl + Shift + P → Arduino: Rebuild IntelliSense Configuration
```

### ❌ Arduino Extension ใช้งานไม่ได้
ใช้ Command Line แทน (ดูหัวข้อ "ใช้งานผ่าน Command Line" ด้านบน)

## 📁 โครงสร้างโฟลเดอร์

```
KB_VSCode_Arduino/
├── setup.ps1              # Script ติดตั้งอัตโนมัติ
├── build.ps1              # Build (compile) ผ่าน CLI
├── upload.ps1             # Upload ผ่าน CLI
├── build_upload.ps1       # Build + Upload
├── monitor.ps1            # Serial Monitor
├── list_ports.ps1         # แสดง Serial Ports
├── example_project/       # โปรเจกต์ตัวอย่าง
│   ├── NKP_ONE_Example.ino
│   ├── .vscode/
│   └── README.md
└── README.md              # ไฟล์นี้
```

## 📚 เอกสารเพิ่มเติม

- [NKP_ONE Library](https://github.com/PrinceBot-Ratthanin/NKP_ONE)
- [Arduino Extension](https://marketplace.visualstudio.com/items?itemName=vsciot-vscode.vscode-arduino)
- [ESP32 Arduino Core](https://github.com/espressif/arduino-esp32)
- [VS Code](https://code.visualstudio.com/)

## 🎓 เริ่มต้นใช้งาน

### แบบใช้ VS Code + Extension
```powershell
# 1. รัน setup
.\setup.ps1

# 2. เปิด VS Code
code example_project

# 3. เลือก Board และ Port

# 4. Upload!
Ctrl + Alt + U
```

### แบบใช้ Command Line
```powershell
# 1. รัน setup
.\setup.ps1

# 2. เข้าโฟลเดอร์โปรเจกต์
cd example_project

# 3. Build และ Upload
..\build_upload.ps1 -Port COM13

# 4. เปิด Serial Monitor
..\monitor.ps1 -Port COM13
```

## 🌟 Tips

### สำหรับ VS Code + Extension
- ใช้ `Ctrl + Shift + P` เพื่อเปิด Command Palette
- ใช้ `Ctrl + I` เพื่อ Chat กับ Copilot
- เปิด Serial Monitor: `Ctrl + Shift + P` → `Arduino: Open Serial Monitor`
- Build: `Ctrl + Alt + R`
- Upload: `Ctrl + Alt + U`

### สำหรับ Command Line
- ใช้ `.\list_ports.ps1` เช็ค Port ก่อนเสมอ
- ใช้ `.\build_upload.ps1` สำหรับ Build + Upload ในคำสั่งเดียว
- กด `Ctrl+C` เพื่อออกจาก Serial Monitor
- สามารถกำหนด Port เป็น parameter ได้: `-Port COM13`

**ขอให้สนุกกับการเขียนโค้ด! 🚀**
