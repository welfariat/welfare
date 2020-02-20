@echo off
@egrep -o --no-filename "dataUrl='[^']+'" albums-current\* | grep -o "images/.*\.jpg" | sort | uniq