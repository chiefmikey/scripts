#!/bin/bash

# Set the directory to search for .sh files
DIR=$1

# Find all .sh files in the directory (excluding node_modules) and make them executable
find "$DIR" -type f -name "*.sh" ! -path "*/node_modules/*" -exec chmod +x {} \;
