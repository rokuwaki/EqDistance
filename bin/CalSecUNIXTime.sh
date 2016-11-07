#!/usr/local/bin/bash

awk '$11 >= '$2' {print $1,$2,$3,$4,$5,$6,$8,$9,$10,$11}' < $1 | while read year mon day hr min sec lat lon dep mag
do
    unixsec=`gdate --date "$year/$mon/$day $hr:$min:$sec" "+%s.%N" -u`
    echo $lon $lat $unixsec $mag
done #> SCSN_M3TimeSec.txt
