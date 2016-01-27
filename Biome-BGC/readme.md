# Biome-BGC:
---
## Download Model:

www.forestry.umt.edu/ntsg [link](www.forestry.umt.edu/ntsg)

--------------------
## Process descriptions:

* Canopy radiation

>	sunlit&shaded

* Photosynthesis

>	Using a biochemical model with kinetic parameters and substitution from the CO2 diffusion.

* Stomatal conductance

>	Leuning model

* Evaporation and transpiration

>	Penman-Monteith

---
## Important Notes:

* The first required input file is called the initialization file. It provides general information about the simulation,including a description of the physical characteristics of the simulation site, a description of the time-frame for the simulation, the names of all the other required input files, the names for output files that will be generated, and lists of variables to store in the output files.

* The second required input file is the meteorological data file. It contains daily values for temperature, precipitation, humidity, radiation, and daylength at the simulation site. It can contain any number of years of data.

IMPORTANT NOTE: LEAP-YEARS

The Biome-BGC code assumes that all years have 365 days, so meteorological data files should be edited to remove one day from leap years.

* The third required input file is the ecophysiological constants file. It contains an ecophysiological description of the vegetation at a site, including parameters such as leaf C:N ratio, maximum stomatal conductance, fire and non-fire mortality frequencies, and allocation ratios.


