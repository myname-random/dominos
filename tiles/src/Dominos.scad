////////////////////////////////////////////////////////////////////////////////
// Customizable Dominos - https://github.com/myname-random/dominos/
// Domino Tile Set
// © 2025 by Morgan Conner
// Licensed under CC BY-NC-SA 4.0
// To view a copy of this license, visit https://creativecommons.org/licenses/by-nc-sa/4.0/ 
// 
////////////////////////////////////////////////////////////////////////////////

// https://github.com/BelfrySCAD/BOSL2
include <BOSL2/std.scad>

/* [Standard] */

DominoSet = 6; // [6:Double Sixes, 9:Double Nines, 12:Double Twelves, 15:Double Fifteen, 18:Double Eighteen]
// Pips (i.e. dots), or numbers
Marking = 1; // [1:Pips, 2:Numerals]
// Standard domino sizes
Size = 2; // [0:Mini, 1:Standard, 2:Professional, 3:Jumbo, 4:Tournament, 5:Custom]
// Select Custom above and then provide your dimensions
CustomSize = [0,0,0]; //[1:1:100]
// Width of divider strip
DividerDiameter = 2.5; // [1:.5:4]
// Depth of Divider, Pips, and Numerals
cDepth = 1;

/* [Layout] */

// Optimizes layout for printing
Layout = 1; // [1:Simple, 2:Grid - Flat, 3:Grid - Horizontal, 4:Grid - Vertical]
// Printer bed size, only used if a Grid layout is selected
BedSize = [200,200]; // [100:1:800]
// Space between each tile
TileSpacer = 4;
// Space between each plate
PlateSpacer = 20;

/* [If Pips] */

// Divet is a small carve out. Hole is a half height hole for an insert.
PipType = 1; // [1:Divet, 2:Hole]
// Divets are rounded versions, Holes are square edged
PipShape = 1; // [1:Round, 2:Square, 3:Diamond]
// Space between pips as a percentage of pip size
PipSpacing = .2; //[.2:.01:1]
// Use the smallest size pip for all dominos
SamePipSize = false;
// Tile edge offset for pip area
PipEdgeMargin = 3;

/* [If Numerals] */

NumberFont = "Orbitron"; //font
NumberSize = 12; //[6:1:20]
NumberSet = 1; // [0:Plain, 1:Standard, 2:Zeroed, 3:Custom]

/* [If NumberSet is Custom] */

Number0 = "";
Number1 = "1";
Number2 = "2";
Number3 = "3";
Number4 = "4";
Number5 = "5";
Number6 = "6.";
Number7 = "7";
Number8 = "8";
Number9 = "9.";
Number10 = "10";
Number11 = "11";
Number12 = "12";
Number13 = "13";
Number14 = "14";
Number15 = "15";
Number16 = "16";
Number17 = "17";
Number18 = "18";

/* [Hidden] */
$fa=$preview?1:.4;
$fs=$preview?2:.4;
StandardSizes = [[30,14,5], [48, 24, 6], [50,25,10], [50,25,13], [55,28,13], CustomSize];
tileSize = StandardSizes[Size];
tileRounding = tileSize.z <= 5 ? 0.4 : tileSize.z <= 9 ? 1 : 2;
sideSize = [((tileSize.x - DividerDiameter - (PipEdgeMargin * 4)) / 2), (tileSize.y - (PipEdgeMargin * 2))];

pipMapping = [
[[false]],
[[false, true, false]],
[[true, false, false], [false, false, false], [false, false, true]],
[[true, false, false], [false, true, false], [false, false, true]],
[[true, false, true], [false, false, false], [true, false, true]],
[[true, false, true], [false, true, false], [true, false, true]],
[[true, false, true], [true, false, true], [true, false, true]],
[[true, false, true], [true, true, true], [true, false, true]],
[[true, true, true], [true, false, true], [true, true, true]],
[[true, true, true], [true, true, true], [true, true, true]],
[[true, true, true], [true, false, true], [true, false, true], [true, true, true]],
[[true, true, true], [true, true, true], [true, true, true], [true, true]],
[[true, true, true], [true, true, true], [true, true, true], [true, true, true]],
[[true, true, true, true], [true, true, true, true], [true, true, true, true], [true]],
[[true, true, true, true], [true, true, true, true], [true, true, true, true], [true, true]],
[[true, true, true, true], [true, true, true, true], [true, true, true, true], [true, true, true]],
[[true, true, true, true], [true, true, true, true], [true, true, true, true], [true, true, true, true]],
[[true, true, true, true], [true, true, true, true, true], [true, true, true, true], [true, true, true, true]],
[[true, true, true, true], [true, true, true, true, true], [true, true, true, true, true], [true, true, true, true]]
];

