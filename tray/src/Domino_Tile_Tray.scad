////////////////////////////////////////////////////////////////////////////////
// Customizable Dominos - https://github.com/myname-random/dominos/
// Domino Tile Tray
// © 2025 by Morgan Conner
// Licensed under CC BY-NC-SA 4.0
// To view a copy of this license, visit https://creativecommons.org/licenses/by-nc-sa/4.0/ 
// 
////////////////////////////////////////////////////////////////////////////////

// https://github.com/BelfrySCAD/BOSL2
include <BOSL2/std.scad>

/* [Standard] */

DominoSize = 2; // [0:Mini, 1:Standard, 2:Professional, 3:Jumbo, 4:Tournament, 5:Custom]

// Pad tile size by this amount
Margin = 1; // [0:0.5:5]

// Number of rows on the tray
Rows = 4; // [1:1:10]

// Number of tiles to fit per row
Tiles = 4; // [1:1:10]

// Orient tiles vertically or horizontally
Tile_Orientation = 0; // [0:Horizontal, 1:Vertical]

// As a percentage of the oriented tile
Initial_Depth_Factor = 0.2; // [0.01:0.005:0.5]

// As a percentage of the oriented tile
Row_Rise_Factor = 0.2; // [0:0.01:0.5]

// Angle of the tile in the trough
Tile_Tilt_Angle = 15; // [0:1:35]

// Ensures a minimum thickness for the base
Minimum_Floor = 2; // [0:1:5]

// Ensures at least this distance between the rows, as a percentage of the oriented tile
Row_Gap_Factor = 0.25; // [0:0.01:0.8]

// Rounds top edges with this radius, 0 to disable
Rounding = 2; // [0:0.1:5]

// Select Custom above and then provide your dimensions
CustomDominoSize = [0,0,0]; //[1:1:100]


/* [Hidden] */
$fa=$preview?1:.4;
$fs=$preview?2:.4;
StandardSizes=[[30,14,5], [48, 24, 6], [50,25,10], [50,25,13], [55,28,13], CustomDominoSize];
tileSize=StandardSizes[DominoSize] + [Margin, Margin, Margin];
halfTilt = Tile_Tilt_Angle / 2;
smallR = Rounding == 0 ? 0 : 0.5;
angledTileOffset = Tile_Tilt_Angle > 0 ? hyp_ang_to_opp(tileSize.z, Tile_Tilt_Angle) : 0;
drop = (Tile_Orientation == 0 ? tileSize.y : tileSize.x) * Initial_Depth_Factor;
rise = (Tile_Orientation == 0 ? tileSize.y : tileSize.x) * Row_Rise_Factor;
shelf = max(((Tile_Orientation == 0 ? tileSize.y : tileSize.x) * Row_Gap_Factor) - (Rounding * 2), 0);

wStart = [
    "untilx", max(Minimum_Floor, Rounding) + drop + angledTileOffset,
    "arcrightto", Rounding, -90,
    "move", shelf
    ];

wEnd = [
    "arcrightto", Rounding, -180,
    "untilx", Rounding,
    "arcrightto", Rounding, -270,
    "untily", -Rounding,
    "arcrightto", Rounding, 0
];

function rowBuilder(row) = [
    "arcrightto", Rounding, -180,
    "untilx", max(Minimum_Floor, Rounding) + angledTileOffset + smallR + (rise * (row - 1)), 
    "arcleftto", smallR, -90 - Tile_Tilt_Angle,
    "move", tileSize.z - (smallR * 2),
    "arcleftto", smallR, -Tile_Tilt_Angle,
    "untilx", max(Minimum_Floor, Rounding) + drop + (rise * row) + angledTileOffset,
    "arcrightto", Rounding, -90,
    "move", shelf
];

turtleLists = [wStart, for(r=[1:Rows]) rowBuilder(r), wEnd];
        
linear_extrude((Tile_Orientation == 0 ? tileSize.x : tileSize.y) * Tiles) region(fill(turtle(flatten(turtleLists))));

