# Customizable Dominos - Domino Tile Tray

Dynamically generated domino tile tray with options for the domino size, row count, tile count, tile angle, and other spacing options. 

The OpenSCAD file can be used directly with all options exposed in the Customizer, or a selection of prebuilt STL or 3MF files are in the dist directory.

The following first explains all the options, and then provides some suggestions on optimizing the printing.

## Sizes

There are five different standard sizes for dominos:

| Name | Size (mm) |
| --- | --- |
| Mini | 30 x 14 x 5 |
| Standard | 48 x 24 x 6 |
| Professional | 50 x 25 x 10 |
| Jumbo | 50 x 25 x 13 |
| Tounament | 55 x 28 x 13 |

In the Customizer:

+ Adjust the margin to add padding to the standard sizes based on your preferences and printing needs.
+ To set a custom size, select Custom from the Size dropdown and the enter your custom size in the CustomSize field.

## Rows and Tiles

The following three settings work to control the size of what the tray should hold.  They change how the model will use the domino tile size provided.

_Rows_ specifies the number of rows for tiles.

_Tiles_ specifies the number of domino tiles to fit per row.

_Tile Orientation_ indicates whether you want the tiles to sit vertically or horizontally in the tray.

[!NOTE]
If you're unsure about the rest of the settings, generate a tray with 2 rows and 1 tile.  This will make a very small version that will let you test how the tile sits and how tile visibility is effected between rows. 

## Row Spacing

The following settings control how the rows are spaced to form the tray.

_Initial Depth Factor_ indicates how deep the tile sits in the row. This value is a percentage of tile size based on the Tile Orientation selected. This value should be high enough to comfortably hold the tile in the row, but not so large as to obscure the tiles value.

_Row Rise Factor_ indicates how high the next row should be raised up. This value is a percentage of tile size based on the Tile Orientation selected. This value should be adjusted to assist with visibility, but will increase the size and material requirements.

_Tile Tilt Angle_ indicates how far back the tile should lean in the row.

_Row Gap Factor_ indicates the minimum amount of space between two rows. This value is a percentage of tile size based on the Tile Orientation selected. If Rounding is disabled, this value will determine the space between each row. If Rounding is enabled, the space between each row will be extended to match the calculated value. If the rounding value requires more space, then this value will not have an effect. 

## Other Elements

_Minimum Floor_ ensures there is at least this value of space included below the tray rows. If the Row Rise Factor is greater than zero, then this value will likely only affect the first row.

_Rounding_ sets the radius of turns for the outer corners of the tray and the tops between each row. If Rounding is zero, then no rounding is applied to any part of the model. If Rounding is non-zero, then the radius for the two bottom turns in the row is set to 0.5mm.

## Tile Visibility

There are many ways to size a tray, but as with all things, there are tradeoffs. You can make the tiles very secure in the tray by setting a high depth factor, but the tiles will be hard to see. You can increase the tilt angle and the row gap to maximize visibility, but that may make the tiles easier for everyone else playing to see as well.

Some of these combinations will also increase the material requirements of the model, which may be an additional factor.

## Generated File Settings

The pre-made files come in flat and raised varieties for each of the predefined domino sizes.

The following values are the same for all trays:

| Setting | Value |
| --- | --- |
| Margin | 1 |
| Rows | 4 |
| Tiles | 4 |
| Tile Orientation | Horizontal |
| Minimum Floor | 2 |
| Rounding | 2 |
| Initial Depth Factor | 0.2 |

For the trays labeled "Flat", the following settings were used.

| Setting | Value |
| --- | --- |
| Row Rise Factor | 0 |
| Tile Tilt Angle | 25 |
| Row Gap Factor | 0.5 |

For the trays labeled "Raised", the following settings were used.

| Setting | Value |
| --- | --- |
| Row Rise Factor | 0.2 |
| Tile Tilt Angle | 15 |
| Row Gap Factor | 0.25 |

## Printing

### Filament

You can use any filament to print the trays. My recommendation is to consider how often you want to use them and how delicate your players are and choose something accordingly.  For example, if you have a Silk PLA you think would be beautiful but it breaks easily, then that may not be the best choice for a tray you plan to use often.

### Print Settings

The standard print settings that you prefer for your choosen filament will usually work fine.

If you see any irregularities around the perimeter, consider lowering your outer wall acceleration and/or jerk settings.

For the lightest weight, change the infill to Lightning and the infill percentage to 30%. This will result in a mostly hollow part with sufficient infill to produce a clean top surface. Increase the strength by increasing the bottom layer thickness to match the top layer thickness. Add an extra wall to further increase rigidity and strength.

For a more dense and weighty tray, use Gyroid infill at 30-50%.

[!NOTE]
When printing a small test, print times and speed may be constrained by the printer's minimum layer time. When printing a number of full size trays, the printer should be able to use it's full speed.

### Orientation

The models are designed to be printed on their side vertically. This enables the rounding edges to print in the XY plane.  If printed on its base, layer artifacts from the slicer accomodating the rounding and angled lines may be apparent.

## Related Models

The Customizable Dominos set includes the following components:

1. Domino Tiles Set - A configurable set of dominos with many options.
2. Domino Tile Tray - A tray for domino tiles with custom sizing and features.
3. Domino Tile Hub - A hub for playing Mexican Train and similar domino games.
4. Domino Train - A simple to print train token for playing Mexican Train.

Use some or all of the models to build a completely custom set or add extras to an existing set.

The models are all available on my GitHub page as well as a number of profiles on MakerWorld, Creality Cloud, etc.

## License

[Customizable Dominos](https://github.com/myname-random/dominos) © 2025 by [Morgan Conner](https://github.com/myname-random/) is licensed under [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)

![Creative Commons](https://mirrors.creativecommons.org/presskit/icons/cc.svg)![Attribution](https://mirrors.creativecommons.org/presskit/icons/by.svg)![NonCommercial](https://mirrors.creativecommons.org/presskit/icons/nc.svg)![ShareAlike](https://mirrors.creativecommons.org/presskit/icons/sa.svg)