
/* [Main] */

// First head kind ("example" show them all but is not printable)
gopro_primary_kind="triple"; // [example1,example2,triple,double]
// Sedond head kind (only for the triple or double primary kind)
gopro_secondary_kind="tripod_small"; // [double,triple,rod,clamp,tripod_small,tripod_large,plate,none]
// If you rotate the seconday head you will probably need to enable support to print it
gopro_secondary_rotation=0; // [0:180]

// Optional, possibly bent axis-to-axis extension rod (length cannot be less than 21mm).
gopro_ext_len=50;
// Thickness of the extension rod walls (2 to 6mm are good values)
gopro_ext_th=2;
// Angle at the base of the extension
gopro_ext_bend_angle=50; // [0:90]
// Twist at the base of the extension
gopro_ext_twist=0; // [0:180]

// How thick are the mount walls
gopro_wall_th= 3;

/* [Rod and captive nut] */

// This tab is useful only if you have selected "rod" as the secondary head. Optional rod diameter (also the captive nut internal diameter)
gopro_captive_rod_id= 3.8;
// Angle the rod makes with the axis (0 is colinear, 90 is a right angle)
gopro_captive_rod_angle= 45; // [0:90]
// Optional captive nut thickness with freeplay (tightest would be 3.2)
gopro_rod_nut_th= 3.6;
// Optional captive nut diameter with freeplay (from corner to corner)
gopro_rod_nut_od= 8.05;

/* [Clamp/bar mount] */

// This tab is useful only if you have selected "clamp" as the secondary head.  Optional (handle)bar diameter
gopro_bar_rod_d= 35;
// How thick is the ring around the bar
gopro_bar_th= 4;
// How big is the gap between the jaws
gopro_bar_gap= 2;
// Bar screw diameter
gopro_bar_screw_d= 3;
// Diameter of the head of the screw
gopro_bar_screw_head_d= 6.4;
// Diameter of the nut of the screw from corner to corner (can be zero)
gopro_bar_screw_nut_d= 6.25;
// How thick are the shoulders on which to bolt (each side)
gopro_bar_screw_shoulder_th=5;
// Whether to reverse the bolt orientation (from which side you will screw the bolt, defaut is from the joint)
gopro_bar_screw_reversed=0; // [0:false, 1:true]

/* [Baseplate] */

// This tab is useful only if you have selected "plate" as the secondary head. Increase gopro_wall_th for sturdier shape. Plate main length:
plate_len=40;
// Width of the plate, or zero for the exact arm section (it makes the shape easier to print, but a possibly unstable base)
plate_width=0;
// Diameter of the plate screws
plate_screw_d=3.1;
// Distance from screws to the exterior of the baseplate (ie. relative to plate_len)
plate_screw_margin_outer=5;
// Space betwen optional pairs of screws. Zero to have only one screw on each side.
plate_screw_pair_spacing=0;
// Make the screw pairs into slots (needs positive plate_screw_pair_spacing). Useful for straps, for example.
plate_strap_slot=0; // [0:false, 1:true]
// Gap to leave for a strap be be sled between the plate and the rest of the shape (makes it harder to print).
plate_strap_gap=0;

/* [Hidden] */

// The gopro connector itself (you most probably do not want to change this but for the first two)

// The locking nut on the gopro mount triple arm mount (keep it tight)
gopro_nut_d= 9.2;
// How deep is this nut embossing (keep it small to avoid over-overhangs)
gopro_nut_h= 2;
// Hole diameter for the two-arm mount part
gopro_holed_two= 5.2;
// Hole diameter for the three-arm mount part
gopro_holed_three= 5.5;
// Thickness of the internal arm in the 3-arm mount part
gopro_connector_th3_middle= 3.2;
// Thickness of the side arms in the 3-arm mount part
gopro_connector_th3_side= 2.75;
// Thickness of the arms in the 2-arm mount part
gopro_connector_th2= 2.85;
// The gap in the 3-arm mount part for the two-arm
gopro_connector_gap= 2.95;
// How round are the 2 and 3-arm parts
gopro_connector_roundness= 1;

