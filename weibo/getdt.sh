#!/bin/bash

TOUCH_FMT=%Y%m%d%I%m.%S

WB_TIME=$(curl https://www.weibo.com/$1/$2 -H "Cookie: $(cat cookie-sina.txt)" > 1584020535000.html | egrep -o "date=\\\\\"[^\"]+\""  | egrep -o "[0-9]+" | sed "s/000$//")
TOUCH_STR=$(date -d @WB_TIME +${TOUCH_FMT})
touch 