import cv2
import numpy as np
from pyzbar.pyzbar import decode

img = cv2.imread('download.png')

for keluar in decode(img):
    Data_Aku = keluar.data.decode('utf-8')
    print(Data_Aku)