// Hole diameter for small tripod mount screws (tight-fit)
tripod_small_d=5.5;
// Hole diameter for large tripod mount screws (tight-fit)
tripod_large_d=8.4;
// Tripod base height
tripod_screw_depth=12;
// Tripod base diameter
tripod_base_d=25;

// These two settings only helps against geometrical issues (non-manifold), do not change !
gopro_connector_wall_tol=0.5+0;
gopro_tol=0.04+0;

// Can be queried from the outside
gopro_connector_z= 2*gopro_connector_th3_side+gopro_connector_th3_middle+2*gopro_connector_gap;
gopro_connector_x= gopro_connector_z;
gopro_connector_y= gopro_connector_z/2+gopro_wall_th;

///////////////////////////////////////////////////////////////////////
//
// GoPro Hero mount and joint (gopro_mounts_mooncactus.scad) - Rev 1.1
//
///////////////////////////////////////////////////////////////////////
//
// CC-BY-NC 2013 jeremie.francois@gmail.com
// https://www.linkedin.com/in/jeremiefrancois/
// https://www.thingiverse.com/thing:62800
// https://www.tridimake.com

// It slices neatly with the following parameters
//
// 0.1 mm layers (for better look & more compact FDM) -- 0.15 is still OK (and faster)
// 0.8 mm walls (loops->infill->perimeters)
// 0.8 mm bottom/top
// 100% fill (probably safer, though 30% is quite OK)
// Better use PETG instead of PLA for heat resistance.
//
// Rev 1.3: added tripod and base plate end shapes
// Rev 1.2: added vertical angle option for extension, free head rotation and rounded baseplate when needed
// Rev 1.1: added horizontal angle option for extension
// Rev 1.03: examples and first release (20130317-1234)
// Rev 1.02: added handle/bar mount and rounded the angles of the rod mount
// Rev 1.01: fixed printing angle vs captive nut slot, added a slight freeplay

/* ****************************************************************

HOW TO USE IN YOUR OWN DESIGNS

use <gopro_mounts_mooncactus.scad>

// Create a "triple" gopro connector
gopro_connector("triple");

// Create a "triple" gopro connector without the locking nut shape
translate([30,0,0])
	gopro_connector("triple", withnut=false);

// Create a "double" gopro connector
translate([60,0,0])
	gopro_connector("double");

// Add a bar mount/clamp to one of the connector
translate([90,0,0])
gopro_bar_clamp(
	rod_d= 31, // rod diameter
	th= 3.2, // main thickness
	gap= 2.4, // space between the clamps
	screw_d= 3, // screw diameter
	screw_head_d= 6.2, // screw head diameter
	screw_nut_d= 6.01, // nut diameter from corner to corner
	screw_shoulder_th=4.5, // thickness of the shoulder on which the nut clamps
	screw_reversed=false	 // true to mirror the orientation of the clamp bolts
);

// Extends a connector with a mount for a rod and an optional embedded nut
translate([120,0,0])
gopro_rod_connect(
	rod_id=3.8, // rod diameter
	angle=80,  // rod angle (0 is straight, 90 is a right turn)
	nut_th=3.2, // embedded nut thickness (can be zero to disable the embedded nut)
	nut_od=7.9 // nut diameter from corner to corner
);

// How to build a linear extruded bar extender
translate([0,65,0])
{
	gopro_connector("double");
	gopro_extended(len=50, th=3)
		scale([1,-1,1])
				gopro_connector("triple");
}

// The following dimensions are useful to attach the mount to your design:
	gopro_connector_z= 14.7;
	gopro_connector_x= 14.7;
	gopro_connector_y= 10.35;


// Finally, note that the arm are designed in a way which is not the best orientation to print: you would better rotate them with, eg. rotate([0,90,0])

**************************************************************** */



