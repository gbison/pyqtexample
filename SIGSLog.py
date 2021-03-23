import datetime
import logging

'''
Concrete Logfile class to handle file logging.
@Author: Bryan Ison
Date: 1/9/2021
'''


class SIGSLog:

    def __init__(self, logfilename, logname, level=logging.INFO):
        self.date_time = datetime.datetime.now().strftime("%a, %d %b %Y %H:%M:%S")
        logging.basicConfig(filename=logfilename, level=level, datefmt="%a, %d %b %Y %H:%M:%S")
        self.logger = logging.getLogger(logname)

    def setLogLevel(self, level):
        self.logger.setLevel(level=level)
        self.logger.info(self.date_time + " - Log Level Set!")

    def info(self, msg):
        self.logger.info(self.date_time + " - " + msg)
        print("SIGSLog INFO: ", self.date_time, msg)

    def warn(self, msg):
        self.logger.warn(self.date_time + " - " + msg)
        print("SIGSLog WARN: ", self.date_time, msg)

    def error(self, msg):
        self.logger.error(self.date_time + " - " + msg)
        print("SIGSLog ERROR: ", self.date_time, msg)

    def critical(self, msg):
        self.logger.critical(self.date_time + " - " + msg)
        print("SIGSLog CRITICAL: ", self.date_time, msg)
