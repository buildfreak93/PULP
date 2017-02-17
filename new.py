import itertools
import pypot.dynamixel
from pypot.dynamixel import * 
ports = pypot.dynamixel.get_available_ports()
with DxlIO(ports[0]) as dxl_io:
    ids = dxl_io.scan([1, 2, 3, 4, 5])

    print(dxl_io.get_present_position(ids))
    dxl_io.set_goal_position(dict(zip(ids, itertools.repeat(0))))
  
 