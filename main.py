# This Python file uses the following encoding: utf-8
import sys
import os

import nothing
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

from mainapp import MainApp

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)   # Setup QGUI application for QT
    engine = QQmlApplicationEngine()  # Initialize the QML application engine

    # Get Context
    mainApp = MainApp()               # Instantiate our main application runner
    mainApp.application = app         # Store object for use in other classes

    # Here we tie the front end TARGET in QML to the backend application
    engine.rootContext().setContextProperty("main", mainApp)

    # Load QML GUI File into QML engine and we are up
    engine.load(os.path.join(os.path.dirname(__file__), "main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
