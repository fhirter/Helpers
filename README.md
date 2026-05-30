# README

## Usage

- `teko bewertungsraster`: create bewertungsraster markdown file
- `teko render <directory>`: render all markdown files in given directory to pdf
- `teko dir`: create directories from `notenblatt.csv` file
- `teko marks`: calculate marks and points from `notenblatt.csv` file
- `teko bewertungsraster <output file.csv> <input file.md>`: collects all points from `input file.md` and writes it 
  to a csv file.

## Installation

1. Install by adding to `.zshrc`:
```shell
#!/usr/bin/env bash

project_path="$(pwd)"
echo $project_path
echo "alias teko=${project_path}/teko.sh" >> ~/.zshrc
source ~/.zshrc


```

2. Install Latex Packages:
```
sudo tlmgr install titling lastpage titlesec lualatex-math
```

3. Install Font `Symbola`
4. Download Teko Logo from Extranet, extract the downloaded in the root folder. There should now be a folder called "Logovarianten" containing all the logos.


## Todo

- add go binary
- add flags for render script

- `teko marks` should work with quotes in the chapter headers.
- This can be used to convert all bewertungsraster to pdf:

```shell
#!/bin/zsh
source ~/.zshrc

for dir in **/*(/); do
    (
        cd "$dir" && teko render .
    )
done
```