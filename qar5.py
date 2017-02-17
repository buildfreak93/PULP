#Artficial Pendulum. Probably the final one. Not Sure
import pypot.dynamixel
import matplotlib.pyplot as plt 
import math
import time
import numpy as np



f = open("13ANGLES.dat")
d = open("13TIME.dat")


angles = f.readline().split(",")
times = d.readline().split(",")

angles = [angles[x] for x in range(0,len(angles),5)]
times = [times[x] for x in range(0,len(times),5)]

angles = [np.degrees(float(x)) for x in angles] 
times = [float(x) for x in times]

for i in range(len(times)-1):
	print(i)
	times[i] = -times[i] + times[i+1]
	angles[i] = angles[i] + 0.082488

times[189] = times[189] - 2.2273 + 0.0013
times[188] = times[188] - 0.014499

plt.plot(angles,times)
times = times[::-1]
print(angles)
print(times)


