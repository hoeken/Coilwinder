module nema_17_mount(dxf = false)
{
	$fs = 0.1;

	wall = 5;
	motor_width = 42;
	frame_width = motor_width + (wall + 1)*2;
	realBolt = 3;
	bolt = 4;
	height = 25;
	
	//these are all the mount point holes.
	x1 = -wall;
	y1 = wall*2;
	x2 = frame_width+wall;
	y2 = wall*2;
	x3 = -wall;
	y3 = frame_width-wall*2;
	x4 = frame_width + wall;
	y4 = frame_width-wall*2;
	
	if (dxf)
	{
		difference()
		{
			union()
			{
				translate([-wall*2, 0, 0])
					square([frame_width+wall*4, frame_width]);
			}
			
			translate([x1, y1])
				#circle(r=realBolt/2, center=true);
			translate([x2, y2])
				#circle(r=realBolt/2, center=true);
			translate([x3, y3])
				#circle(r=realBolt/2, center=true);
			translate([x4, y4])
				#circle(r=realBolt/2, center=true);
			}
	}
	else
	{	
		//center the whole thing in X
		difference()
		{
			//build the main unit.
			union()
			{
				//structure
				cube([wall, frame_width, frame_width]); //front face
				cube([frame_width, wall, frame_width]); //left face
				translate([frame_width-wall, 0, 0])     //right face
					cube([wall, frame_width, frame_width]);

				//front left sphere
				translate([0, wall*2, 0])
					translate([0,0,wall/2])
						sphere(r=wall*2);
			
				//front right sphere
				translate([frame_width, wall*2, 0])
					translate([0,0, wall/2])
						sphere(r=wall*2);

				//back left sphere
				translate([0, frame_width-wall*2, 0])
					translate([0,0, wall/2])
						sphere(r=wall*2);

				//back right sphere
				translate([frame_width, frame_width-wall*2, 0])
					translate([0,0, wall/2])
						sphere(r=wall*2);
			}


			//front left mount hole
			echo(x1, y1);
			translate([x1, y1, 0])
			{
				cylinder(r=bolt/2, h=wall);
				translate([0,0,wall])
					cylinder(r=bolt, h=wall*2);
			}
		
			//front right mount hole
			echo(x2, y2);
			translate([x2, y2, 0])
			{
				cylinder(r=bolt/2, h=wall);
				translate([0,0,wall])
					cylinder(r=bolt, h=wall*2);			
			}
		
			//rear left mount hole
			echo(x3, y3);
			translate([x3, y3, 0])
			{
				cylinder(r=bolt/2, h=wall);
				translate([0,0,wall])
					cylinder(r=bolt, h=wall*2);
			}
		
			//rear right mount hole
			echo(x4, y4);
			translate([x4, y4, 0])
			{
				cylinder(r=bolt/2, h=wall);
				translate([0,0,wall])
					cylinder(r=bolt, h=wall*2);
			}
		
			//mount hole slits
			translate([frame_width + wall*1.5, frame_width-wall*2, wall/2])
				cube(size=[wall, 0.1, wall*3], center=true);
			translate([frame_width + wall*1.5, wall*2, wall/2])
				cube(size=[wall, 0.1, wall*3], center=true);
			translate([-wall*1.5, frame_width-wall*2, wall/2])
				cube(size=[wall, 0.1, wall*3], center=true);
			translate([-wall*1.5, wall*2, wall/2])
				cube(size=[wall, 0.1, wall*3], center=true);

			//nema 17 mount
			rotate([90, 0, 0])
			{
				translate([frame_width/2+0.5, height, -wall])
				{
					translate([15.5, 15.5, 0])
						cylinder(r=bolt/2, h=wall+1);
					translate([-15.5, 15.5, 0])
						cylinder(r=bolt/2, h=wall+1);
					translate([15.5, -15.5, 0])
						cylinder(r=bolt/2, h=wall+1);
					translate([-15.5, -15.5, 0])
						cylinder(r=bolt/2, h=wall+1);

					cylinder(r=11.5, h=wall+1);

					translate([-11.5, 0, 0])
						cube([23, frame_width, wall+1]);
				}
			}

			//back slant cutaway
			translate([0, 0, frame_width+wall])
				rotate([45, 0, 0])
					translate([-frame_width, 0, -frame_width*2])
						cube(size=[frame_width*4, frame_width*2, frame_width*4]);

			//cutout / tidy up cubes.
			translate([wall, wall-0.1, -1])
				cube([frame_width-wall*2, frame_width-wall, motor_width*2]);
			translate([-frame_width/2,-frame_width/2, wall+motor_width])
				cube([frame_width*2, frame_width*2, frame_width]);
			translate([-frame_width/2, -frame_width/2,-frame_width])
				cube([frame_width*2, frame_width*2, frame_width]);
		}
	}
}

nema_17_mount();
//nema_17_mount(true);
