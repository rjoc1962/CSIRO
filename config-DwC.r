library(rlist);
library(dplyr);
library(tidyverse)

# define files
   fDir     <- "./inData/"                   # Input data directory
   outDir   <- "../outData/"                # Output data directory
   fileList   <- c("SA Flora Sample.csv")  # List of input files. Could also use 'list.files' in main code

# Allow for multiple input/output files
   fSuffix  <- ".csv"                   # Suffix for input file name
   oPrefix  <- "dwc_"                   # Prefix for output file name


# define columns to rename values
   rCols   <- c("KEY","SOURCE","SIGHTINGDATE","OBSERVER","NUMOBSERVED","LATITUDE","LONGITUDE","SPRELIABCODE","SPECIES","FAMILYNAME","COMNAME1","SIGHTINGCOMM","HABITATCOMM","LOCATIONCOMM","RESERVENAME")
   dwcCols <- c("dwc:catalogNumber","dwc:samplingProtocol","dwc:eventDate","dwc:identifiedBy","dwc:individualCount","dwc:decimalLatitude","dwc:decimalLongitude"," dwc:identificationVerificationStatus","dwc:scientificName","dwc:family","dwc:vernacularName","dwc:fieldNotes","dwc:Habitat","dwc:georeferenceRemarks","dwc:SamplingLocationRemarks")
   remCols <- c("NSXCODE")
   dConvCols <- c("SIGHTINGDATE")
   relConvCol <- "SPRELIABCODE"
   verifStatus <- c("verification required","verified","verified by specialist","unverifiable")
   verifTranslate <- c("P","Y","YS","N");

#Darwin Core terms namespace   - not applied at this stage
   
   # dcterms:accessRights 
   # dcterms:bibliographicCitation 
   # dcterms:language 
   # dcterms:license 
   # dcterms:modified dcterms:references
   # dcterms:rightsHolder 
   # dcterms:type
