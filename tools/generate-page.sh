#!/bin/bash
# -*- coding: utf-8 -*-
# Generate the html file
# tools/generate-page.sh index

WORKING_PATH="events/elc2015"
BASE_PATH="mockups"

cd "$(dirname $(dirname "$0"))"
cd "$WORKING_PATH"

if [ -z "$1" ];then
  PAGE="index"
else
  PAGE=$( echo "$1" | tr '[:upper:]' '[:lower:]')
fi
RESULT="$PAGE".html
echo "" > $RESULT

while read -r LINE ; do
  if $(echo $LINE | grep -qE '\{\{\w+\}\}') ; then
    ITEM=$(echo $LINE | xargs | sed 's/[{{|}}]//g' | tr '[:upper:]' '[:lower:]')
    if [ "$ITEM" == "body" ]; then
      ITEM="${PAGE}-body"
    fi
    ITEM="${ITEM}.html"
    if [ -f "$BASE_PATH/${ITEM}" ]; then
      cat "$BASE_PATH/${ITEM}" >> $RESULT
      echo "\n" >> $RESULT
    fi
  else
    echo "$LINE" >> $RESULT
  fi
done < ${BASE_PATH}/base.html