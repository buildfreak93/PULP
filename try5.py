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
dxl_io.set_moving_speed({id:50})
dxl_io.set_goal_position({id:-45})

time.sleep(3)
dxl_io.set_moving_speed({id:300})

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
	
times[189] = times[189] - 2.2293 + 0.0013
times[188] = times[188] - 0.012499


plt.plot(angles,times)
times = times[::-1]
print(times)
	
plt.plot(angles,times)
times = times[::-1]
print(times)




x = -40.0
for v in range (0,10):
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
	v = v+1
	
dxl_io.set_moving_speed({id:50})
dxl_io.set_goal_position({id:-40})