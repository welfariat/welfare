#!/bin/bash

wget -c -b --tries=inf -P site/$1 -i $1.list -o $1.log
