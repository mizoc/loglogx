#!/bin/bash
# Checking...
which dialog >/dev/null 2>&1 || {
  echo `basename $0` needs dialog.
  exit 1
}

# Logging...
OUT=my_log.txt #output log file
TMP=`mktemp`
trap 'rm $TMP; exit 1' 1 2 3 15

while :;do
  #Call Sign
  dialog --backtitle "Dialog Form Example" --title "Dialog - Form"  --form "\nDialog Sample Label and Values" 25 60 16 "Call Sign:" 1 1 "" 1 25 25 30 2>$TMP
  STATUS=$?
  test $STATUS -ne 0 && break
  test -z $TMP && continue
  CALL=`cat $TMP | tr '[a-z]' '[A-Z]'`

  #Set start time
  START_TIME=`date --utc '+%Y/%m/%d %H:%M'`

  #Set remarks
  dialog --backtitle "Dialog Form Example" --title "Dialog - Form"  --form "\nDialog Sample Label and Values" 25 60 16 \
    "Remarks:" 1 1 "" 1 25 25 30 \
    "Rcvd:" 2 1 "" 2 25 25 30 \
    "Sent:" 3 1 "" 3 25 25 30 \
    "Call Sign:" 4 1 "$CALL" 4 25 25 30 \
    "Start Time:" 5 1 "$START_TIME" 5 25 25 30 \
    2>$TMP

  #Set end time
  END_TIME=`date --utc '+%Y/%m/%d %H:%M'`

  #Write to the file
  cat $TMP |tr "\n" '%' >>$OUT
  echo $END_TIME >>$OUT
done


# Post processing...
clear
rm $TMP
