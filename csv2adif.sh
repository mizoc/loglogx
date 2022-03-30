#!/bin/bash
# Author:mizoc
# LICENSE:MIT
# Repository:https://github.com/mizoc/loglogx
#
# Usage
#  $./csv2adif.sh IN.csv OUT.adi
#      *OUT.adif must be empty
#
########################################

# Initial Setting...
test ! -f "$1" -o -s "$2" -o $# -ne 2&& {
  echo "Usage: $`basename $0` IN.csv OUT.adi" >&2
  echo '  *OUT.adif must be empty.' >&2
  exit 1
}

IN="$1"
OUT="$2"
cat >"$OUT" <<- END
  Generated on `date --utc '+%Y-%m-%d'` at `date --utc '+%H:%M:%S'`Z by loglogx

	<adif_ver:5>3.1.2
	<programid:4>loglogx

	<EOH>
END

sed -e '1d' "$IN" | while read LINE;do
  echo $LINE | awk -F , '{
  gsub("/", "", $7); print "<QSO_DATE:8>" $7
  gsub(":", "", $8); print "<TIME_ON:"length($8)">" $8
  print "<CALL:" length($6) ">" $6
  print "<FREQ:" length($9) ">" $9
  print "<MODE:" length($10) ">" $10
  print "<RST_RCVD:" length($4) ">" $4
  print "<RST_SENT:" length($5) ">" $5
  print "<EOR>"
  }' >>"$OUT"
done
