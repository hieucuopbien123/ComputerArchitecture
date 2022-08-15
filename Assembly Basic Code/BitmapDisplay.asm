 # Unit Width in Pixels: 16
 # Unit Height in Pixels: 16 
 # Display Width in Pixels: 512
 # Display Height in Pixels: 256
 # cái trên ch? là c?n ch?nh vi?c hi?n th?, th?c t? 1 ô màu luôn là 4 bytes => (x*(512/16) + y)*4 vì 
 # 4 bytes 1 ô màu chi?m 1 ô, mà 512 v?i ph?n chia 16 t?c có 512/16=32 ô

.eqv MONITOR_SCREEN 0x10010000 #Dia chi bat dau cua bo nho man hinh
.eqv RED 0x00FF0000 #Cac gia tri mau thuong su dung
.eqv GREEN 0x0000FF00
.eqv BLUE 0x000000FF
.eqv WHITE 0x00FFFFFF
.eqv YELLOW 0x00FFFF00
.text
 li $k0, MONITOR_SCREEN #Nap dia chi bat dau cua man hinh
 li $t0, GREEN
 sw $t0, 0($k0)
 sw $t0, 4($k0)
 sw $t0, 32($k0)
 sw $t0, 256($k0)
 sw $t0, 512($k0) # pos = x 
 sw $t0, 1152($k0) 
 sw $t0, 1280($k0)
 sw $t0, 1408($k0)
 sw $t0, 1412($k0)
 sw $t0, 1420($k0)
 sw $t0, 1416($k0)
 sw $t0, 1536($k0)
 sw $t0, 1292($k0)
 sw $t0, 1676($k0)
 sw $t0, 1164($k0)
 sw $t0, 1548($k0)
 sw $t0, 1664($k0)
 sw $t0, 1556($k0)
 sw $t0, 1428($k0)
 sw $t0, 1300($k0)
 sw $t0, 1172($k0)
 sw $t0, 1684($k0)
 sw $t0, 916($k0)
 
 sw $t0, 1180($k0)
 sw $t0, 1308($k0)
 sw $t0, 1436($k0)
 sw $t0, 1564($k0)
 sw $t0, 1692($k0)
 sw $t0, 1184($k0)
 sw $t0, 1188($k0)
 sw $t0, 1440($k0)
 sw $t0, 1444($k0)
 sw $t0, 1696($k0)
 sw $t0, 1700($k0)
 sw $t0, 924($k0) 
 sw $t0, 800($k0)
 sw $t0, 932($k0)
 
 sw $t0, 1196($k0)
 sw $t0, 1324($k0)
 sw $t0, 1452($k0)
 sw $t0, 1580($k0)
 sw $t0, 1708($k0)
 sw $t0, 1712($k0)
 sw $t0, 1716($k0)
 sw $t0, 1708($k0)
 sw $t0, 1720($k0)
 sw $t0, 1464($k0)
 sw $t0, 1592($k0)
 sw $t0, 1592($k0)
 sw $t0, 1336($k0)
 sw $t0, 1208($k0)
 
 sw $t0, 680($k0)
 sw $t0, 556($k0)
 
 