// To generate the sample set in bash, just copy/paste the following in a terminal:
/*
for kind in double triple; do
	for angle in 30 80; do
		through=true
		[[ $angle == 0 ]] && through=false
		openscad -D print_it=true -D gopro_primary_kind="\"$kind\"" -D gopro_captive_rod_angle=$angle -o gmb_${kind}_${angle}.stl gopro_mount_bit.scad
	done
	openscad -D print_it=true -D gopro_primary_kind="\"$kind\"" -D gopro_rod_nut_th=0 -o gmb_${kind}_simple.stl gopro_mount_bit.scad
done
*/

module gopro_more()
{
	for(i=[0:$children-1])
		translate([0,-2*gopro_connector_y,0]) children(i);
}
module gopro_reverse()
{
	for(i=[0:$children-1])
		scale([1,-1,1]) children(i);
}

//
// ================ Full (colored) example (for openscad & command line)
//
gopro_ext_len_real= (gopro_ext_len > 2*gopro_connector_y ? gopro_ext_len : 0);
if(gopro_primary_kind=="example1")
{
	gopro_connector("triple", withnut=true);

	color([1,0.2,0.2])
		gopro_bar_clamp(
			rod_d= gopro_bar_rod_d, th=gopro_bar_th, gap=gopro_bar_gap,
			screw_d= gopro_bar_screw_d, screw_head_d= gopro_bar_screw_head_d, screw_nut_d= gopro_bar_screw_nut_d, screw_shoulder_th= gopro_bar_screw_shoulder_th,
			screw_reversed= gopro_bar_screw_reversed	);

			
	rotate([0,180,130]) color([0.2,0.2,1])
		gopro_connector("double");
		
	rotate([0,180,130]) color([0,0.8,0])
		gopro_rod_connect(nut_th=gopro_rod_nut_th, nut_od=gopro_rod_nut_od, rod_id=gopro_captive_rod_id, angle=gopro_captive_rod_angle);

}
else if(gopro_primary_kind=="example2")
{
	color([0.6,0.6,0.6])
	{
		rotate([0,90,0]) gopro_connector("triple");
		gopro_extended_elbow(bend=60, th=gopro_ext_th)
			gopro_extended(len=gopro_ext_len, th=gopro_ext_th)
			{
				//gopro_reverse() gopro_connector("triple");
				// or (eg.)
				gopro_more()
					gopro_bar_clamp(rod_d= gopro_bar_rod_d, th= gopro_bar_th, gap= 5, screw_d= gopro_bar_screw_d, screw_head_d= gopro_bar_screw_head_d, screw_nut_d= gopro_bar_screw_nut_d, screw_shoulder_th=gopro_bar_screw_shoulder_th, screw_reversed=true, gap=2);	
			}
	}
}
else // useful blocks
{
	//
	// ================ Printable standalone blocks (for the customizer)
	//
	rotate([0,90,0])
	{
		if(gopro_primary_kind=="triple")
			gopro_connector("triple", withnut=true, rounded_baseplate=(gopro_ext_twist%90!=0));
		else
			gopro_connector("double", rounded_baseplate=(gopro_ext_twist%90!=0));

			gopro_extended_elbow(rotation=gopro_ext_twist, bend=gopro_ext_bend_angle, th=gopro_ext_th)
				gopro_extended(len=gopro_ext_len_real, th=gopro_ext_th)
					rotate([0,-90,0]) 

		translate([0,-gopro_connector_y*2,0])
		{
			rotate([0,gopro_secondary_rotation,0])
			if(gopro_secondary_kind=="double" || gopro_secondary_kind=="triple")
			{
				translate([0,gopro_connector_y*2,0])
					scale([1,-1,1])
				if(gopro_secondary_kind=="triple")
					gopro_connector("triple", withnut=true, rounded_baseplate=(gopro_secondary_rotation%90)!=0);
				else if(gopro_secondary_kind=="double")
					gopro_connector("double", rounded_baseplate=(gopro_secondary_rotation%90)!=0);
			}
			else if(gopro_secondary_kind=="rod" && gopro_captive_rod_id>0) // Optional captive nut
			{
				gopro_join_baseplate(rounded_baseplate= (gopro_secondary_rotation%90!=0));
				gopro_rod_connect(nut_th=gopro_rod_nut_th, nut_od=gopro_rod_nut_od, rod_id=gopro_captive_rod_id, angle=gopro_captive_rod_angle);
			}
			else if(gopro_secondary_kind=="tripod_small") // Tripod mount (small, usual diameter)
			{
				gopro_join_baseplate(rounded_baseplate= (gopro_secondary_rotation%90!=0));
				gopro_tripod_connect(screw_d=tripod_small_d);  // 1/4"
			}
			else if(gopro_secondary_kind=="tripod_large") // Tripod mount (large diameter)
			{
				gopro_join_baseplate(rounded_baseplate= (gopro_secondary_rotation%90!=0));
				gopro_tripod_connect(screw_d=tripod_large_d);  // 3/8"
			}
			else if(gopro_secondary_kind=="plate")
			{
				gopro_join_baseplate(rounded_baseplate= (gopro_secondary_rotation%90!=0));
				gopro_plate_connect();
			}
			else if(gopro_secondary_kind=="clamp" && gopro_bar_rod_d>0) // Optional bar mount (can't be both!)
			{
				gopro_join_baseplate(rounded_baseplate= (gopro_secondary_rotation%90!=0));
				rotate([0,90,0])
					gopro_bar_clamp(
						rod_d= gopro_bar_rod_d,
						th= gopro_bar_th,
						gap= gopro_bar_gap,
						screw_d= gopro_bar_screw_d,
						screw_head_d= gopro_bar_screw_head_d,
						screw_nut_d= gopro_bar_screw_nut_d,
						screw_shoulder_th= gopro_bar_screw_shoulder_th,
						screw_reversed= gopro_bar_screw_reversed
					);
			}
		}
	}
}



