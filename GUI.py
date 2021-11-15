import sys
from PySide6.QtCore import *
from PySide6.QtQml import *
from PySide6.QtWidgets import *
from PySide6.QtCore import QObject, Slot, Signal
from PySide6.QtGui import *
import Connection


class runQML():
    def __init__(self):
        sys_argv = sys.argv
        sys_argv += ['--style', 'Fusion']
        self.app = QApplication(sys_argv)
        app_icon = QIcon()
        app_icon.addFile('icons/TaskBar.svg')
        self.app.setWindowIcon(app_icon)
        QFontDatabase.addApplicationFont('fonts/Roboto-Medium.ttf')
        self.engine = QQmlApplicationEngine()

        self.getD = Connection.GetData()
        self.lang = Connection.Language()
        self.engine.rootContext().setContextProperty("myData", self.getD)
        self.engine.rootContext().setContextProperty("myLang", self.lang)
        self.engine.load('Main.qml')

    def exec(self):
        if not self.engine.rootObjects():
            return -1
        return self.app.exec()


if __name__ == '__main__':
    GUI = runQML()
    GUI.exec()
