#!/bin/bash
# Author:mizoc
# LICENSE:MIT
# Repository:https://github.com/mizoc/loglogx
#
# Usage
#  $./csv2adif.sh IN.csv >OUT.adi
#
########################################

test ! -f "$1" -o $# -ne 1&& {
  echo "Usage: $`basename $0` IN.csv" >&2
  exit 1
}

cat <<- END
	Generated on `date --utc '+%Y-%m-%d'` at `date --utc '+%H:%M:%S'`Z by loglogx
	<ADIF_VER:5>3.1.2
	<CREATED_TIMESTAMP:15>`date --utc '+%Y%m%d %H%M%S'`
	<PROGRAMID:4>loglogx
	<EOH>
END

sed -e '1d' "$1" | while read LINE;do
  echo $LINE | awk -F , '{
  print ""
  gsub("/", "", $7); print "<QSO_DATE:8>" $7
  gsub(":", "", $8); print "<TIME_ON:"length($8)">" $8
  gsub("/", "", $11); print "<QSO_DATE_OFF:8>" $11
  gsub(":", "", $12); print "<TIME_OFF:"length($12)">" $12
  print "<CALL:" length($6) ">" $6
  print "<FREQ:" length($9) ">" $9
  print "<MODE:" length($10) ">" $10
  print "<RST_RCVD:" length($4) ">" $4
  print "<RST_SENT:" length($5) ">" $5
  print "<QTH:" length($2) ">" $2
  print "<NAME:" length($1) ">" $1
  print "<COMMENT:" length($3) ">" $3
  }'
done
