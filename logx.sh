#!/bin/bash
# Initial Setting...
which dialog >/dev/null 2>&1 || {
  echo `basename $0` needs dialog.
  exit 1
}

TMP=`mktemp "/tmp/${0##*/}.tmp.XXXXXX"`
trap 'rm "$TMP"; clear; exit 1' 1 2 3 15

# Setting Mode, Freq.
dialog --menu "Mode" 11 30 5 1 CW 2 SSB 3 AM 4 FM 2>"$TMP"
STATUS=$?
test $STATUS -ne 0 && kill -1 $$
MODE=`cat "$TMP"`
dialog --menu "Frq." 15 30 12 1 1.9MHz 2 3.5MHz 3 7MHz 4 10MHz 5 14MHz 6 18MHz 7 21MHz 8 28MHz 9 29MHz 10 50MHz 11 144MHz 12 433MHz 2>"$TMP"
STATUS=$?
test $STATUS -ne 0 && kill -1 $$
FRQ=`cat "$TMP"`

# Logging...
OUT=my_log.txt #output log file

while :;do
  #Call Sign
  dialog  --title "New QSO"  --form "\nDialog Sample Label and Values" 25 60 16 "Call Sign:" 1 1 "" 1 25 25 30 2>"$TMP"
  STATUS=$?
  test $STATUS -ne 0 && break
  test -z "$TMP" && continue
  CALL=`cat "$TMP" | tr '[a-z]' '[A-Z]'`

  #Set start time
  START_TIME=`date --utc '+%Y/%m/%d %H:%M'`

  #Set remarks
  dialog --backtitle "Dialog Form Example" --title "Dialog - Form"  --form "\nDialog Sample Label and Values" 25 60 16 \
    "Remarks:" 1 1 "" 1 25 25 30 \
    "Rcvd:" 2 1 "599" 2 25 25 30 \
    "Sent:" 3 1 "599" 3 25 25 30 \
    "Call Sign:" 4 1 "$CALL" 4 25 25 30 \
    "Start Time:" 5 1 "$START_TIME" 5 25 25 30 \
    2>"$TMP"

  #Set end time
  END_TIME=`date --utc '+%Y/%m/%d %H:%M'`

  #Write to the file
  cat "$TMP" |tr "\n" '%' >>$OUT
  echo $END_TIME >>$OUT
done


# Post processing...
clear
rm "$TMP"
