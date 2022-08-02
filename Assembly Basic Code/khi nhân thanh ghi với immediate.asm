.text
 # Assign X, Y
 addi $t1, $zero, 4 # X = $t1 = 4
 addi $t2, $zero, 5 # Y = $t2 = 5
 # Expression Z = 3*XY
 mul $s0, $t1, $t2 # HI-LO = $t1 * $t2 = X * Y ; $s0 = LO
 mul $s0, $s0, 3 # $s0 = $s0 * 3 = 3 * X * Y
 # Z' = Z
 mflo $s1
#$s0 là LO, HI là $s1

#phai luu ra thanh ghi tam
#VD o tren ta nhan t1 và t2 thi nhan 2 thanh ghi duoc nhung khi nhan s0 voi 3 thi k the nhan tt voi 3 ma phai luu 3 ra thanh ghi
#tam r nhan 2 thanh ghi voi nhau
