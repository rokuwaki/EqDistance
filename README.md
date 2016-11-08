# EqDistance

- Fortran implementation for the method of [Zaliapin and Ben-Zion (2013, JGR)](http://doi.org/10.1002/jgrb.50179).
- The codes generate *nearest-neighbor distance* between earthquakes on given catalog.
- Results are summerized with [Jupyter Notebook (EqDistance/EqDistance.ipynb)](https://github.com/rokuwaki/EqDistance/blob/master/EqDistance.ipynb)
- Another faster (O(N√N)) C++ implementation has been developed by [kshramt](https://github.com/kshramt) and available at [kshramt/trial_kshramt/ZaliapinBen-Zion2013](https://github.com/kshramt/trial_kshramt/tree/master/ZaliapinBen-Zion2013)

## Usage

```bash
$ bash bin/RunEqDistance.sh
```

- You can modify magnitude threshold (`$MinMag`) in `RunEqDistance.sh`.  
- Output values are in Log10.
- *ad hok* correction is needed for L480661 of "hs_1981_2011_06_comb_K2_A.cat_so_SCSN_v01"   
  (2010 06 17 14 22 60.000 --> 2010 06 17 14 23 00.000)

## Dependencies
- GNU bash, version 4.4.0(1)
- GNU Wget 1.18
- gdate (GNU coreutils) 8.25
- GNU Fortran (Homebrew gcc 6.2.0) 6.2.0
- GeographicLib 1.46  
  Converted (to Fortran90) version of geographiclib is used for calculation of distance (provided by [alex-robinson/coordinates](https://github.com/alex-robinson/coordinates))
- jupyter-notebook 4.2.3
- Python 3.5.2
- numpy 1.11.2

## License
GNU General Public License v3.0
