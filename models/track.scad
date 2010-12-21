module track(dxf = false)
{
	$fs = 0.1;
	
	wall = 5;
	length = 80;
	width = wall*5;
	crossBarDia = length-2;
	height = 25;

	bolt = 3.5;
	fudge = 0.25;
	bump = 5;

	x1 = -wall;
	y1 = wall;
	x2 = -wall;
	y2 = length-wall;
	x3 = width+wall;
	y3 = length-wall;
	x4 = width+wall;
	y4 = wall;
	
	if (dxf)
	{
		difference()
		{
			union()
			{
				square([width, length]);
				translate([-wall, 0, 0])
					square([width+wall*2, wall*2]);
				translate([-wall, length-wall*2, 0])
					square([width+wall*2, wall*2]);
				translate([x1, y1, 0])
					circle(r=wall, center=true);
				translate([x2, y2, 0])
					circle(r=wall, center=true);
				translate([x3, y3, 0])
					circle(r=wall, center=true);
				translate([x4, y4, 0])
					circle(r=wall, center=true);
			}
			
			translate([x1, y1, 0])
				circle(r=realBolt/2, center=true);
			translate([x2, y2, 0])
				circle(r=realBolt/2, center=true);
			translate([x3, y3, 0])
				circle(r=realBolt/2, center=true);
			translate([x4, y4, 0])
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
				cube([wall, length, height]);
				translate([width-wall, 0, 0])
					cube([wall, length, height]);
				cube([width, length, wall]);
			
				//bumps as guide railing
				/*
				translate([wall*0.75, length, (height-wall)/2+wall])
					rotate([90, 0, 0])
						cylinder(r=bump/2, h=length);
				translate([width-wall*0.75, length, (height-wall)/2+wall])
					rotate([90, 0, 0])
						cylinder(r=bump/2, h=length);
				*/
				
				//flanges for mounting.
				translate([-wall, 0, 0])
				{
					cube([wall*2, wall*2, wall]);
					translate([0, wall, 0])
						cylinder(r=wall, h=wall);
				}
				translate([-wall, length-wall*2, 0])
				{
					cube([wall*2, wall*2, wall]);
					translate([0, wall, 0])
						cylinder(r=wall, h=wall);
				}
				translate([width-wall, 0, 0])
				{
					cube([wall*2, wall*2, wall]);
					translate([wall*2, wall, 0])
						cylinder(r=wall, h=wall);
				}
				translate([width-wall, length-wall*2, 0])
				{
					cube([wall*2, wall*2, wall]);
					translate([wall*2, wall, 0])
						cylinder(r=wall, h=wall);
				}
			}

			//bolt heads for flange
			translate([x1, y1, -1])
				cylinder(r=bolt/2, h=wall+2);
			translate([x2, y2, -1])
				cylinder(r=bolt/2, h=wall+2);
			translate([x3, y3, -1])
				cylinder(r=bolt/2, h=wall+2);
			translate([x4, y4, -1])
				cylinder(r=bolt/2, h=wall+2);
		
			//these are our hole placements.
			echo(x1, y1);
			echo(x2, y2);
			echo(x3, y3);
			echo(x4, y4);
		
			//tiny slices for path simplification.
			translate([-wall*2, wall, wall/2])
				cube(size=[wall*2, 0.1, wall], center=true);
			translate([-wall*2, length-wall, wall/2])
				cube(size=[wall*2, 0.1, wall], center=true);
			translate([width+wall*2, wall, wall/2])
				cube(size=[wall*2, 0.1, wall], center=true);
			translate([width+wall*2, length-wall, wall/2])
				cube(size=[wall*2, 0.1, wall], center=true);
		}
	}
}

module carriage()
{
	$fs = 0.1;
	
	wall = 5;
	bump = 5;
	width = wall*3;
	length = wall*4;
	height = 30;
	
	difference()
	{
		//our main body
		cube([width, length, height]);
		
		/*
		//indents for guide railing
		translate([-wall*0.25, length+1, 25/2-bump/2])
			rotate([90, 0, 0])
				cylinder(r=bump/2, h=length+2);
		translate([width+wall*0.25, length+1, 25/2-bump/2])
			rotate([90, 0, 0])
				cylinder(r=bump/2, h=length+2);
		*/
		
		//hole for the drive shaft
		translate([width/2, length+1, 20])
			rotate([90, 0, 0])
				cylinder(r=3, h=length+2);
		//nut for the drive shaft
		translate([width/2, 4, 20])
			rotate([90, 90, 0])
				scale([8, 8, 0])
					dxf_linear_extrude("nut.dxf", 4);
				
		//hole for the wire
		translate([-1, length/2, height-wall])
			rotate([90, 0, 90])
				#cylinder(r=1, h=width+2);
				
	}
}

//track(true);
track();
translate([5, -5, 5])
	carriage();
