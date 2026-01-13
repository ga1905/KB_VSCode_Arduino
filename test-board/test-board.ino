

#include <NKP_ONE.h>

void setup() {
  // เริ่มต้น Serial สำหรับ Debug
  Serial.begin(115200);
  
  // เริ่มต้นบอร์ด NKP_ONE
  NKP_ONE();
  
  // แสดงข้อความต้อนรับ
  set_oled_clear();
  set_oled(0, 0, "NKP ONE");
  set_oled(0, 10, "Example");
  set_oled(0, 20, "Press SW1");
  
  // รอกดปุ่ม SW1
  IO15();
  
  // ส่งเสียง Beep เมื่อพร้อม
  beep();
  
  Serial.println("NKP_ONE Ready!");
 
     motor(1,20);	motor(2, 20);
  delay(1000);
  ao();
   delay(1000);
  motor(1,  -20);	motor(2,  -20);
  delay(1000);
  ao();


 

}

void loop() {
  
}

