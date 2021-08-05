Config Scl = P0.0
Config Sda = P0.1
Config Lcd = 16 * 2
Config Lcdpin = Pin , Db4 = P3.4 , Db5 = P3.5 , Db6 = P3.6 , Db7 = P3.7 , E = P2.1 , Rs = P2.0
Deflcdchar 0 , 12 , 18 , 18 , 12 , 32 , 32 , 32 , 32
Config Servos = 2 , Servo1 = P0.2 , Servo2 = P0.3 , Reload = 25
'21 = -85      31 = -3     42 = 88
Dim Ac As Integer , Gy As Integer , B1 As Integer

Cls
Lcd "Hi!"
Waitms 100
I2cstart
I2cwbyte &HD0
I2cwbyte &H6B
I2cwbyte &H00
I2cstop

Do
I2csend &HD0 , &H43
I2creceive &HD0 , Gy(high)
Waitms 5
I2csend &HD0 , &H44
I2creceive &HD0 , Gy(low)
Waitms 5

I2csend &HD0 , &H3D
I2creceive &HD0 , Ac
Waitms 5
'I2csend &HD0 , &H3E
'I2creceive &HD0 , Ac(low)
'Waitms 5

Cls
'Lcd "Gyro  = "
'B1 = Gy \ 131
'Lcd Bcd(b1)
'Lcd Chr(0)
'Lcd "/s"
'Lowerline
'Lcd "Accel = "
'B1 = Ac \ 16384
Lcd Ac
Waitms 10

If Ac > 100 Then
Servo1 = 53
Servo2 = 42
Else
Servo1 = 21
Servo2 = 21
End If

Loop
End