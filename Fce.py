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

    def enc(self):
        myenc = ""
        self.blocking(4)
        for i in self.blockText:
            tmp = ""
            for j in i:
                tmp += "0" * (14 - len(bin(ord(j)))) + bin(ord(j))[2:50]
            intTmp =  int(tmp, 2)
            myenc += str(pow(intTmp, self.e, self.n)) + " "

    def dec(self):
        mydec= ""
        self.blocking(24)
        for i in self.blockText:
            tmp = bin(pow(int(i), int(self.d), self.n))[2:len(bin(pow(int(i), int(self.d), self.n)))]
            tmp = "0" * (48 - len(tmp)) + tmp
            tmpList = []
            for j in range(4):
                tmp2 = ""
                for k in range(12):
                    tmp2 += tmp[j * 12 + k]
                tmpList.append(tmp2)
            for j in tmpList:
                mydec += chr(int(j,2))


RSA("Ahoj Pepo", 1000000000100000000002379, e = 7)
RSA("403679926881504087841181453780296333777991136969207616015289871", 1000000000100000000002379, d="142857142871142857143183")

