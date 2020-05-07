#!/bin/sh

cd /
ls -l /github/workspace
./tf-auto-document --repo=/github/workspace --mods=$MODULES_FOLDER