//
// ============================= GOPRO CONNECTOR =============================
//

module gopro_torus(r,rnd)
{
	translate([0,0,rnd/2])
		rotate_extrude(convexity= 10)
			translate([r-rnd/2, 0, 0])
				circle(r= rnd/2, $fs=0.2);
}

module gopro_rcyl(r,h, center, rnd=1)
{
	translate([0,0,center ? -h/2 : 0])
	hull() {
		translate([0,0,0]) gopro_torus(r=r, rnd=rnd);
		translate([0,0,h-rnd]) gopro_torus(r=r, rnd=rnd);
	}
}

module gopro_join_baseplate(rounded_baseplate=false)
{
	// add the common start/stop base plate
	translate([0,gopro_connector_z/2+gopro_wall_th/2+gopro_connector_wall_tol,0])
	{
		if(!rounded_baseplate)
			cube([gopro_connector_z,gopro_wall_th,gopro_connector_z], center=true);
		else
			rotate([90,0,0]) cylinder(d=sqrt(2)*gopro_connector_z,h=gopro_wall_th, center=true);
	}
}

module gopro_connector(version="double", withnut=true, captive_nut_th=0, captive_nut_od=0, captive_rod_id=0, captive_nut_angle=0, rounded_baseplate=false)
{
	module gopro_profile(th)
	{
		hull()
		{
			gopro_torus(r=gopro_connector_z/2, rnd=gopro_connector_roundness);
			translate([0,0,th-gopro_connector_roundness])
				gopro_torus(r=gopro_connector_z/2, rnd=gopro_connector_roundness);
			translate([-gopro_connector_z/2,gopro_connector_z/2,0])
				cube([gopro_connector_z,gopro_wall_th,th]);
		}
	}
	difference()
	{
		union()
		{
			if(version=="double")
			{
				for(mz=[-1:2:+1]) scale([1,1,mz])
						translate([0,0,gopro_connector_th3_middle/2 + (gopro_connector_gap-gopro_connector_th2)/2]) gopro_profile(gopro_connector_th2);
			}
			if(version=="triple")
			{
				translate([0,0,-gopro_connector_th3_middle/2]) gopro_profile(gopro_connector_th3_middle);
				for(mz=[-1:2:+1]) scale([1,1,mz])
					translate([0,0,gopro_connector_th3_middle/2 + gopro_connector_gap]) gopro_profile(gopro_connector_th3_side);
			}

			gopro_join_baseplate(rounded_baseplate);

			// add the optional nut emboss
			if(version=="triple" && withnut)
			{
				translate([0,0,gopro_connector_z/2-gopro_tol])
				difference()
				{
					cylinder(r1=gopro_connector_z/2-gopro_connector_roundness/2, r2=11.5/2, h=gopro_nut_h+gopro_tol);
					cylinder(r=gopro_nut_d/2, h=gopro_connector_z/2+3.5+gopro_tol, $fn=6);
				}
			}
		}
		// remove the axis
		translate([0,0,-gopro_tol])
			cylinder(r=(version=="double" ? gopro_holed_two : gopro_holed_three)/2, h=gopro_connector_z+4*gopro_tol, center=true, $fs=1);
	}
}

