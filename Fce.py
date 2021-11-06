import math

class RSA():
    def __init__(self,text, n, d = 0, e = 0):
        self.text = text
        self.blockText = []
        self.n = n
        if e:
            self.e = e
            self.enc()
        else:
            self.d = d
            self.dec()

    def blocking(self , block):
        text = self.text
        lenText = len(text)
        for i in range(lenText // block + 1):
            tmp = text[i * block]
            for j in range(block - 1): 
                if i * block + j + 1 < lenText:
                    tmp += text[i * block + j + 1]
            self.blockText.append(tmp)
        print(self.blockText)

    def enc(self):
        myenc = ""
        self.blocking(4)
        for i in self.blockText:
            tmp = ""
            for j in i:
                tmp += "0" * (14 - len(bin(ord(j)))) + bin(ord(j))[2:50]
            print(tmp)
            print(len(tmp))
            intTmp =  int(tmp, 2)
            print(intTmp)
            myenc += str(pow(intTmp, self.e, self.n)) + " "
        print(myenc)

    def dec(self):
        mydec= ""
        self.blocking(24)
        for i in self.blockText:
            print(i)

        


#print("0" * (12 - len(bin(ord("š"))[2:50])) + bin(ord("š"))[2:50]) #full bin 
#print(len("0" * (14 - len(bin(ord("j")))) + bin(ord("j"))[2:50]))
RSA("Ahoj Pepo", 1000000000100000000002379, e = 7)
RSA("403679926881504087841181453780296333777991136969207616015289871", 1000000000100000000002379, d="142857142871142857143183")
print(math.gcd(1000000000100000000002379, 7))

799268815040878411814537