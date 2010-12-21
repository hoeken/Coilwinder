module bearing_bracket(dxf = false)
{
	$fs = 0.1;
	
	od = 22;
	id=8;
	bearing_thick = 7;
	rotator = 18;
	center_height = 25;

	wall = 5;
	thick = bearing_thick + wall;
	width = od + wall*2;

	realBolt = 3;
	bolt = 4;
	fudge = 0.25;
	
	x1 = -bolt*1.5;
	y1 = thick/2;
	x2 = width+bolt*1.5;
	y2 = thick/2;
	
	echo(x1, y1);
	echo(x2, y2);
	
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
		//center it.
		//translate([-width/2, 0, 0])
		translate([0,0,0])
		{
			difference()
			{
				union()
				{
					cube([width, thick, center_height]);         //the main vertical housing
					translate([width/2, thick, center_height])   //the rounded top of the housing
						rotate([90, 0, 0])
							cylinder(r=width/2, h=thick);

					//flanges for mounting.
					translate([-bolt*1.5, 0, 0])
						cube([width+bolt*3, thick, wall]);
					translate([-bolt*1.5, thick/2, 0])
						cylinder(r=thick/2, h=wall);
					translate([width+bolt*1.5, thick/2, 0])
						cylinder(r=thick/2, h=wall);
					
					//top flange for bolting
					translate([width/2-wall, 0, center_height + od/2])
						cube([wall*2, thick, wall*2.5]);
				}
			
				//position us properly.
				translate([width/2,  1, center_height])
				{
					rotate([-90, 0, 0])
					{
						//small containing wall
						cylinder(r=rotator/2, h=thick*2, center=true);

						//large, bearing wall.
						cylinder(r=od/2+fudge, h=bearing_thick+1+fudge);
					}
				}

				//tiny slice for tightening
				translate([width/2, -1, center_height+wall])
					cube([0.5, thick+2, wall*5]);

				//bolt heads for flange
				translate([x1, y1, -1])
					cylinder(r=bolt/2, h=wall+2);
				translate([x2, y2, -1])
					cylinder(r=bolt/2, h=wall+2);
			
				//bolt heads for tightening on bearing.
				translate([width/2-wall*2, thick/2, center_height + od/2+wall*1.5])
					rotate([0,90,0])
						cylinder(r=bolt/2, h=wall*4);
			
				//tiny slices for path simplification.
				translate([-bolt*3, thick/2, wall/2])
					cube(size=[wall*2, 0.1, wall], center=true);
				translate([width+bolt*3, thick/2, wall/2])
					cube(size=[wall*2, 0.1, wall], center=true);
			}
		}
	}
}

//bearing_bracket();
bearing_bracket(true);
