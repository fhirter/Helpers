# README

Install by adding to `.zshrc`:
```shell
#!/usr/bin/env bash

project_path="$(pwd)"
echo $project_path
echo "alias teko=${project_path}/teko.sh" >> ~/.zshrc
source ~/.zshrc
```