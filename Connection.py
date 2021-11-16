import os
import Fce
from Lang import appLang
from PySide6.QtCore import QObject, Slot, Signal


class GetData(QObject):
    def __init__(self):
        QObject.__init__(self)

    myNKey = Signal(str)
    myEKey = Signal(str)
    myDKey = Signal(str)
    myEncoding = Signal(str)
    myDecoding = Signal(str)

    @Slot()
    def genKey(self):
        a = Fce.genRSAKey()
        self.myNKey.emit(str(a.N))
        self.myEKey.emit(str(a.E))
        self.myDKey.emit(str(a.D))

    @Slot(str, str, str, int)
    def enc(self, txt, n, e, mode):
        output = Fce.RSA(txt, int(n), e=int(e), mode=mode).output
        self.myEncoding.emit(output)

    @Slot(str, str, str, int)
    def dec(self, txt, n, d, mode):
        if mode:
            mytxt = txt.upper()
        mytxt = txt
        outout = Fce.RSA(mytxt, int(n), d=int(d), mode=mode).output
        print(outout)
        self.myDecoding.emit(str(outout))


class Language(QObject):
    def __init__(self):
        QObject.__init__(self)

    nameDec = Signal(str)
    nameDKey = Signal(str)
    nameEKey = Signal(str)
    nameEnc = Signal(str)
    nameEncText = Signal(str)
    nameGen = Signal(str)
    nameNKey = Signal(str)
    nameDecTab = Signal(str)
    nameEncTab = Signal(str)
    nameOpenTxt = Signal(str)
    nameMode = Signal(str)
    nameModuleMode = Signal(list)
    nameModuleMode2 = Signal(list)

    @Slot(str)
    def getLang(self, lng):
        myLang = appLang[lng]
        self.nameDec.emit(myLang['nameDec'])
        self.nameDKey.emit(myLang['nameDKey'])
        self.nameEKey.emit(myLang['nameEKey'])
        self.nameEnc.emit(myLang['nameEnc'])
        self.nameEncText.emit(myLang['nameEncText'])
        self.nameGen.emit(myLang['nameGen'])
        self.nameNKey.emit(myLang['nameNKey'])
        self.nameDecTab.emit(myLang['nameDecTab'])
        self.nameEncTab.emit(myLang['nameEncTab'])
        self.nameOpenTxt.emit(myLang['nameOpenTxt'])
        self.nameMode.emit(myLang['nameMode'])
        self.nameModuleMode.emit(myLang['nameModuleMode'])
        self.nameModuleMode2.emit(myLang['nameModuleMode2'])
