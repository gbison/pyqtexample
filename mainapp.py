import nothing as nothing
from SIGSLog import SIGSLog
from PyQt5.QtCore import QObject, pyqtSlot, QUrl, pyqtSignal

'''
@Author Bryan Ison
@Date 3/23/2021
@Description
This servers the role of the main runnable application. You should consider pulling other
models and business logic through this class and it will automatically be available to the 
front end under the base architecture.
'''


class MainApp(QObject):
    # Must send signals to the QML model in order to facilitate communications.
    # Variable data you want to pass to the front, should be a signal object.
    readText = pyqtSignal(str)
    readPath = pyqtSignal(str)

    def __init__(self):
        QObject.__init__(self)
        self.fileText = nothing
        self.filePath = nothing
        self.application = self
        self.log = SIGSLog("SigsLog.txt", "SigsLog - Main App")
        self.log.info("Main App Initialized!")

    @pyqtSlot()
    def welcomeText(self):
        print("Clicked")

    @pyqtSlot(str)
    def sayMyName(self, name):
        print(name)

    @pyqtSlot()
    def closeApp(self):
        self.log.info("Application Exiting Gracefully!")
        self.application.exit(0)

    @pyqtSlot(str)
    def print(self, msg):
        print(msg)
        self.log.info(msg)

    @pyqtSlot(str)
    def openFile(self, filePath):
        try:
            file = open(QUrl(filePath).toLocalFile(), encoding="utf-8")
            self.fileText = str(file.read())
            self.log.info("File Opened & Read: " + filePath)
            self.readText.emit(str(self.fileText)) # Pushes a call to the front end Connections
        except Exception as err:
            self.log.error("There was an ERROR in opening the file, check file path!")
            raise err("File Error - Main App (OpenFile)")
        finally:
            file.close()
            self.log.info("File Closed: " + filePath)

    @pyqtSlot()
    def getFileText(self) -> str:
        return str(self.fileText)

    @pyqtSlot(str)
    def setFilePath(self, path):
        self.filePath = path
        self.readPath.emit(str(self.filePath))
