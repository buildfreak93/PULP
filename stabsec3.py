#Pulfrich Pendulum. 
import pypot.dynamixel
import math
import time
import numpy as np
from Tkinter import *
color = "#2C001E"
color2 = "#E95420"

a = 0
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


dxl_io.set_goal_position({id:0})
dxl_io.set_moving_speed({id:20})



#GUI.py
root = Tk()
root.title("Pulfrich")
root.geometry("215x320")
root.configure(bg= color)
app = Frame(root) 
app.grid()
label1 = Label(app, text = "Amplitude:" )
label1.grid()
button1 = Button(text="15 Degrees" , fg = color2, bg = "white")
button1.grid(padx = 30, pady = 10)

button2 = Button(text="30 Degrees", fg = color2, bg = "white")
button2.grid(padx = 30, pady = 10)

button3 = Button(text="45 Degrees", fg = color2, bg = "white")
button3.grid(padx = 30, pady = 10)

button4 = Button(text="Execute", fg = color, bg = "white")
button4.grid(padx = 30, pady = 10)

def angle1() :
	global a
	a = 15	
	
def angle2() :
	global a	
	a = 30
	
def angle3() :
	global a	
	a = 45

def quit():
	root.destroy()
    	
	

button1.config(command=angle1)
button1.config( height = 3, width = 16 )
button2.config(command=angle2)
button2.config(  height = 3, width = 16 )
button3.config(command=angle3)
button3.config(  height = 3, width = 16 )
button4.config(command=quit)
root.mainloop()

dxl_io.set_goal_position({id:-a})
dxl_io.set_moving_speed({id:20})
time.sleep(3)




if a == 15  :
	dxl_io.set_moving_speed({id:300})
	f = open("15ANGLES.dat")
	d = open("15TIME.dat")
	

elif a == 30  :
	dxl_io.set_moving_speed({id:300})
	f = open("30ANGLES(1).dat")
	d = open("30TIME(3).dat")
	

elif a == 45  :
	dxl_io.set_moving_speed({id:300})
	f = open("40ANGLES.dat")
	d = open("40TIME.dat")
	

else  :
	dxl_io.set_goal_position({id:0})


angles = f.readline().split(",")
times = d.readline().split(",")
angles = [angles[x] for x in range(0,len(angles),2)]
times = [times[x] for x in range(0,len(times),2)]

angles = [np.degrees(float(x)) for x in angles]
times = [float(x) for x in times]

for i in range(len(times)-1):
	times[i] =  times[i] - times[i+1]
	print(i)
times[411] = times[411] - 2.3635

times = times[::-1]
print (times)
while True:
	x = -a
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


