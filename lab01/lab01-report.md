Question 1: Why is pinning the provider version important for a team project?

**Ans:** การกำหนดเวอร์ชันของ Provider ด้วย \~> 5.0 ก็เพราะเพื่อให้ทุกคนใช้เวอร์ชันที่เข้ากันได้เสมอ โดยระบบจะยอมให้อัปเดตเฉพาะ Patch ย่อย แต่ป้องกันการอัปเดตเวอร์ชันหลักที่อาจทำให้โค้ดพัง



Question 2: How many resources will be added?

**Ans:** จะมี Resource ถูกสร้างเพิ่มขึ้นมาทั้งหมด 2 ตัว คือ aws\_instance.web และ aws\_security\_group.web



Question 3: Which attributes show as (known after apply), and why can Terraform not know them yet?

**Ans:** สำหรับ aws\_instance.web จะมีดังนี้

* arn
* associate\_public\_ip\_address
* availability\_zone
* capacity\_reservation\_specification
* cpu\_core\_count
* cpu\_options
* cpu\_threads\_per\_core
* disable\_api\_stop
* disable\_api\_termination
* ebs\_block\_device
* ebs\_optimized
* enable\_primary\_ipv6
* enclave\_options
* ephemeral\_block\_device
* host\_id
* host\_resource\_group\_arn
* iam\_instance\_profile
* id
* instance\_initiated\_shutdown\_behavior
* instance\_lifecycle
* instance\_market\_options
* instance\_state
* ipv6\_address\_count
* ipv6\_addresses
* key\_name
* maintenance\_options
* metadata\_options
* monitoring
* network\_interface
* outpost\_arn
* password\_data
* placement\_group
* placement\_partition\_number
* primary\_network\_interface\_id
* private\_dns
* private\_dns\_name\_options
* private\_ip
* public\_dns
* public\_ip
* root\_block\_device
* secondary\_private\_ips
* security\_groups
* spot\_instance\_request\_id
* subnet\_id
* tenancy
* user\_data\_base64
* vpc\_security\_group\_ids



สำหรับ aws\_security\_group.web จะมีดังนี้

* arn
* id
* name\_prefix
* owner\_id



ซึ่งสาเหตุที่ Terraform ยังไม่สามารถรู้ค่าเหล่านี้ได้ในขั้นตอน plan เป็นเพราะว่าค่าเหล่านี้เป็นข้อมูลที่ระบบของ AWS จะเป็นผู้สร้างและกำหนดขึ้นมาให้ในตอนที่มีการสร้าง Resource จริงๆ เท่านั้น



Question 4: Does Terraform plan to update in place or to replace the instance? Look for the \~ or -/+ symbol and explain what it means.

**Ans:** Terraform จะวางแผนที่จะทำการอัปเดตการตั้งค่าบน Instance ตัวเดิม โดยจะพบสัญลักษณ์ \~ บ่งบอกถึงการเปลี่ยนแปลงค่าบางอย่างของ Resource ที่กำลังทำงานอยู่ ซึ่งคือการเปลี่ยน instance\_type จาก t3.micro เป็น t3.small โดยการเปลี่ยนแปลงรูปแบบนี้ ระบบสามารถปรับค่าให้ได้ทันทีโดยไม่ต้องทำการลบเครื่องเซิร์ฟเวอร์เก่าทิ้งแล้วสร้างขึ้นมาใหม่



Question 5: How did the plan output change compared to Step 4.1? Why would this matter for a production web server?

**Ans:** ผลลัพธ์ไม่มีการเปลี่ยนแปลงไปจากเดิม เพราะว่า Terraform เลือกทำงานแบบ Update in-place (\~) คำสั่ง lifecycle จึงไม่ถูกเรียกใช้งาน แต่ในทางทฤษฎีหากเกิดการ Replace คำสั่งนี้มีความสำคัญกับ Production มาก เพราะจะช่วยป้องกัน Downtime โดยการสร้างเซิร์ฟเวอร์ใหม่ให้พร้อมทำงานก่อนลบตัวเก่าทิ้ง



Question 6: What error do you get, and at what stage does it occur — plan or apply?

**Ans:** พบ Error ว่า "Error: Instance cannot be destroyed"  ซึ่งระบบอธิบายเพิ่มเติมว่า Resource นี้มีการตั้งค่า lifecycle.prevent\_destroy เอาไว้ จึงไม่อนุญาตให้ลบ โดยจะเกิดขึ้นในขั้นตอน plan เพราะมีข้อความแจ้งเตือนว่า "the plan calls for this resource to be destroyed" หมายความว่า Terraform ตรวจพบเงื่อนไขการห้ามลบตั้งแต่ตอนที่กำลังสร้างแผนการทำงานก่อนที่จะลงมือทำลายจริงในขั้นตอน apply

