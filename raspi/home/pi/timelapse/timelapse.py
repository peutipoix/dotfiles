#!/bin/bash

# Take timelapse picture, one every 15 seconds for 30 minutes
raspistill -t 1800000 -tl 15000 -o image_num_%d_today.jpg

import os
import time
import datetime

FRAMES = 80 // env. 20 min
FPS_IN = 10
FPS_OUT = 24
TIMEBETWEEN = 15 # 4 image / minutes 
FILMLENGTH = float(FRAMES / FPS_IN)

print FILMLENGTH

frameCount = 0

while frameCount < FRAMES:
    imageNumber = str(frameCount).zfill(7)
    os.system("raspistill -o image%s.jpg"%(imageNumber))
    frameCount += 1
    time.sleep(TIMEBETWEEN - 6) #Takes roughly 6 seconds to take a picture

dirfmt = "./%4d-%02d-%02d %02d:%02d:%02d"
dirname = dirfmt % time.localtime()[0:6]
os.mkdir(dirname)
os.system("mv *.jpg \"./%s/.\""%(dirname))
#os.system("avconv -r %s -i image%s.jpg -r %s -vcodec libx264 -crf 20 -g 15 -vf crop=2592:1458,scale=1280:720 %s.mp4 && rm -f *.jpg"%(FPS_IN,'%7d',FPS_OUT,filename))