pipSizes = [
    for (n=[0:DominoSet]) 
        let (
            pips = (SamePipSize ? DominoSet : n), 
            rows = len(pipMapping[n]), 
            cols = max( [ for (i=[0:rows-1]) len(pipMapping[n][i]) ] ),
            vert = sideSize.x / (rows + ((rows - 1) * PipSpacing)),
            horiz = sideSize.y / (cols + ((cols - 1) * PipSpacing))
            )
        n > 0 ? floor(vert < horiz ? vert : horiz) : 0
];

basicNumerals = ["","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"];
standardNumerals = ["","1","2","3","4","5","6.","7","8","9.","10","11","12","13","14","15","16","17","18"];
zeroedNumerals = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18"];
customNumerals = [Number0, Number1, Number2, Number3, Number4, Number5, Number6, Number7, Number8, Number9, Number10, Number11, Number12, Number13, Number14, Number15, Number16, Number17, Number18];
numeralOptions = [basicNumerals, standardNumerals, zeroedNumerals, customNumerals];

// Finds the radius of a sphere with the given width at the specified depth.
function cutteR(width, depth) = ((((width/2)^2)/depth) + depth)/2;

//dominoTile(1,18);

dominoSet();

module dominoSet() {
    if (Layout == 1) {
        for (left = [0 : DominoSet]) for (right = [0 : left]) {
            fwd(left * (tileSize.y + TileSpacer))
            left(right * (tileSize.x + TileSpacer))
            dominoTile(left, right);
        }
    } else {
        tileList = [for (left = [0 : DominoSet]) for (right = [0 : left]) [left,right]];
        gridX_max = floor(BedSize.x / ((Layout == 4 ? tileSize.y : tileSize.x) + TileSpacer));
        gridY_max = floor(BedSize.y / ((Layout == 2 ? tileSize.y : tileSize.z) + TileSpacer));
        maxTiles = gridX_max * gridY_max;
        for (plate = [1 : ceil(len(tileList)/maxTiles)]) for (col = [1 : gridX_max]) for (row = [1 : gridY_max]) {
            tileID = ((plate - 1) * maxTiles) + ((col - 1) * gridY_max) + (row - 1);
            if (tileID < len(tileList)){
                left( 
                    ((plate - 1) * (BedSize.x + PlateSpacer)) 
                    + ((col - 1) * ((Layout == 4 ? tileSize.y : tileSize.x) + TileSpacer))
                    )
                fwd(
                    ((row - 1) * ((Layout == 2 ? tileSize.y : tileSize.z) + TileSpacer))
                    )
                rotate((Layout == 3 ? [90,0,0] : Layout == 4 ? [90,90,0] : [0,0,0]))
                dominoTile(tileList[tileID][0], tileList[tileID][1]);
            }
        }
    }
}

module dominoTile(left, right) {
    difference() {
        // Generate a blank tile
        blankTile();
        
        // Cut out the divider
        up((tileSize.z / 2) + (cutteR(DividerDiameter, cDepth) - cDepth))
            ycyl(l=tileSize.y, r=cutteR(DividerDiameter, cDepth));
        
        // Cut out the markings
        if (Marking == 1) {
            // Marking 1, Pips
            if (PipType == 1) {
                // Pip Type 1, Divet
                pipDivet(left);
                zrot(180) pipDivet(right);
            } else {
                // Pip Type 2, Cutout
                pipHole(left);
                zrot(180) pipHole(right);
            }
        } else {
            // Marking 2, Numerals
            numeral(left);
            zrot(180) numeral(right);
        }
    }
}

