module tensioner(dxf = false)
{
	$fs = 0.1;
	
	wall = 5;
	thick = wall*3;
	width = wall*3;
	crossBarDia = thick-2;
	height = wall*4 + (wall+crossBarDia/2) * 4;
	realBolt = 3;
	bolt = 4;
	fudge = 0.25;
	
	x1 = -bolt*1.5;
	y1 = thick/2;
	x2 = width+bolt*1.5;
	y2 = thick/2;

	if (dxf)
	{
		difference()
		{
			union()
			{
				translate([x1, y1, 0])
					circle(r=thick/2, center=true);
				translate([-thick/2, 0, 0])
					square([width+thick, thick]);
				translate([x2, y2, 0])
					circle(r=thick/2, center=true);
			}
			
			translate([x1, y1, 0])
				circle(r=realBolt/2, center=true);
				translate([x2, y2, 0])
				circle(r=realBolt/2, center=true);
		}
	}
	else
	{
		difference()
		{
			union()
			{
				//the main vertical housing
				cube([wall, thick, height]);
				translate([wall*2, 0, 0])
					cube([wall, thick, height]);
					
				//the lower cylinder
				translate([0,thick/2, wall+ (wall+crossBarDia/2)])
					rotate([0,90,0])
						cylinder(r=crossBarDia/2, h=width);
						
				//the middle cylinder
				translate([0,thick/2, wall*2 + (wall+crossBarDia/2) * 2])
					rotate([0,90,0])
						cylinder(r=crossBarDia/2, h=width);
						
				//the middle cylinder
				translate([0,thick/2, wall*3 + (wall+crossBarDia/2) * 3])
					rotate([0,90,0])
						cylinder(r=crossBarDia/2, h=width);
						
				//the upper, smaller cylinder
				translate([0,thick/2, wall*4 + (wall+crossBarDia/2) * 4])						
					rotate([0,90,0])
						cylinder(r=crossBarDia/2, h=width);
						
				//the upper left flange
				translate([0,thick/2, height])						
					rotate([0,90,0])
						cylinder(r=thick/2, h=wall);
						
				//the upper right flange
				translate([wall*2,thick/2, height])						
					rotate([0,90,0])
						cylinder(r=thick/2, h=wall);
				
				//flanges for mounting.
				translate([-bolt*1.5, 0, 0])
					cube([width+bolt*3, thick, wall]);
				translate([x1, y1, 0])
					cylinder(r=thick/2, h=wall);
				translate([x2, y2, 0])
					cylinder(r=thick/2, h=wall);
			}

			//bolt heads for flange
			translate([x1, y1, -1])
				#cylinder(r=bolt/2, h=wall+2);
			translate([x2, y2, -1])
				#cylinder(r=bolt/2, h=wall+2);
			
			//tiny slices for path simplification.
			translate([-bolt*3, thick/2, wall/2])
				cube(size=[wall*2, 0.1, wall], center=true);
			translate([width+bolt*3, thick/2, wall/2])
				cube(size=[wall*2, 0.1, wall], center=true);
		}
	}
}

tensioner();
//tensioner(true);
