# 🚀 Quick Reference - Command Line

สำหรับใช้งาน Arduino ผ่าน Command Line โดยไม่ต้องใช้ Extension

## 📋 คำสั่งหลัก

### 🔨 Build (Compile)
```powershell
.\build.ps1
.\build.ps1 -SketchPath ".\blink"
```

### 📤 Upload
```powershell
.\upload.ps1
.\upload.ps1 -Port COM13
.\upload.ps1 -SketchPath ".\blink" -Port COM13
```

### ⚡ Build + Upload
```powershell
.\build_upload.ps1
.\build_upload.ps1 -Port COM13
```

### 🔌 Serial Monitor
```powershell
.\monitor.ps1
.\monitor.ps1 -Port COM13
.\monitor.ps1 -Port COM13 -BaudRate 9600
```

### 📟 List Ports
```powershell
.\list_ports.ps1
```

## 🔄 Workflow ทั่วไป

```powershell
# 1. เช็ค Port
.\list_ports.ps1

# 2. Build + Upload
.\build_upload.ps1 -Port COM13

# 3. Monitor
.\monitor.ps1 -Port COM13
```

## ⚙️ Parameters

### Board (FQBN)
- ESP32 Dev Module: `esp32:esp32:esp32` (default)
- ESP32-S2: `esp32:esp32:esp32s2`
- ESP32-C3: `esp32:esp32:esp32c3`

### Port
- Windows: `COM3`, `COM13`, etc.
- ดูด้วย: `.\list_ports.ps1`

### Baud Rate
- Default: `115200`
- Common: `9600`, `57600`, `115200`

## 💡 ตัวอย่างการใช้งาน

### ตัวอย่าง 1: Upload ไปที่ ESP32 ปกติ
```powershell
cd example_project
..\build_upload.ps1 -Port COM13
..\monitor.ps1 -Port COM13
```

### ตัวอย่าง 2: Upload ไปที่ ESP32-S2
```powershell
cd example_project
..\build_upload.ps1 -Port COM5 -Board "esp32:esp32:esp32s2"
..\monitor.ps1 -Port COM5
```

### ตัวอย่าง 3: Build เฉพาะ (ไม่ Upload)
```powershell
cd example_project
..\build.ps1
```

## 🐛 Debug

### ถ้า Build ผิดพลาด
- ตรวจสอบว่าติดตั้ง ESP32 board แล้ว: `arduino-cli core list`
- ตรวจสอบไฟล์ .ino มีข้อผิดพลาดหรือไม่

### ถ้า Upload ไม่ได้
- เช็ค Port: `.\list_ports.ps1`
- ลอง hold ปุ่ม BOOT บนบอร์ดขณะ Upload
- ตรวจสอบ USB cable (ต้องเป็นสาย data ไม่ใช่สายชาร์จเปล่า)

### ถ้า Serial Monitor ไม่แสดงผล
- ตรวจสอบ Baud Rate ให้ตรงกับโค้ด
- ลอง reset บอร์ด

## ⌨️ Keyboard Shortcuts

- `Ctrl+C` = ออกจาก Serial Monitor
- `Up Arrow` = ดูคำสั่งก่อนหน้า (PowerShell history)
- `Tab` = Auto-complete path/filename

## 📖 คำสั่ง Arduino CLI โดยตรง

```powershell
# Compile
arduino-cli compile --fqbn esp32:esp32:esp32 sketch.ino

# Upload
arduino-cli upload -p COM13 --fqbn esp32:esp32:esp32 sketch.ino

# Monitor
arduino-cli monitor -p COM13 -c baudrate=115200

# List boards
arduino-cli board list

# List installed cores
arduino-cli core list

# List installed libraries
arduino-cli lib list
```

---

**สำหรับรายละเอียดเพิ่มเติม ดูที่ [README.md](README.md)**
