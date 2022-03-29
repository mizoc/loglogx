#!/bin/bash
# Author:mizoc
# LICENSE:MIT
# Repository:https://github.com/mizoc/logx
#
# Usage
#   $./logx.sh save file path
#
#
########################################

# Initial Setting...
which dialog >/dev/null 2>&1 || {
  echo `basename $0` needs dialog.
  exit 1
}

test $# -ne 1 && {
  echo "Usage: $`basename $0` Saving_file_path"
  exit 1
}
OUT="$1"
touch "$OUT"

TMP=`mktemp "/tmp/${0##*/}.tmp.XXXXXX"`
trap 'rm "$TMP"; clear; exit 1' 1 2 3 15

# Setting Mode, Freq.
MODE=`dialog --stdout --menu "Mode" 11 30 5 CW "" SSB "" AM "" FM ""`
STATUS=$?
test $STATUS -ne 0 && kill -1 $$

FRQ=`dialog --stdout --menu "Frq." 15 30 12 1.9MHz "" 3.5MHz "" 7MHz "" 10MHz "" 14MHz "" 18MHz "" 21MHz "" 28MHz "" 29MHz "" 50MHz "" 144MHz "" 433MHz ""`
STATUS=$?
test $STATUS -ne 0 && kill -1 $$

# Logging...
test "$MODE" = "CW" && DEFAULT_RST=599 || DEFAULT_RST=59

while :;do
  #Call Sign
  dialog  --title "New QSO" --cancel-label "Exit" --ok-label "Start QSO" --form "" 20 60 16 "Call Sign:" 1 1 "" 1 25 25 30 2>"$TMP"
  STATUS=$?
  test $STATUS -ne 0 && break
  CALL=`cat "$TMP" | tr '[a-z]' '[A-Z]'`
  test -z "$CALL" && continue

  #Set start time
  START_TIME=`date --utc '+%Y/%m/%d %H:%M'`

  #Set remarks
  INFO=$(dialog --stdout --title "QSO Info" --cancel-label "Discard QSO" --form "" 20 60 16 \
    "Remarks:" 1 1 "" 1 25 25 30 \
    "Rcvd:" 2 1 "$DEFAULT_RST" 2 25 25 30 \
    "Sent:" 3 1 "$DEFAULT_RST" 3 25 25 30 \
    "Call Sign:" 4 1 "$CALL" 4 25 25 30 \
    "Start Time:" 5 1 "$START_TIME" 5 25 25 30)

  #Set end time
  END_TIME=`date --utc '+%Y/%m/%d %H:%M'`

  #Write to the file
  echo "$INFO" |tr "\n" '%' >>$OUT
  echo $END_TIME >>$OUT
done


# Post processing...
clear
rm "$TMP"
