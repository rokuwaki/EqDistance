#!/usr/local/bin/bash
MinMag=3
Catalog="hs_1981_2011_06_comb_K2_A.cat_so_SCSN_v01"

mkdir -p data
wget http://scedc.caltech.edu/ftp/catalogs/hauksson/Socal_DD/$Catalog -P data/

echo "Converting calendar time of catalog to UNIX time in [s]"
bash bin/CalSecUNIXTime.sh data/$Catalog $MinMag > data/$Catalog"_M"$MinMag"_sec".txt

echo "Calculating nearest-neighbor distance in Log10"
gfortran -fopenmp -Wall src/geodesic.f90 src/EqDistance.f90 -o bin/EqDistance
bin/EqDistance < data/$Catalog"_M"$MinMag"_sec".txt > tmp
cp tmp data/$Catalog"_M"$MinMag"_log10eta".txt
cp tmp2 data/$Catalog"_M"$MinMag"_T_R".txt

rm *.mod tmp*
