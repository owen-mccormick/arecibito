import serial
import time
import matplotlib.pyplot as plt
import numpy as np
import os
from waiting import wait

# Wait for serial to connect
wait(lambda: os.path.exists('/dev/ttyACM0'), timeout_seconds = 30)
arduino = serial.Serial('/dev/ttyACM0', 9600)

# Based on example at 'https://matplotlib.org/stable/plot_types/stats/hist2d.html'
fig, ax = plt.subplots()
plt.style.use('_mpl-gallery-nogrid')
xCoord = 0.5
yCoord = 9.5
leftToRight = True;
xVals = np.array([])
yVals = np.array([])
num = 0

while num < 100:
    if arduino.in_waiting > 0:
        print("X", xCoord, " Y ", yCoord)
        for i in range(int.from_bytes(arduino.read())):
            xVals = np.append(xVals, xCoord)
            yVals = np.append(yVals, yCoord)
        # Scan through to next cell
        if leftToRight:
            if xCoord > 9:
                leftToRight = False
                yCoord -= 1;
            else:
                xCoord += 1
        else:
            if xCoord < 1:
                leftToRight = True
                yCoord -= 1
            else:
                xCoord -= 1
        num += 1
        
ax.hist2d(xVals, yVals, bins = (np.arange(0, 11, 0.5), np.arange(0, 11, 0.5)))
ax.set(xlim = (0, 11), ylim = (0, 11))
plt.show()