module blankTile() {
    clipAng = 50;
    clipSize = tileRounding -(tileRounding * cos(clipAng));
    half_of(
        v=(
            Layout == 4 
            ? RIGHT 
            : Layout == 3 
                ? FWD 
                : BOTTOM
        ),
        cp=(-(
            Layout == 4 
            ? tileSize.x 
            : Layout == 3 
                ? tileSize.y
                : tileSize.z
            )/2
        )
    )
    half_of(
        v=(
            Layout == 4 
            ? LEFT 
            : Layout == 3 
                ? BACK 
                : TOP
        ),
        cp=(-(
            Layout == 4 
            ? tileSize.x 
            : Layout == 3 
                ? tileSize.y
                : tileSize.z
            )/2
        )
    )
    cuboid(
        [
        tileSize.x + (Layout == 4 ? clipSize * 2: 0), 
        tileSize.y + (Layout == 3 ? clipSize * 2 : 0),
        tileSize.z + (Layout < 3 ? clipSize * 2 : 0)
        ],
        rounding=tileRounding
    );
}

module pipDivet(pips) {
    pipSize = pipSizes[pips];
    sphereR = cutteR(pipSize, cDepth);
    sphereD = sphereR * 2;
    pipMap = pipMapping[pips];
    rowCount = len(pipMap);
    rowSize = sideSize.x / ((rowCount * 2) - 1);
    for (row = [0 : rowCount - 1]) {
        colCount = len(pipMap[row]);
        rowOffset = row * rowSize * 2;
        colSize = sideSize.y / ((colCount * 2) - 1);
        for (col = [0 : colCount - 1]) {
            colOffset = col * colSize * 2;
            if(pipMap[row][col]) {
                if (PipShape == 1) {
                    left(sphereR + (DividerDiameter/2) + PipEdgeMargin + rowOffset + ((rowSize - sphereD) / 2))
                    back((sideSize.y / 2) - sphereR - colOffset - ((colSize-sphereD) / 2))
                    up(tileSize.z/2 + (sphereR - cDepth))
                        sphere(r=sphereR);
                } else if (PipShape == 2) {
                    left((pipSize/2) + (DividerDiameter/2) + PipEdgeMargin + rowOffset + ((rowSize - pipSize) / 2))
                    back((sideSize.y / 2) - (pipSize/2) - colOffset - ((colSize-pipSize) / 2))
                    up((tileSize.z - cDepth)/2)
                    zrot(45) regular_prism(n=4, side1=pipSize/2, side2=pipSize, rounding1=pipSize/4, rounding2=-pipSize/4, h=cDepth);
                } else {
                    // PipShape == 3
                    modPipSize = (pipSize/sqrt(2));
                    left((modPipSize/2) + (DividerDiameter/2) + PipEdgeMargin + rowOffset + ((rowSize - modPipSize) / 2))
                    back((sideSize.y / 2) - (modPipSize/2) - colOffset - ((colSize-modPipSize) / 2))
                    up((tileSize.z - cDepth)/2)
                    regular_prism(n=4, side1=modPipSize/2, side2=modPipSize, rounding1=modPipSize/4, rounding2=-modPipSize/4, h=cDepth);
                 }
            }
        }
    }
}

module pipHole(pips) {
    pipSize = pipSizes[pips];
    pipMap = pipMapping[pips];
    rowCount = len(pipMap);
    rowSize = sideSize.x / ((rowCount * 2) - 1);
    for (row = [0 : rowCount - 1]) {
        colCount = len(pipMap[row]);
        rowOffset = row * rowSize * 2;
        colSize = sideSize.y / ((colCount * 2) - 1);
        for (col = [0 : colCount - 1]) {
            colOffset = col * colSize * 2;
            if(pipMap[row][col]) {
                left((pipSize/2) + (DividerDiameter/2) + PipEdgeMargin + rowOffset + ((rowSize - pipSize) / 2))
                back((sideSize.y / 2) - (pipSize/2) - colOffset - ((colSize-pipSize) / 2))
                up(.001)
                    if (PipShape == 1) {
                        cylinder(d=pipSize, h=(tileSize.z/2));
                    } else if (PipShape == 2) { 
                        up(tileSize.z/4) zrot(45) regular_prism(n=4, side=pipSize, h=(tileSize.z/2));
                    } else {
                        // PipShape == 3
                        up(tileSize.z/4) regular_prism(n=4, side=(pipSize/sqrt(2)), h=(tileSize.z/2));
                    }
            }
        }
    }
}

module numeral(num) {
    up(tileSize.z/2)
    left(tileSize.y/2)
    text3d(numeralOptions[NumberSet][num], cDepth, NumberSize, NumberFont, center=true, spin=-90 );
}
