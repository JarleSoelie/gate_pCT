(To enable TPS with full control over the amount of protons in each spot, go to the folder called "(sourceTPS)".)

Remember to comment and uncomment the different phantoms and tracker setups inside "main.mac"!
There are mainly two setups, ideal and realistic. All setups will output phasespace files for both front tracker pair and rear tracker pair hits, but the front tracker pair are considered ideal (air) and are easily disregarded in analysis of a realistic setup since they have no impact on the protons.

To run a full pCT scan with the settings set in main.mac, do the following in your terminal:
./runScan.sh <rotation_start> <rotation_end> <rotation_increment>

E.g. A full 360 degree scan every 2 degrees (=180 projections)
./runScan.sh 0 360 2

If doing a pRad, only give it degrees to get a single projection:
No rotation in pRad
./runScan.sh 0 0 1

However, if doing a pRad of the head phantom from its side, rotate the head 90 degrees:
./runScan.sh 90 90 1

