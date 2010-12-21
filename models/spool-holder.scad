module spool_holder(dxf = false)
{
	$fs = 0.1;
	
	spoolOD = 76;
	spoolID = 16;
	rodOD = 8;

	wall = 5;
	thick = wall*4;
	width = spoolID + wall*2;
	height = wall + spoolOD / 2 + spoolID-rodOD;

	realBolt = 3;
	bolt = 4;
	fudge = 0.25;

	x1 = -bolt*2;
	y1 = thick/2;
	x2 = width+bolt*2;
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
				cube([width, thick, height]);         //the main vertical housing
				translate([width/2, thick, height])   //the rounded top of the housing
					rotate([90, 0, 0])
						cylinder(r=width/2, h=thick);

				//flanges for mounting.
				translate([-bolt*2, 0, 0])
					cube([width+bolt*4, thick, wall]);
				translate([x1, y2, 0])
					cylinder(r=thick/2, h=wall);
				translate([x2, y2, 0])
					cylinder(r=thick/2, h=wall);
			}

			//bolt heads for flange
			translate([x1, y1, -1])
				cylinder(r=bolt/2, h=wall+2);
			translate([x2, y2, -1])
				cylinder(r=bolt/2, h=wall+2);
		
			//tiny slices for path simplification.
			translate([x1-wall-bolt/3, thick/2, wall/2])
				cube(size=[wall*2, 0.1, wall], center=true);
			translate([x2+wall+bolt/3, thick/2, wall/2])
				cube(size=[wall*2, 0.1, wall], center=true);
			
			//hole for the spool bearing rod.
			translate([width/2,thick+1,height])
				rotate([90,0,0])
					#cylinder(r=rodOD/2+fudge, h=thick+2);
		}
	}
}

//spool_holder(true);
spool_holder();
