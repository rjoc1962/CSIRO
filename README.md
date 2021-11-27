
CSIRO - Job Application
Position: Data Engineer (78526)
===============================

Directories
===========
- inData  - CSIRO provided input files and task description and sample data

- outData - Output directory for reformatted sample data

Files
=====

- congig-DwC.r: Configuration file containing parameters for the main conversion script

- convertToDwC.r : Main conversion script

Please note first line in main conversion script sets current directly. This is, at present my localdata directory.

DATEACCURACY data: 

I was not sure of what was required in terms of determining start/end dates, decade, century etc... relative to the Event date. So I did not include any date processing, but did provide an additional column indicating the meaning of the DATEACCURACY code. 