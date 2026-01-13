

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
 
  Ref00 = 0;
  Ref01 = 0;
  Ref02 = 0;
  Ref03 = 0;
  Ref04 = 0;
  Ref05 = 0;
  Ref06 = 0;
  Ref07 = 0;
  
     motor(1,30);	motor(2, 30);
  delay(1000);
  ao();
   delay(1000);
  motor(1, -30);	motor(2,  -30);
  delay(1000);
  ao();
  motor(1, 30); motor(2, -30);
  delay(1000);
  ao();
   delay(1000);


  set_oled(0, 20, "0 degree");
  servo(1, 0);
  delay(1000);
  
  // หมุนไป 90 องศา
  set_oled(0, 20, "90 degree");
  servo(1, 90);
  delay(1000);
 

}

void loop() {
  
}

