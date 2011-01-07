#!/usr/bin/python
#
# Copyright (c) 2010 MakerBot Industries
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
#
"""Coil Winder Script

Generates GCode which will control your coil winding bot to make you coils!

Usage: python gcoil-winder.py [options]

Options:
  -h, --help					show this help
  --awg							the AWG of the wire you're winding.  we'll estimate your wire diameter based on this. default = 28
  --length						the length of the coil you'd like to make in millimeters. default = 25mm
  --windings					the number of windings you would like. default = 1000
  --rpm							the Z axis feedrate in mm/min.  default = 30
"""

from math import *
import sys
import getopt

class CoilWinder:
	"Class to handle generating frosting code."
	def __init__(self, awg, length, windings, rpm):

		self.diametersInMM = {
			14:	1.70053,
			15:	1.51765,
			16:	1.35636,
			17:	1.21412,
			18:	1.08585,
			19:	0.97028,
			20:	0.86995,
			21:	0.77724,
			22:	0.69469,
			23:	0.62484,
			24:	0.56007,
			25:	0.50038,
			26:	0.44831,
			27:	0.40386,
			28:	0.36195,
			29:	0.32512,
			30:	0.29083,
			31:	0.26162,
			32:	0.23749,
			33:	0.21209,
			34:	0.18796,
			35:	0.16764,
			36:	0.15113,
			37:	0.13589,
			38:	0.12065,
			39:	0.10541,
			40:	0.09398,
			41:	0.08509,
			42:	0.0762,
			43:	0.06731,
			44:	0.06096,
			45:	0.053213,
			46:	0.048387,
			47:	0.043815,
			48:	0.038989,
			49:	0.035179,
			50:	0.032385
		};

  		self.awg = awg;
  		self.length = length;
  		self.diameter = self.diametersInMM[self.awg];
  		self.windings = windings;
  		self.rpm = rpm;
  		
  		self.coilsPerRow = round(self.length / self.diameter)
  		self.maxCoils = self.coilsPerRow * ceil(self.windings / self.coilsPerRow)
  		self.minCoils = self.coilsPerRow * floor(self.windings / self.coilsPerRow)
  		


	def generate(self):
	
		direction = 1;
		xPos = 0.0;
		
		"Generate the actual GCode"
		print "(", " ".join(sys.argv), ")"
		print "(Get psyched to automatically wind your own coils.)"
		print "(Note: X units are in mm, Y units are in rotations, Feedrate is roughly in RPM)"
  		print "(Winding RPM: %0.2f)" % (self.rpm)
  		print "(Actual Coil Length: %0.2fmm)" % (self.coilsPerRow * self.diameter)
  		print "(Wire AWG: %d)" % (self.awg)
  		print "(Wire Diameter: %.3fmm)" % (self.diameter)
  		print "(Windings per layer: %d)" % (self.coilsPerRow)
  		
  		if (self.minCoils == self.maxCoils):
  			print "(Total Windings: %d)" % (self.windings)
  			if (self.minCoils % 2 == 0):
  				print "(Winding will start and stop at same end.)"
			else:
				print "(Winding will start and stop at opposite ends.)"
		else:
			print "(Warning: winding will stop in the middle of the coil.  Recommended values below.)"
  			if (self.minCoils % 2 == 0):
	  			print "(Smaller: %d, %d layers, start/stop on same end.)" % (self.minCoils, self.minCoils / self.coilsPerRow)
	  			print "(Larger: %d, %d layers, start/stop on opposite ends.)" % (self.maxCoils, self.maxCoils / self.coilsPerRow)
  			else:
  				print "(Smaller: %d, %d layers, start/stop on opposite ends.)" % (self.minCoils, self.minCoils / self.coilsPerRow)
  				print "(Larger: %d, %d layers, start/stop on same end.)" % (self.maxCoils, self.maxCoils / self.coilsPerRow)
  				
		print "G21 (metric ftw)"
		print "G90 (absolute mode)"
		print "G92 X0 Y0 Z0 (zero all axes)"

		for i in range(self.windings):
		
			if (xPos > self.length):
				direction = 0;
			elif (xPos <= 0):
				direction = 1;
				
			if (direction == 1):
				xPos += self.diameter;
			else:
				xPos -= self.diameter;
				
			print "G1 X%.3f Y%d F%.2f" % (xPos, i+1, self.rpm)

		print "M18 (drives off)"
		print "M127"
		

def main(argv):
	
	try:
		opts, args = getopt.getopt(argv, '', [
			'help',
			'awg=',
			'length=',
			'windings=',
			'rpm=',
		])
	except getopt.GetoptError:
		usage()
		sys.exit(2)
        
	awg = 28;
	length = 25.0;
	windings = 1000;
	rpm = 30.0;
	
	for opt, arg in opts:
		if opt in ("-h", "--help"):
			usage()
			sys.exit()
		elif opt in ("--awg"):
			awg = int(arg)
		elif opt in ("--length"):
			length = float(arg)
		elif opt in ("--windings"):
			windings = int(arg)
		elif opt in ("--rpm"):
			rpm = float(arg)

	winder = CoilWinder(awg, length, windings, rpm)
	winder.generate()

def usage():
    print __doc__

if __name__ == "__main__":
	main(sys.argv[1:])
