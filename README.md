# README

## Usage

- `teko bewertungsraster`: create bewertungsraster markdown file
- `teko render <directory>`: render all markdown files in given directory to pdf
- `teko dir`: create directories from `notenblatt.csv` file
- `teko marks`: calculate marks and points from `notenblatt.csv` file

## Installation

Install by adding to `.zshrc`:
```shell
#!/usr/bin/env bash

project_path="$(pwd)"
echo $project_path
echo "alias teko=${project_path}/teko.sh" >> ~/.zshrc
source ~/.zshrc
```