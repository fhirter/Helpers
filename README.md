# README

## Usage

- `teko bewertungsraster`: create bewertungsraster markdown file
- `teko render <directory>`: render all markdown files in given directory to pdf
- `teko dir`: create directories from `notenblatt.csv` file
- `teko marks`: calculate marks and points from `notenblatt.csv` file
- `teko bewertungsraster <output file.csv> <input file.md>`: collects all points from `input file.md` and writes it 
  to a csv file.

## Installation

Install by adding to `.zshrc`:
```shell
#!/usr/bin/env bash

project_path="$(pwd)"
echo $project_path
echo "alias teko=${project_path}/teko.sh" >> ~/.zshrc
source ~/.zshrc
```

## Todo

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