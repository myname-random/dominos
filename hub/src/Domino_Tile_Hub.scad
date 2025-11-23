////////////////////////////////////////////////////////////////////////////////
// Customizable Dominos - https://github.com/myname-random/dominos/
// Domino Tile Hub
// © 2025 by Morgan Conner
// Licensed under CC BY-NC-SA 4.0
// To view a copy of this license, visit https://creativecommons.org/licenses/by-nc-sa/4.0/ 
// 
////////////////////////////////////////////////////////////////////////////////

// https://github.com/BelfrySCAD/BOSL2
include <BOSL2/std.scad>

/* [Standard] */
DominoSize = 2; // [0:Mini, 1:Standard, 2:Professional, 3:Jumbo, 4:Tournament, 5:Custom]

Margin = 1; // [0:0.5:5]

Layout = 1; // [0:Compact, 1:Standard, 2:Large, 3:Custom]

RaisedCenter = true;

// Select Custom above and then provide your dimensions
CustomDominoSize = [0,0,0]; //[1:1:100]

CustomHeight = 2; // [1:1:20]
CustomSpace = 5; // [1:1:50]
CustomIndent = 5; // [1:1:50]

/* [Hidden] */
$fa=$preview?1:.4;
$fs=$preview?2:.4;
StandardSizes=[[30,14,5], [48, 24, 6], [50,25,10], [50,25,13], [55,28,13], CustomDominoSize];
tileSize=[StandardSizes[DominoSize].x + Margin, StandardSizes[DominoSize].y + Margin, StandardSizes[DominoSize].z];
spacer= Layout == 0
    ? tileSize.y / 2
    : Layout == 1
    ? tileSize.y 
    : Layout == 2
    ? tileSize.y * 1.5
    : CustomSpace;

tHeight = Layout == 0
    ? 1
    : Layout == 1
    ? tileSize.z / 4
    : Layout == 2
    ? tileSize.z / 3
    : CustomHeight;
    
indent = Layout == 3 ? CustomIndent : Layout < 2 ? tileSize.x/8 : tileSize.x/6;

linear_extrude(height=tHeight, center=true) {
    difference() {
        octagon(id=tileSize.x + (2 * spacer) + indent, rounding=2);
        if (!RaisedCenter) zrot(22.5) rect([tileSize.x, tileSize.y], rounding=1);
        zrot_copies(n=8, sa=22.5)
        right((tileSize.x / 2) + spacer + .01) 
            rect(
                [indent, tileSize.y],
                rounding=[-2,1,1,-2],
                corner_flip=[true,false,false,true]
            );
    }
}

if (RaisedCenter) {
    zrot(22.5) up(tHeight) 
        linear_extrude(height=tHeight, center=true)
            difference() {
                rect([tileSize.x+indent, tileSize.y+indent], rounding=2);
                rect([tileSize.x, tileSize.y], rounding=1);
            }
}