//
// ============================= CAPTIVE NUT/ROD =============================
//

module gopro_rod_connect(nut_od=0, rod_id, nut_th=0, angle=0)
{
	if( (nut_th>0 && nut_od>0) || rod_id>0 )
	translate([0,gopro_connector_z,0])
	{
		// Main body mass
		difference()
		{
			hull()
			{
				translate([0,-gopro_connector_z/2+gopro_wall_th,0]) // attachment
					cube([gopro_connector_z,gopro_tol,gopro_connector_z], center=true);

				// main cylinder
				translate([gopro_connector_z/8,gopro_connector_z/4,0]) scale([0.75,0.5,1]) // optional
				gopro_rcyl(r=gopro_connector_z/2, h=gopro_connector_z, center=true, rnd=3);

				// nozzle
				rotate([0,0,angle])
					translate([0,gopro_connector_z/2-gopro_tol,0])
						rotate([-90,0,0])
								translate([0,0,-1.5]) gopro_torus(r=gopro_connector_z/2, rnd=1.5);
			}

			// Captive nut slot
			if(nut_th>0 && nut_od>0)
			{
				translate([0,0,0])
					rotate([0,(angle<18)?180:0,angle]) // easier print only for small angles
						hull()
				{
					rotate([-90,0,0]) cylinder(r=nut_od/2, h=nut_th+2*gopro_tol, $fn=6, center=true);
					translate([gopro_connector_z,0,0])
						rotate([-90,0,0]) cylinder(r=nut_od/2, h=nut_th+2*gopro_tol, $fn=6, center=true);
				}
			}

			// Carve the rod void
			if(rod_id>0)
			{
				rotate([0,0,angle])
				{
					if(angle>=80 || angle<=-80)
						rotate([-90,30,0])
							cylinder(r=rod_id/2, h=gopro_connector_z+2*gopro_tol, $fs=0.2, center=true);
					else
						translate([0,gopro_wall_th+gopro_tol*2-nut_th/2,0])
							rotate([-90,30,0])
								cylinder(r=rod_id/2, h=gopro_connector_z/2+gopro_tol, $fs=0.2);
				}
			}
		}
	}
}

//
// ============================= TRIPOD MOUNT =============================
//

