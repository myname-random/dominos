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

//Sub Platform
cuboid( [20, 7, 1], chamfer = 0.5, edges = [BOTTOM+FRONT, BOTTOM+BACK, LEFT]) {

    // Wheels
    up(0.4) attach(BOTTOM, TOP) 
        xcopies(n = 4, spacing = 4)
            ycyl(d = 2.5, h = 8, rounding = 0.25);

    // Wedge
    down(0.55) left(5.5) xscale(0.35) 
        attach(LEFT, "face1") 
            rounded_prism(
                regular_ngon(n = 3, side = 11), 
                height = 4.1, 
                joint_top = 2, joint_bot = 0.2, 
                joint_sides = [2, 4, 4]
            );

    // Base Wedge for printing to avoid supports
    attach(BOTTOM, TOP)
        prismoid( size1 = [18.2, 2], size2 = [20, 6], h = 2.1);

    // Top Platform
    attach(TOP, BOTTOM) 
        cuboid( [20, 8, 1], chamfer = 0.5, edges = [BOTTOM+FRONT, BOTTOM+BACK, LEFT]) {

            // Boiler and stack
            down(1) attach(TOP, BOTTOM, align=LEFT) 
                xcyl(d = 8, h = 12, rounding = 2) {
                    down(0.45) attach(TOP, BOTTOM, align = LEFT, inset = 2)
                        zcyl(d = 2, h = 3, rounding1 = -0.8) 
                            attach(TOP, BOTTOM)
                                zcyl(d1 = 2, d2 = 4, h = 2, rounding2 = 0.5);
                    down(0.45) attach(TOP, BOTTOM, align = RIGHT, inset = 3)
                        zcyl(d = 1.5, h = 2, rounding2 = 0.5);
                }

            // Headlights
            down(0.5) fwd(3.5) attach(TOP, BOTTOM, align=LEFT)
                xcyl(d = 2, h = 2, rounding = 0.5);
            down(0.5) back(3.5) attach(TOP, BOTTOM, align=LEFT)
                xcyl(d = 2, h = 2, rounding = 0.5);

            // Cab
            attach(TOP, BOTTOM, align = RIGHT, inset = 1)
                diff()
                cuboid([9, 8, 12], edges=[TOP+FRONT, TOP+BACK], rounding = 1.5) {
                    // Cab Windows
                    tag("remove")
                    attach(RIGHT, RIGHT, align = BOTTOM, inside = true) 
                        cuboid([0.5, 6, 10], edges = [TOP+FRONT, TOP+BACK, BOTTOM+FRONT, BOTTOM+BACK], rounding = 0.5);
                    tag("remove")
                    attach(LEFT, LEFT, align = TOP, inside = true, inset = 2)
                        cuboid([0.5, 6, 2.5], edges = [TOP+FRONT, TOP+BACK, BOTTOM+FRONT, BOTTOM+BACK], rounding = 0.5);
                    tag("remove")
                    attach(FRONT, FRONT, align = TOP, inside = true, inset = 2)
                        cuboid([7, 0.5, 5], edges = [TOP+LEFT, TOP+RIGHT, BOTTOM+LEFT, BOTTOM+RIGHT], rounding = 0.5);
                    tag("remove")
                    attach(BACK, BACK, align = TOP, inside = true, inset = 2)
                        cuboid([7, 0.5, 5], edges = [TOP+LEFT, TOP+RIGHT, BOTTOM+LEFT, BOTTOM+RIGHT], rounding = 0.5);
                }
        }
}
