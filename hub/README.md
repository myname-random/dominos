# Customizable Dominos - Domino Tile Hub

Dynamically generated domino hub with options for the layout and domino size.

The OpenSCAD file can be used directly with all options exposed in the Customizer, or prebuilt STL or 3MF files are in the dist directory.

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

## Layout

The model includes three variants of the hub layout: Compact, Standard, Large, and a Custom option.

Each variant impacts the spacing variables as shown in the table below based on the Domino Size selected. Select Custom for the Layout to use the related Customizer fields directly.

| Variable | Description | Compact Value | Standard Value | Large Value |
| :---: | :---: | :---: | :---: | :---: |
| Height | The height of the hub | 1 | Tile Height / 4 | Tile Height / 2 |
| Space | The space on either side of the tile | Tile Width / 2 | Tile Width | Tile Width * 1.5 |
| Indent | How far into the hub the tile rests | Tile Length / 8 | Tile Length / 6 | Tile Length / 6 |

### Raised Center

By default, the hub has a hole cut in the center for a domino tile.

If the Raised Center flag is set to true, then this hole is replaced. A frame with the Indent thickness and the same Height as the hub is added to the top. This holds the center domino slightly above the hub.

## Generated File Settings

There are generated STL and 3MF files for each size and layout.

For the Professional, Jumbo, and Tournament sizes, Raised Center is turned on for the Standard and Large layouts.

## Printing

### Filament

You can use any filament to print the hub. My recommendation is to consider how often you want to use it and how delicate your players are and choose something accordingly.  For example, if you have a Silk PLA you think would be beautiful but it breaks or scuffs easily, then that may not be the best choice if you plan to use it often.

### Print Settings

The standard print settings that you prefer for your choosen filament will usually work fine.

If you see any irregularities around the perimeter, consider lowering your outer wall acceleration and/or jerk settings.

For Mini or Standard sized dominos, and any size using the Compact layout, the hub will likely end up as a solid. For a hub with a larger height consider adjusting the infill percentage to achieve the desired weight and material usage of the completed object.

## Related Models

The Customizable Dominos set includes the following components:

1. Domino Tiles Set - A configurable set of dominos with many options.
2. Domino Tile Tray - A tray for domino tiles with custom sizing and features.
3. Domino Tile Hub - A hub for playing Mexican Train and similar domino games.
4. Domino Train - A simple to print train token for playing Mexican Train.

Use some or all of the models to build a completely custom set or add extras to an existing set.

The models are all available on my GitHub page as well as my profiles on MakerWorld, Creality Cloud, etc.

## License

[Customizable Dominos](https://github.com/myname-random/dominos) © 2025 by [Morgan Conner](https://github.com/myname-random/) is licensed under [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)

![Creative Commons](https://mirrors.creativecommons.org/presskit/icons/cc.svg)![Attribution](https://mirrors.creativecommons.org/presskit/icons/by.svg)![NonCommercial](https://mirrors.creativecommons.org/presskit/icons/nc.svg)![ShareAlike](https://mirrors.creativecommons.org/presskit/icons/sa.svg)