# This Python file uses the following encoding: utf-8
import sys
import os

import nothing
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

from mainapp import MainApp

app = nothing

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Get Context
    mainApp = MainApp()
    mainApp.app = app
    engine.rootContext().setContextProperty("main", mainApp)

    # Load QML File
    engine.load(os.path.join(os.path.dirname(__file__), "main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