module gopro_tripod_connect(screw_d)
{
	translate([0,gopro_connector_z/2+gopro_wall_th,0])
	{
		// Main body mass
		difference()
		{
			hull()
			{
				cube([gopro_connector_z,gopro_tol,gopro_connector_z], center=true);
				// nozzle
				translate([0,tripod_screw_depth,0])
					rotate([-90,0,0])
							translate([0,0,-1.5]) gopro_torus(r=tripod_base_d/2, rnd=1.5);
			}
			// Carve the screw
			translate([0,-gopro_tol,0])
				rotate([-90,30,0]) cylinder(r=screw_d/2, h=tripod_screw_depth + 2*gopro_tol, $fs=0.2);
			translate([0,tripod_screw_depth-1.5,0]) // chamfer
				rotate([-90,30,0]) cylinder(r1=screw_d/2, r2=screw_d/2+1, h=1.5 + 2*gopro_tol, $fs=0.2);
			for(r=[0:60:359])
				rotate([0,r,0])
					translate([tripod_base_d/2+4-2,0,0])
						scale([1,1,1.2])
						rotate([-90,30,0]) cylinder(d=8,h=100, $fs=0.5);
		}
	}
}

//
// ============================= BASIC PLATE MOUNT =============================
//

module gopro_plate_connect()
{
	module screws4()
	{
		for(dx=[-plate_screw_pair_spacing/2,plate_screw_pair_spacing/2])
			translate([dx,gopro_wall_th+plate_strap_gap,plate_len/2 - plate_screw_margin_outer])
				rotate([-90,0,0]) cylinder(d=plate_screw_d,h=gopro_wall_th+2*gopro_tol,center=true, $fs=0.5);
	}
	
	pw= (plate_width>0 ? plate_width : gopro_connector_z);
	translate([0,gopro_connector_z/2+gopro_wall_th/2,0])
	{
		difference()
		{
			union()
			{
				cube([gopro_connector_z,gopro_wall_th+gopro_tol,gopro_connector_z], center=true);
				translate([0,gopro_wall_th+plate_strap_gap,0]) // baseplate
					cube([pw, gopro_wall_th, plate_len], center=true);
				for(z=[-0.5,0.5]) scale([z,1,1])
				hull()
				{
					translate([gopro_connector_z-gopro_wall_th,0,0])
						cube([gopro_wall_th*2,gopro_wall_th,gopro_connector_z], center=true);
					translate([pw-gopro_wall_th,,gopro_wall_th+plate_strap_gap,0])
						cube([gopro_wall_th*2,gopro_wall_th,plate_len], center=true);
				}
			}
			for(dz=[-1,1]) scale([1,1,dz])
			{
				if(plate_strap_slot)
					hull() screws4();
				else
					screws4();
			}
		}
	}
}

//
// ============================= BAR CLAMP =============================
//

