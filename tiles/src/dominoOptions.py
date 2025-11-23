import json

bedX = 250
bedY = 250
year = "2025"
author = "Morgan Conner"
license = "CC BY-NC-SA 4.0"
enable_3mf = True
enable_stl = True

cmdOptions = "openscad --backend=manifold -p Dominos.json"
ThreemfOptions = f" -O export-3mf/color-mode=none -O export-3mf/add-meta-data=true -O export-3mf/meta-data-designer='{author}' -O export-3mf/meta-data-copyright='(c) {year} {author}' -O export-3mf/meta-data-license-terms='CC BY-NC-SA 4.0'"

dominoSet = [6,9,12,15,18]
dominoSetNames={6: "DoubleSix", 9:"DoubleNine", 12:"DoubleTwelve", 15:"DoubleFifteen",18:"DoubleEighteen"}
marking = [1,2]
markingNames={1:"Pips", 2:"Numerals"}
size = [0,1,2,3,4]
sizeNames={0:"Mini", 1:"Standard", 2:"Professional", 3:"Jumbo", 4:"Tournament"}
layout = [2,3,4]
layoutNames={2:"Flat", 3:"Horizontal", 4:"Vertical"}
pipType = [1,2]
pipTypeNames = {1:"Divet", 2:"Hole"}
pipShape = [1,2,3]
pipShapeNames = {1:"Round", 2:"Square", 3:"Diamond"}
numberSet = [0,1,2]
numberSetNames = {0:"Plain", 1:"Standard", 2:"Zeroed"}

# Based on the size as index
pipEdgeMargin = [1,2,3,4,4]
dividerDiameter = [2, 2.5, 2.5, 2.5, 2.5]
numberSize = [6,10,12,12,12]

# Based on pipType as index
samePipSize = [False, False, True]

parameterSets = {}
commands = []

for ds in dominoSet:
	for s in size:
		for l in layout:
			for m in marking:
				if m == 1:
					for pt in pipType:
						for ps in pipShape:
							setName = f"{dominoSetNames[ds]}-{sizeNames[s]}-{layoutNames[l]}-{markingNames[m]}-{pipTypeNames[pt]}-{pipShapeNames[ps]}"
							setValues = {
								"BedSize": f"[{bedX}, {bedY}]",
								"DominoSet": f"{ds}",
								"Size": f"{s}",
								"Marking": f"{m}",
								"Layout": f"{l}",
								"PipType": f"{pt}",
								"PipShape": f"{ps}",
								"DividerDiameter": f"{dividerDiameter[s]}",
								"PipEdgeMargin": f"{pipEdgeMargin[s]}",
								"SamePipSize": f"{samePipSize[pt]}"
							}
							parameterSets[setName] = setValues
							if enable_3mf or enable_stl:
								objTitle = f"'Customized Dominos - {setName}'"
								commands.append(f"{cmdOptions} {'-o ' + setName + '.3mf' if enable_3mf else ''} {'-o ' + setName + '.stl' if enable_stl else ''} -P {setName} {ThreemfOptions + ' -O export-3mf/meta-data-title=' + objTitle if enable_3mf else ''} Dominos.scad")
				else:
					for ns in numberSet:
						setName = f"{dominoSetNames[ds]}-{sizeNames[s]}-{layoutNames[l]}-{markingNames[m]}-{numberSetNames[ns]}"
						setValues = {
							"BedSize": f"[{bedX}, {bedY}]",
							"DominoSet": f"{ds}",
							"Size": f"{s}",
							"Marking": f"{m}",
							"Layout": f"{l}",
							"NumberSet": f"{ns}",
							"DividerDiameter": f"{dividerDiameter[s]}",
							"NumberSize": f"{numberSize[s]}"
						}
						parameterSets[setName] = setValues
						if enable_3mf or enable_stl:
							objTitle = f"'Customized Dominos - {setName}'"
							commands.append(f"{cmdOptions} {'-o ' + setName + '.3mf' if enable_3mf else ''} {'-o ' + setName + '.stl' if enable_stl else ''} -P {setName} {ThreemfOptions + ' -O export-3mf/meta-data-title=' + objTitle if enable_3mf else ''} Dominos.scad")

output = {"fileFormatVersion": "1", "parameterSets": parameterSets}

with open("Dominos.json", "w", encoding="utf-8") as f:
	f.write(json.dumps(output, indent=4))

with open("Commands.json", "w", encoding="utf-8") as fc:
	fc.write(json.dumps(commands, indent=4))
