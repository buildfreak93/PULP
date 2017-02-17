#Artficial Pendulum. Probably the final one. Not Sure
import pypot.dynamixel
import matplotlib.pyplot as plt 
import math
import time
import numpy as np
ports = pypot.dynamixel.get_available_ports()

if not ports:
    raise IOError('no port found!')

print('ports found', ports)
print('connecting on the first available port:', ports[0])

dxl_io = pypot.dynamixel.DxlIO(ports[0])
ids = dxl_io.scan(range(1,25))
print ids
id = ids[0]
print "Id = " + str(id)
dxl_io.set_goal_position({id:45})
#dxl_io.set_moving_speed({id:300})

f = open("ANGLES 2.dat")
d = open("TIME 2.dat")
angles = f.readline().split(",")
times = d.readline().split(",")

angles = [angles[x] for x in range(0,len(angles),2)]
times = [times[x] for x in range(0,len(times),2)]

angles = [np.degrees(float(x)) for x in angles]
times = [float(x) for x in times]
for i in range(len(times)-1):
	times[i] = times[i] - times[i+1]

times = times[::-1]


raw_input("start")

while True:
	x = -45.0
	for i in range(len(times)):
		dxl_io.set_goal_position({id:angles[i]})
		time.sleep(times[i])
	times = times[::-1]
	angles = angles[::-1]

	for i in range(len(times)):
		dxl_io.set_goal_position({id:angles[i]})
		time.sleep(times[i])
	
	times = times[::-1]
	angles = angles[::-1]
