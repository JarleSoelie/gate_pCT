IMPORTANT!
The Gate source file called "GateSourceTPSPencilBeam.cc" located in "/GATE/gate_v8.2/source/physics/src" and the header file called "GateSourceTPSPencilBeam.hh" located in "/GATE/gate_v8.2/source/physics/include" have been modified slightly! 

Most important is the .cc file where lines 261-273 is exchanged with the following code:

mDistriGeneral = new RandGeneral(engine, mPDF, mTotalNumberOfSpots, 0);
int bin =0;    
if (mSortedSpotGenerationFlag){
  mNbIonsToGenerate.resize(mTotalNumberOfSpots,0); //number of ions to generate to be placed in each spot
  long int ntotal = GateApplicationMgr::GetInstance()->GetTotalNumberOfPrimaries();
  int counter =mSpotWeight[0]; //number of protons in each spot from plan_file.txt
  for (long int i = 0; i<ntotal; i++){ //for every primary
    if (!mRealisticSpotFlag){ // This is set to true above
      if(i>=counter){ //Counter is the number of protons in each spot
        bin++;  
        counter += mSpotWeight[bin];
      }	
    }
    else{	  
      bin = mTotalNumberOfSpots * mDistriGeneral->fire(); //Chooses which spot to fire at
    }
    ++mNbIonsToGenerate[bin]; //adds up the number of ions to be simulated in each bin/spot
  }
  for (int i = 0; i < mTotalNumberOfSpots; i++) {
    GateMessage("Beam", 3, "[TPSPencilBeam] bin " << std::setw(5) << i << ": spotweight=" << std::setw(8) << mPDF[i] << ", Ngen=" << mNbIonsToGenerate[i] << Gateendl );
  }
mCurrentSpot = 0;
}

Before compiling GATE 8.2, copy the "GateSourceTPSPencilBeam.cc" into the GATE 8.2 source folder "/GATE/gate_v8.2/source/physics/src", and the header file "GateSourceTPSPencilBeam.hh" into "/GATE/gate_v8.2/source/physics/include". Overwrite the original files, then compile GATE 8.2. This allows us to use the exact number of protons per beam spot (spotWeight) as listed in the "PlanDescriptionToGate.txt" file that is located in the same folder as your Gate macro utilising Treatment Planning Scanning. The beam spots are filled sequentially.

REMEMBER to set the number of primary protons equal to the (number of spots * number of protons in each spot)
(For example; 123 spots with a desired 1000 protons in each spot, equals 123 000 primary protons needed to be simulated)

VERY IMPORTANT is also to remember that the following flags must be set to true in the main macro file for this to happen!

/gate/source/protonScanning/setSpotIntensityAsNbIons true
/gate/source/protonScanning/setSortedSpotGenerationFlag true
/gate/source/protonScanning/setFlatGenerationFlag true 

Typically, all this should be included in the gate macro, e.g.:
/gate/source/addSource protonScanning TPSPencilBeam
/gate/source/protonScanning/setParticleType proton
/gate/source/protonScanning/setPlan PlanDescriptionToGate.txt
/gate/source/protonScanning/setBeamConvergence false
/gate/source/protonScanning/setSpotIntensityAsNbIons true
/gate/source/protonScanning/setSortedSpotGenerationFlag true
/gate/source/protonScanning/setFlatGenerationFlag true
/gate/source/protonScanning/setSigmaEnergyInMeVFlag false
/gate/source/protonScanning/setSourceDescriptionFile Source-Properties.txt
