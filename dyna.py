#Pulfrich Pendulum. 
import pypot.dynamixel
import math
import time
import numpy as np
ports = pypot.dynamixel.get_available_ports()

if not ports:
    raise IOError('no port found!')

print('ports found', ports)
print('connecting on the first available port:', ports[0])

dxl_io = pypot.dynamixel.DxlIO(ports[0])
ids = dxl_io.scan(range(0,25))
print ids
id = ids[0]
print "Id = " + str(id)

a=45
dxl_io.set_goal_position({id:-a})
dxl_io.set_moving_speed({id:20})
time.sleep(5)

dxl_io.set_moving_speed({id:300})
f = open("ANGLES 2.dat")
d = open("TIME 2.dat")
angles = f.readline().split(",")
times = d.readline().split(",")

angles = [np.degrees(float(x)) for x in angles]
times = [float(x) for x in times]

for i in range(len(times)-1):
	times[i] =  times[i] - times[i+1]

times = times[::-1]
print (times)
for i in range(0,2):
	x = a
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


