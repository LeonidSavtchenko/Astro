# ASTRO
## 14/12/2017


ASTROCYTE 1.0. Interactive realistic model of protoplasmic astrocyte. NEURON environment

## Version 1.0

<p> Electrically non-excitable astrocytes are able to transduce, integrate and propagate physiological signals by engaging 
multi-modal fluctuations and non-dissipative diffusion waves of intracellular Ca2+. Deciphering this type of signalling, 
however, poses a conceptual challenge because it requires an understanding of molecular interactions in the complex 
system of ultrathin processes which constitute the bulk of astrocyte morphology. How a particular mode of intracellular 
Ca2+ signalling could generate a particular physiological message remains poorly understood. Gaining mechanistic insights 
into astrocytic physiology will be therefore difficult without a detailed biophysical model that recapitulates realistic 
astrocyte morphology and known cellular mechanisms.
</p>




## Experimental data or estimates desirable to build a realistic astrocyte model

##### 1. A 3D reconstructed tree of main identifiable astroglial processes importable into NEURON. Alternatively, this could be an artificially generated cell arbour with the branching pattern and branch diameters representing the average (typical) astrocyte from the population of interest. 
##### 2. A sample (20-50) of nanoscopic astroglial processes reconstructed using 3D (serial-section) EM, with rendered surface co-ordinates. This sample will be used to obtain statistical properties of the ultrathin processes to be generated in the model. 
##### 3. Average tissue volume fraction occupied by astroglia, as distributed radially from the soma to the cell edges. This data set is obtained from two-photon excitation measurements in situ (or from published data). 
##### 4. The mean membrane surface density and the surface-to-volume fraction values obtained from 3D reconstructions of nanoscopic astroglial processes.  
##### 5. The characteristic I-V curve (somatic patch-clamp, square-pulse current injections) for the astroglia of interest, other (optional) available functional data such as electrical responses to glutamate uncaging or changes in extracellular potassium, intracellular calcium wave speed, etc. 


## Installation. 

### System Requirements for ASTRO:
#### •	The basic languages : C++, MATLAB not older 2013 and Neuron 7.0
#### •	Platform : Linux and Windows. 
#### •	Type of operation : Sequential and parallel (MPI) computing


## Setting up and running ASTRO: Main regimes of modelling 


##### 1.	Constructing astroglial morphology ('Nano-geometry', Host computer only required). Importing the 3D main-branch morphology of astroglia into NEURON; generating, within the NEURON environment, the nanoscopic astroglial protrusions that reflect experimental data. This regime can be run separately from other parts of ASTRO, it requires a Host computer with MATLAB (2012 or later) and NEURON (7.2 or later, https://neuron.yale.edu/neuron/download) installed under Windows 7 or 10. 

##### 2.	NEURON-based simulations of membrane mechanisms ('NEURON simulations', Host computer only required). Further adjustment of the astrocyte morphology (in accord with volumetric data); populating the cell with membrane mechanisms; setting up simulation configurations and protocols. This regime can be run separately from other parts of ASTRO, it requires a Host computer with MATLAB (2012 or later) and NEURON (7.2 or later, https://neuron.yale.edu/neuron/download) installed under Windows 7 or 10. 
##### 3.	Simulating full-scale Ca2+ dynamics ('Calcium Dynamics on Cluster', Host and Worker computers normally required). Design and simulations of longer-term (seconds to minutes) intracellular calcium dynamics within realistic geometry using the cluster / cloud-based parallel computing. This regime can be run separately from other parts of ASTRO, it requires a Host computer with MATLAB (2012 or later) and NEURON (7.2 or later, https://neuron.yale.edu/neuron/download) installed under Windows 7 or 10, and Worker computer / cluster operating under Linux and with preinstalled NEURON (https://neuron.yale.edu/neuron/download/compile_linux) and MPI. 
##### Briefly, in this regime, the user working on the Host computer with MATLAB creates a MAT-file containing instructions for computation; uploads this file to the Worker cluster and launches there the simulations of astroglial Ca2+ dynamics (independently of the Host computer). The Host computer connects intermittently to the Worker time (a) to monitor computation progress, and (b) to download intermediate simulation results that are displayed and saved in MATLAB. Once simulations have been completed, the MATLAB module running on the Host computer downloads the output MAT-file and visualises the computation results. 


## Documentation

Manual and API documentation can be found at https://github.com/LeonidSavtchenko/Astro



<address>

Written by <a href="mailto:savtchenko#yahoo.com">Dr. Leonid Savtchenko</a>.<br> and Prof. Dmitri Rusakov 
Visit us at:<br>
http://www.ucl.ac.uk/ion/departments/epilepsy/themes/synaptic-imaging <br>
Department of Clinical and Experimental Epilepsy<br>
Institute of Neurology<br>
University College London<br>
UK<br>

</address>
