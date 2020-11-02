# gate_pCT
(To enable TPS with full control over the amount of protons in each spot, go to the folder called "(sourceTPS)" and follow the instructions within.)

Remember to comment and uncomment the different phantoms and tracker setups inside *"main.mac"* to modify the simulations.
There are mainly two setups in this repository, ideal (zero material budgets) and realistic (with material budgets). All setups will output phasespace files for both front tracker pair and rear tracker pair hits, but the front tracker pairs are always considered ideal and are easily disregarded in analysis of a realistic single-sided setup since they have no impact on the protons.

IMPORTANT! The global coordinate system is a bit rotated: X-direction cover the sideways-positions (horizontal), y-direction covers the depth-positions(!), and z-direction covers the height positions (vertical). This is because of the TPS source and gantry rotation defined in the GATE source code. So take note of the relative placements of all objects inside the macros.

Go into the *"phantoms"* folder and extract the head.7z if you are going to use the head phantom in the simulations.

Inside the *"main.mac"* you will build your simulation, you can change (comment or uncomment) the following:

1. Change tracker setups
**idealTrackers.mac** is the basic ideal (air) tracker planes placed so that a 20cm water phantom can be placed in the center and have 15 cm distance from inner tracker pair to the edge of the phantom. 
**idealTrackersCTP.mac** is the same as idealTrackers, but the location of the tracker planes is shifted so that the CTP (Catphan) phantoms will fit and have a 15cm distance to the tracker planes.
**realisticTrackers.mac** is the same as idealTrackers, but the rear tracker pair is modelled after the Bergen DTC (realistic and detailed material budget). 
**realisticTrackersCTP.mac** is the same as idealTrackersCTP, but the rear tracker pair is modelled after the Bergen DTC (realistic and detailed material budget).
**realisticFullDTC.mac**, this is more special and is used for investigations into the Bergen DTC and is not directly used in simulations used in image reconstruction! This can be used to read out hits from each of the 41 layers and do all kinds of analysis and track reconstructions of interest to the Bergen DTC prototype design.

2. Change phantom
**waterBox.mac** is just a water box with dimensions 20cm x 20cm x 20cm. Used together with idealTrackers and realisticTrackers to look at most likely path (MLP) estimations.
**spotPhantom.mac** is the same waterBox as before, but with a single 2cm x 2cm x 2cm Al cube in its center. Used to investigate pencil beam spot spacing effects.
**stepPhantom.mac** is the same waterBox as before, but with five 1cm x 1cm x 1cm Al cubes placed at five different depths and each rotated five degrees. Used to investigate the spatial resolution of proton radiographs (pRad) with respect to depth.
**linePair.mac** is the standardized CTP528 (line pair phantom) used for CT purposes to investigate spatial resolution.
**sensitom.mac** is the standardized CTP404 (sensitom phantom) used for CT purposes to investigate relative stopping power (RSP) accuracy.

3. Choose Actors
These define the output. 
**idealActors.mac** is for ideal trackers where each ideal tracker plane is associated with a phasespace actor used to readout positions, energy, etc...
**realisticActors.mac** is for the realistic rear trackers where the sensitive ALPIDE layers are associated with a phasespace actor.

4. Define the pencil beam and TPS plan
*/gate/source/protonScanning/setPlan PlanDescriptionToGate.txt*, this file contains the spot positions and weights used to radiate the phantom. The one listed is for the head phantom. Should be changed if you are using a different phantom (See Helge E.S. Pettersen for a handy python script...).
*/gate/source/protonScanning/setSourceDescriptionFile Source-Properties7mm.txt*, this is the source description (pencil beam properties) and contains the scanning magnets, energy, spot size, and divergence. The 7mm and 3mm options have been empirically found to produce a 7mm and 3mm spot size at the isocenter with the pencil beam window placed 50cm from the isocenter. Typically you want the 7mm beam... 
REMEMBER to set the correct number of protons (spot weight multiplied by the number of spots from planDescription file)!


(The rotation parameter is mandatory in this simulation framework to get the correct output filenames and ensure rotation of the CTP phantoms.)
To run a full pCT scan with the settings set in main.mac, do the following in your terminal:
*./runScan.sh <rotation_start> <rotation_end> <rotation_increment>*

E.g. A full 360 degree scan every 2 degrees (=180 projections)
*./runScan.sh 0 360 2*

If doing a pRad, only give it degrees to get a single projection:
No rotation in pRad
*./runScan.sh 0 0 1*

However, if doing a pRad of the head phantom from its side, rotate the head 90 degrees:
*./runScan.sh 90 90 1*
