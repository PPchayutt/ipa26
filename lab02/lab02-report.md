Question 1: After you apply, what does Terraform print where a sensitive value would appear? Is the value still stored in the state file?
Ans: บนหน้าจอ Terminal ของ Terraform จะแสดงข้อความว่า <sensitive> แทนการแสดงค่าจริงออกมาเพื่อความปลอดภัย โดยค่านั้นยังคงถูกเก็บไว้ในไฟล์ state (terraform.tfstate)

Question 2: What is the difference between a local and a variable with a default? Give one situation where only a local will work.
Ans: แตกต่างกันตรงที่ Variable จะอนุญาตให้ภายนอกส่งค่าใหม่เข้ามาแก้ไขหรือตั้งค่าทับได้ แต่ Local เป็นค่าที่ใช้เฉพาะภายในโมดูลนั้นๆ เท่านั้น โดยสถานการณ์ที่ต้องใช้ Local เท่านั้นจะเป็นเมื่อต้องการนำตัวแปรอื่นมาผสมหรือคำนวณร่วมกัน เพราะ Variable ปกติจะไม่อนุญาตให้อ้างอิงถึงตัวแปรอื่นภายในตัวมันเอง

Question 3: Terraform will likely plan to destroy and recreate your resources even though the configuration is functionally identical. Why?
Ans: เป็นเพราะ Resource address เปลี่ยนไป โดยจากเดิมคือ aws_instance.web กลายเป็น module.web_server.aws_instance.web ซึ่งพอชื่อไม่เหมือนเดิม Terraform เลยเข้าใจว่าได้ลบของเก่าทิ้งไปแล้วจึงเพิ่มของใหม่เข้ามาแทน

Question 4: Question 4: Why is version = "~> 5.0" required for a registry module but not for a local ./modules/... module?
Ans: เพราะ Registry module เป็นโค้ดจากภายนอกที่มีการอัปเดตเวอร์ชันอยู่เรื่อยๆ การระบุ version = "~> 5.0" จะช่วยล็อกเวอร์ชันไว้ เพื่อป้องกันไม่ให้โค้ดพังหากมีการอัปเดตเวอร์ชันใหม่ ส่วน Local module เป็นโค้ดที่อยู่ในเครื่องของเราซึ่งเป็นคนควบคุมและแก้ไขเอง จึงไม่จำเป็นต้องระบุเวอร์ชัน

What did moving code into a module make easier, and what did it make harder?
Ans: ง่ายขึ้นตรงที่จะช่วยลดความซ้ำซ้อนของโค้ด ทำให้สามารถนำไปใช้ซ้ำกับโปรเจกต์อื่นๆ ได้ง่ายขึ้น และช่วยให้ไฟล์ main.tf หลักดูเรียบร้อย แต่จะยากขึ้นตรงที่ช่วงแรกจะมีความซับซ้อนในการโยงข้อมูล เพราะต้องสร้าง Input และทำการส่งค่า Output ออกไป ซึ่งหากตั้งชื่อผิดหรือโยงไม่ครบก็อาจจะทำให้เกิด Error ได้ง่ายๆ


Lab Report Pictures & Checkpoints (Google Docs): https://docs.google.com/document/d/1mCGgyQmoUGoMq13fedEhnpDl1yXTsZKcCSowlbGjZsU/edit?tab=t.rwbpqv2jdnl1

