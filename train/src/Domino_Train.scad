////////////////////////////////////////////////////////////////////////////////
// Customizable Dominos - https://github.com/myname-random/dominos/
// Mexican Train Token
// © 2025 by Morgan Conner
// Licensed under CC BY-NC-SA 4.0
// To view a copy of this license, visit https://creativecommons.org/licenses/by-nc-sa/4.0/ 
// 
////////////////////////////////////////////////////////////////////////////////

// https://github.com/BelfrySCAD/BOSL2
include <BOSL2/std.scad>

$fa=$preview?1:.4;
$fs=$preview?2:.4;

//Bottom Plate
cuboid( [20, 7, 1], chamfer = 0.5, edges = [BOTTOM+FRONT, BOTTOM+BACK, LEFT]) {
    // Central support to avoid slicer supports
    attach(BOTTOM, TOP)
        prismoid( size1 = [15, 2], size2 = [20, 6], h = 2.1) {

            // Wheels
            xcopies(n=4, l=14) attach(BOTTOM, BOTTOM, inside=true) 
                left(.2) yrot(9) ycyl(d = 2.5, h = 8, rounding = 0.25)
                    attach(CENTER, CENTER, inside=true)
                        ycyl(d=0.5, h=8.4, rounding=0.25);
    }

    // Pilot
    down(0.55) right(1) 
        attach(LEFT, "face1")
            zscale(0.35) 
            rounded_prism(
                regular_ngon(n = 3, side = 11), 
                height = 4.1, 
                joint_top = 2, joint_bot = 0.2, 
                joint_sides = [2, 4, 4]
            );

    // Top Plate
    attach(TOP, BOTTOM) 
        cuboid( [20, 8, 1], chamfer = 0.5, edges = [BOTTOM+FRONT, BOTTOM+BACK, LEFT]) {

            // Boiler
            down(1) attach(TOP, BOTTOM, align=LEFT) 
                xcyl(d = 7, h = 14, rounding = 1) {
                    // Smokebox door
                    attach(LEFT, RIGHT) xcyl( d = 3, h = 0.3, rounding = 0.15);
                    // Smokestack
                    down(0.8) attach(TOP, BOTTOM, align = LEFT, inset = 2)
                        zcyl(d = 3, h = 3, rounding1 = -0.5) 
                            attach(TOP, BOTTOM)
                                zcyl(d1 = 3, d2 = 5, h = 3, rounding2 = 0.8);
                    // Safety valve
                    down(0.45) attach(TOP, BOTTOM, align = RIGHT, inset = 3)
                        zcyl(d = 3, h = 2, rounding2 = 1);
                        
                    // Accents
                    back(.2) attach(FRONT, BACK) xcyl( d = .4, h = 12, rounding = 0.1);
                    fwd(.2) attach(BACK, FRONT) xcyl( d = .4, h = 12, rounding = 0.1);
                }

            // Headlights
            down(0.5) fwd(3.5) attach(TOP, BOTTOM, align=LEFT)
                xcyl(d = 2, h = 2, rounding = 0.5);
            down(0.5) back(3.5) attach(TOP, BOTTOM, align=LEFT)
                xcyl(d = 2, h = 2, rounding = 0.5);

            // Cab
            attach(TOP, BOTTOM, align = RIGHT, inset = 1)
                diff()
                cuboid([7, 8, 12], edges=[TOP+FRONT, TOP+BACK], rounding = 1.5) {
                    // Cab Windows
                    tag("remove")
                    attach(RIGHT, RIGHT, align = BOTTOM, inside = true) 
                        cuboid([0.8, 6, 10], edges = [TOP+FRONT, TOP+BACK, BOTTOM+FRONT, BOTTOM+BACK], rounding = 0.5);
                    tag("remove")
                    attach(LEFT, LEFT, align = TOP, inside = true, inset = 2)
                        cuboid([0.8, 6, 2.5], edges = [TOP+FRONT, TOP+BACK, BOTTOM+FRONT, BOTTOM+BACK], rounding = 0.5);
                    tag("remove")
                    attach(FRONT, FRONT, align = TOP, inside = true, inset = 2)
                        cuboid([5, 0.8, 5], edges = [TOP+LEFT, TOP+RIGHT, BOTTOM+LEFT, BOTTOM+RIGHT], rounding = 0.5);
                    tag("remove")
                    attach(BACK, BACK, align = TOP, inside = true, inset = 2)
                        cuboid([5, 0.8, 5], edges = [TOP+LEFT, TOP+RIGHT, BOTTOM+LEFT, BOTTOM+RIGHT], rounding = 0.5);
                }
        }
}
