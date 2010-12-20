module tensioner()
{
	$fs = 0.1;
	
	wall = 5;
	thick = wall*3;
	width = wall*3;
	crossBarDia = thick-2;
	height = wall*4 + (wall+crossBarDia/2) * 4;

	bolt = 4;
	fudge = 0.25;

	//center it.
//	translate([-width/2, 0, 0])
	
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
		}
	}
}

tensioner();
