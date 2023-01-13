import sys
import os.path
import logging.config
from logging import FileHandler, StreamHandler

root_url = os.path.dirname(os.path.dirname(os.path.realpath(__file__)))

#LOGS Configuration
default_formatter = logging.Formatter("%(asctime)s: %(name)-12s:%(levelname)s:%(message)s")

console_handler = StreamHandler()
console_handler.setFormatter(default_formatter)

error_handler = FileHandler(root_url +"/logs/error.log", "a")
error_handler.setLevel(logging.ERROR)
error_handler.setFormatter(default_formatter)

root = logging.getLogger()
root.addHandler(console_handler)
root.addHandler(error_handler)
root.setLevel(logging.ERROR)

info_handler = FileHandler(root_url +"/logs/info.log", "a")
info_handler.setLevel(logging.INFO)
info_handler.setFormatter(default_formatter)

root = logging.getLogger()
root.addHandler(console_handler)
root.addHandler(info_handler)
root.setLevel(logging.INFO)

def main():
    LOGGING_CONF=os.path.join(os.path.dirname(__file__), "logging.ini")
    logging.config.fileConfig(LOGGING_CONF)

    
if __name__ == '__main__':
    main()


