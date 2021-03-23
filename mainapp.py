import sys

import nothing as nothing
from PyQt5.QtCore import QObject, pyqtSlot, QUrl, pyqtSignal


class MainApp(QObject):
    fileText = nothing
    filePath = nothing
    app = nothing

    # We must send signals back to the QML model in order to facilitate communications.
    readText = pyqtSignal(str)
    readPath = pyqtSignal(str)

    def __init__(self):
        QObject.__init__(self)
        self.fileText = "none"

    @pyqtSlot()
    def welcomeText(self):
        print("Clicked")

    @pyqtSlot(str)
    def sayMyName(self, name):
        print(name)

    @pyqtSlot()
    def closeApp(self):
        self.app.exit(0)

    @pyqtSlot(str)
    def print(self, msg):
        print(msg)

    @pyqtSlot(str)
    def openFile(self, filePath):
        file = open(QUrl(filePath).toLocalFile(), encoding="utf-8")
        self.fileText = str(file.read())
        file.close()
        print("File Data: " + self.fileText)
        self.readText.emit(str(self.fileText))

    @pyqtSlot()
    def getFileText(self) -> str:
        return str(self.fileText)

    @pyqtSlot(str)
    def setFilePath(self, path):
        self.filePath = path
        self.readPath.emit(str(self.filePath))
