#!/usr/bin/env sh

echo "Compiling from source..."

go build -o bin/teko .

echo "Moving to app folder..."

sudo mv bin/teko /usr/local/bin/teko

echo "Done!"