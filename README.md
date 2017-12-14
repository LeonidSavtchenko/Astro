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

![astro](https://user-images.githubusercontent.com/19924227/34001958-4dd4909e-e0e9-11e7-9f8a-3e5411b0ada1.png)


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


To work with Astro software the user needs to have Matlab and Neuron on the host computer, as well as Linux and NEURON on the remote computer. 


"Astro" contains four directories  "host" and "worker"  for installation ARACHNE in any cluster operating under Linux/Windows and any host computer 
operating under Windows with preinstalled Matlab. 

In the beginning the user must copy all the files from the Astro directory to his computer, keeping the structure of all the directories.



## Examples



## Documentation

Manual and API documentation can be found at https://github.com/LeonidSavtchenko/Astro



<address>

Written by <a href="mailto:savtchenko#yahoo.com">Leonid Savtchenko</a>.<br> 
Visit us at:<br>
http://www.ucl.ac.uk/ion/departments/epilepsy/themes/synaptic-imaging <br>
Department of Clinical and Experimental Epilepsy<br>
Institute of Neurology<br>
University College London<br>
UK<br>

</address>
