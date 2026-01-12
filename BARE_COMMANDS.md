# 🖥️ Bare Commands - Arduino CLI

คำสั่งแบบเปล่าๆ สำหรับ copy-paste ไปใช้ได้เลย

## 🔄 รีโหลด PATH (รันก่อนเสมอ)

```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
```

---

## 📟 ตรวจสอบ Serial Ports

```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli board list
```

---

## 🔨 Build (Compile)

### ESP32 Dev Module
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli compile --fqbn esp32:esp32:esp32 .
```

### ESP32 Dev Module (แสดงรายละเอียด)
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli compile --fqbn esp32:esp32:esp32 . --verbose
```

### ESP32-S2
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli compile --fqbn esp32:esp32:esp32s2 .
```

### ESP32-C3
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli compile --fqbn esp32:esp32:esp32c3 .
```

---

## 📤 Upload

### Upload ไปที่ COM13
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli upload -p COM13 --fqbn esp32:esp32:esp32 .
```

### Upload ไปที่ COM13 (แสดงรายละเอียด)
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli upload -p COM13 --fqbn esp32:esp32:esp32 . --verbose
```

### Upload ไปที่ port อื่น (เปลี่ยน COM13 เป็น port ที่ต้องการ)
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli upload -p COM3 --fqbn esp32:esp32:esp32 .
```

---

## ⚡ Build + Upload (ในคำสั่งเดียว)

### COM13
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli compile --fqbn esp32:esp32:esp32 .; arduino-cli upload -p COM13 --fqbn esp32:esp32:esp32 .
```

### COM3
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli compile --fqbn esp32:esp32:esp32 .; arduino-cli upload -p COM3 --fqbn esp32:esp32:esp32 .
```

---

## 🔌 Serial Monitor

### COM13 @ 115200 baud
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli monitor -p COM13 -c baudrate=115200
```

### COM13 @ 9600 baud
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli monitor -p COM13 -c baudrate=9600
```

### COM3 @ 115200 baud
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli monitor -p COM3 -c baudrate=115200
```

---

## 🔄 Workflow เต็ม

### 1. เช็ค Port
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli board list
```

### 2. Build
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli compile --fqbn esp32:esp32:esp32 .
```

### 3. Upload (เปลี่ยน COM13 เป็น port ของคุณ)
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli upload -p COM13 --fqbn esp32:esp32:esp32 .
```

### 4. Monitor
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli monitor -p COM13 -c baudrate=115200
```

---

## 🛠️ คำสั่งเสริม

### ตรวจสอบ Arduino CLI version
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli version
```

### แสดง Board ที่ติดตั้ง
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli core list
```

### แสดง Library ที่ติดตั้ง
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli lib list
```

### ค้นหา Library
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli lib search NKP_ONE
```

### Update index
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli core update-index
```

---

## 📝 หมายเหตุ

- **กด Ctrl+C** เพื่อออกจาก Serial Monitor
- เปลี่ยน `COM13` เป็น port ที่คุณใช้
- เปลี่ยน `115200` เป็น baud rate ที่ต้องการ
- ใช้ `.` หมายถึงโฟลเดอร์ปัจจุบัน (ต้อง cd ไปที่โฟลเดอร์โปรเจกต์ก่อน)

---

## 🎯 Quick Copy Template

**สำหรับ ESP32 ที่ COM13:**

```powershell
# เช็ค Port
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli board list

# Build + Upload + Monitor
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); arduino-cli compile --fqbn esp32:esp32:esp32 .; arduino-cli upload -p COM13 --fqbn esp32:esp32:esp32 .; arduino-cli monitor -p COM13 -c baudrate=115200
```

**ปรับแต่งได้ที่:**
- `COM13` → port ของคุณ
- `esp32:esp32:esp32` → board ของคุณ
- `115200` → baud rate ที่ต้องการ
