module spool_holder()
{
	$fs = 0.1;
	
	spoolOD = 76;
	spoolID = 16;
	rodOD = 8;

	wall = 5;
	thick = wall*4;
	width = spoolID + wall*2;
	height = wall + spoolOD / 2 + spoolID-rodOD;

	bolt = 4;
	fudge = 0.25;

	//center it.
//	translate([-width/2, 0, 0])
	
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
				translate([-bolt*1.5, 0, 0])
					cube([width+bolt*3, thick, wall]);
				translate([-bolt*1.5, thick/2, 0])
					cylinder(r=thick/2, h=wall);
				translate([width+bolt*1.5, thick/2, 0])
					cylinder(r=thick/2, h=wall);
			}

			//bolt heads for flange
			translate([-bolt*1.5, thick/2, -1])
				#cylinder(r=bolt/2, h=wall+2);
			translate([width+bolt*1.5, thick/2, -1])
				#cylinder(r=bolt/2, h=wall+2);
			
			//tiny slices for path simplification.
			translate([-bolt*3, thick/2, wall/2])
				cube(size=[wall*2, 0.1, wall], center=true);
			translate([width+bolt*3, thick/2, wall/2])
				cube(size=[wall*2, 0.1, wall], center=true);
				
			//hole for the spool bearing rod.
			translate([width/2,thick+1,height])
				rotate([90,0,0])
					#cylinder(r=rodOD/2+fudge, h=thick+2);
		}
	}
}

spool_holder();