module gopro_bar_clamp(
	rod_d= 31,
	th= 3.2,
	gap= 2.4,
	screw_d= 3,
	screw_head_d= 6.2,
	screw_nut_d= 6.01,
	screw_shoulder_th=4.5,
	screw_reversed=1
	)
{
	module clamp_profile(r)
	{
		scale([r,r,1])
			translate([0,rod_d/2,0])
				cylinder(r=rod_d/2 + th,h=gopro_tol);
	}
	
	screw_x= rod_d/2+screw_head_d/2;
	translate([0,gopro_connector_z,0])
	difference()
	{
		hull()
		{
			translate([0,-gopro_connector_z/2+gopro_wall_th,0]) // attachment
				cube([gopro_connector_z,gopro_tol,gopro_connector_z], center=true);

			clamp_profile(1);
			for(m=[-1:2:+1]) scale([1,1,m])
				translate([0,0,-gopro_connector_z/2])
					clamp_profile((rod_d-0.8)/rod_d);

			// Shoulder screw support
			for(m=[-1:2:+1]) scale([m,1,1])
			{
				translate([screw_x,rod_d/2,gopro_tol/2])
					rotate([90,0,0])
						translate([0,0,-(gap+th*2)/2])
							cylinder(r=screw_head_d/2+0.78,h=gap+th*2);
			}
			
		}

		translate([0,rod_d/2,0])
		{
			// Main hole and gap
			translate([0,0,-gopro_tol-gopro_connector_z/2])
				cylinder(r=rod_d/2,h=gopro_connector_z+2*gopro_tol, $fs=1); // inner
				
			// Gap
			cube([screw_x*2 + screw_head_d*2, gap, gopro_connector_z+2*gopro_tol+1],center=true);

			// Screws
			for(mx=[-1:2:+1]) scale([mx,1,1])
			{
				translate([screw_x,0,0]) rotate([90,0,0])
				{
						translate([0,0,-rod_d/2-screw_shoulder_th]) cylinder(r=screw_d/2,h=rod_d+2*screw_shoulder_th,$fs=0.5); // screw axis
						if(screw_head_d>0)
							scale([1,1,screw_reversed?-1:1])
								translate([0,0,gap/2+screw_shoulder_th])
									cylinder(
										r1=screw_head_d/2,
										r2=1.5*screw_head_d/2,
										h=rod_d/2,$fs=0.5); // screw head
						if(screw_nut_d>0)
							scale([1,1,screw_reversed?1:-1])
								translate([0,0,gap/2+screw_shoulder_th])
									rotate([0,0,30])
										cylinder(
											r1=screw_nut_d/2,
											r2=1.5*screw_nut_d/2,
											h=rod_d/2,$fn=6); // screw nut
				}
			}

		}
	}
}

module gopro_extended_profile(th=3)
{
	for(r=[45:90:360]) rotate([0,0,r])
	{
		hull()
		{
			// corners
			translate([sqrt(2)*(gopro_connector_x/2-th/2),0,0])
			{
				intersection()
				{
					rotate([0,0,45]) square([th,th],center=true);
					circle(r=1.2*th/2,$fs=0.5);
				}
			}
			circle(r=th/2);
		}
	}
	// Internal roundness
	difference()
	{
		square([th*2,th*2],center=true);
		for(r=[0:90:360]) rotate([0,0,r])
			translate([0,th*sqrt(2)]) circle(r=th/2,$fs=0.5);
	}
}

module gopro_extended_elbow(rotation=0, bend=0, th=3)
{
	module pie_slice(radius, angle, step)
	{
		for(theta = [0:step:angle-step])
		{
			linear_extrude(height = radius*2, center=true)
				polygon( points = [[0,0],[radius * cos(theta+step) ,radius * sin(theta+step)],[radius*cos(theta),radius*sin(theta)]]);
		}
	}

	module partial_rotate_extrude(angle, radius, convexity)
	{
		intersection ()
		{
			rotate_extrude(convexity=convexity) translate([radius,0,0]) for(i=[0:$children-1]) children(i);
			pie_slice(radius*2, angle, angle/5);
		}
	}

	rotate([0,rotation+90,0])
		translate([-gopro_connector_x/2,gopro_connector_y,0])
		{
			if(bend>0)
				partial_rotate_extrude(angle=bend, radius=gopro_connector_x/2, convexity = 10)
					gopro_extended_profile(th);
			translate([cos(bend)*gopro_connector_x/2,sin(bend)*gopro_connector_x/2,0])
				rotate([0,0,bend])
					translate([0,-gopro_connector_y-gopro_tol,0])
						for(i=[0:$children-1]) children(i);
		}
}

module gopro_extended(len, th=3)
{
	linlen= max(len - 2*gopro_connector_y, 0);
	translate([0,gopro_connector_y,0])
	{
		if(linlen>0)
		{
			rotate([90,0,0])
				translate([0,0,-linlen/2])
					linear_extrude(height = linlen, center = true, convexity = 10)
						gopro_extended_profile(th);
		}
		translate([0,linlen+gopro_connector_y,0])
			for(i=[0:$children-1]) children(i);
	}
}

