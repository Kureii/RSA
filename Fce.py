import math
import secrets
import random


class RSA():
    def __init__(self, text, n, d=0, e=0):
        self.text = text
        self.blockText = []
        self.n = n
        self.output = ""
        if e:
            self.e = e
            self.enc()
            myOutput = self.output.split()
            tmpOutput = ""
            for i in range(len(myOutput)):
                tmp = self.output.split()[i]
                tmp = hex(int(tmp))
                tmp = tmp[2: len(tmp)]
                tmpOutput += tmp
                if i + 1 != len(myOutput):
                    tmpOutput += "g"
            self.output = tmpOutput
        else:
            self.d = d
            self.dec()

    def blocking(self, block):
        text = self.text
        lenText = len(text)
        if block < lenText:
            for i in range(lenText // block + 1):
                tmp = text[i * block]
                for j in range(block - 1):
                    if i * block + j + 1 < lenText:
                        tmp += text[i * block + j + 1]
                self.blockText.append(tmp)
        else:
            self.blockText = [text]

    def enc(self):
        myenc = ""
        self.blocking(4)
        for i in self.blockText:
            tmp = ""
            for j in i:
                tmp += "0" * (14 - len(bin(ord(j)))) + bin(ord(j))[2:50]
            intTmp = int(tmp, 2)
            myenc += str(pow(intTmp, self.e, self.n)) + " "
        self.output = myenc

    def dec(self):
        mydec = ""
        self.blockText = self.text.split("g")
        for i in self.blockText:
            i = int(i,16)
            tmp = bin(pow(int(i), int(self.d), self.n))[
                2:len(bin(pow(int(i), int(self.d), self.n)))]
            tmp = "0" * (48 - len(tmp)) + tmp
            tmpList = []
            for j in range(4):
                tmp2 = ""
                for k in range(12):
                    tmp2 += tmp[j * 12 + k]
                tmpList.append(tmp2)
            for j in tmpList:
                mydec += chr(int(j, 2))
        self.output = mydec


class genRSAKey():
    def __init__(self):
        P = self.makePrime()
        Q = self.makePrime()
        self.N = P * Q
        FiN = (P - 1) * (Q - 1)
        self.E = self.findE(FiN)
        self.D = self.findD(self.E, FiN)

    def makePrime(self):
        returnTmp = []
        for x in range(10):
            a = random.randrange(0, 10)
            textTmp = ""
            listTmp = list(secrets.token_hex(10))
            random.shuffle(listTmp)
            for i in range(len(listTmp)):
                textTmp += listTmp[i]
            listTmp = textTmp
            textTmp = ""
            listTmp = list(str(int(listTmp, 16))[a: a + 13])
            random.shuffle(listTmp)
            for i in range(len(listTmp)):
                textTmp += listTmp[i]
            textTmp = str(int(textTmp))
            if len(textTmp) != 13:
                for i in range(13 - len(textTmp)):
                    textTmp += str(random.randrange(0, 9))
            returnTmp.append(int(textTmp))
        myReturn = self.isPrime(returnTmp)
        return myReturn

    def isPrime(self, tmpList):
        count = 0
        while True:
            num = tmpList[count]
            if all(num % i != 0 for i in range(2, int(math.sqrt(num))+1)):
                break
            count += 1
            if count == len(tmpList) - 1:
                num = self.makePrime()
                break
        return num

    def findE(self, FiN):
        while True:
            e = random.randrange(3, 999, 2)
            if math.gcd(e, FiN) == 1:
                break
        return e

    def findD(self, E, FiN):
        return pow(E, -1, FiN)


print(RSA("Babička", 1000000000100000000002379, e=7).output)
print(RSA("2cc68612452fcfcdfbbg62db4c103f3c67dec617", 1000000000100000000002379, d="142857142871142857143183").output)
# print(genRSAKey(13))
a = genRSAKey()
# print(a.N)
# print(a.D)
# print(a.E)
#print(RSA("Babička", a.N, e=a.E).output)
#print(RSA("212146011964206266704670067977860233320774378394020", 21552952548819843796184623, d="18008229260469546437923457").output)
