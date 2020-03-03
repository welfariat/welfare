#!/bin/bash

find ./site/ -type f -name "*.log" -exec rm -f {} \;
find ./site/ -type f -name "*.list" -exec rm -f {} \;
