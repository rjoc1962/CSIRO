# Convert to DwC
# set Working Data Directory  - assumes you are at root dir CSIRO-Interview
setwd("C:/Users/Rose/Documents/MyLocalData/GitHub/CSIRO-Interview")
source("./config-DwC.r");   
setwd(fDir);
   filePath <- outDir
# read in config file
   

# Allow for multiple input files
   #fileList <- list.files(path=".", fSuffix, full.names = FALSE)
   for (k in 1:length(fileList)) {
      inFname  <- fileList[k]                                                          # get input filename
      inFlora  <- read.csv(file=inFname[k], header=TRUE, sep=",",stringsAsFactors=FALSE)   # read Index csv file data
      tFlora   <- tibble::as_tibble(inFlora)
      
      # Remove non-required columns
      for (i in 1:length(remCols)) {                                                   # discard unwanted columns
         tFlora <- dplyr::select(tFlora,-c(remCols[i]))
      }
      # Convert dates to yyyy-mm-dd
      for (jj in 1:length(dConvCols)) {
         dateVal <- tFlora %>% dplyr::select(dConvCols[jj])
         dVal <- dateVal$`SIGHTINGDATE`  # disclaimer... this should be a parameter
         #dConv <- as.Date(dVal, "%d/%m/%Y")
         tFlora[dConvCols[jj]] <- as.Date(dVal, "%d/%m/%Y")
      }
      #Convert date Range indicators - DATEACCURACY column - range of possible dates the record may have been taken in
      # I haven't provided actual ranges based on the type of DATEAccuracy but have shown how create a new column
      # to add to the file. There are some DwC terms that are now deprecated which could potentially have been populated
      # to indicate the accuracy range - "dwc:EarliestDateCollected"," dwc:LatestDateCollected"
      # D - Day
      # M - Month
      # Y - Year
      # T - Decade
      # C - Century
      
      accVal <- tFlora %>% dplyr::select(DATEACCURACY)
      accTerm <- apply(accVal,1,function(t) {
         if (t == 'D') 
             return("Day")
         else if (t == 'M')
             return("Month")
         else if (t == 'Y')
            return("Year")
         else if (t == 'T')
            return("Decade")
         else if (t == 'C')
            return("Century")
         })
      tFlora <- tFlora %>% mutate(accTerm, .after=6)
      tFlora <- rename(tFlora, "Date Accuracy Range" = "accTerm")

      # Convert Species Reliabilty column
       
       relVal <- tFlora %>% dplyr::select(relConvCol)
       for (rv in 1:length(verifTranslate)) {
          tFlora$`SPRELIABCODE` <- sub(verifTranslate[rv],verifStatus[rv],tFlora$`SPRELIABCODE`)
       }

      
      # rename columns for DwC
      colnames(tFlora)[colnames(tFlora) %in% rCols] <- dwcCols
    
   } 
   # Output file name                                                                                 # Convert dates
   outFlora <- paste0(outDir,oPrefix,inFname)                                       # build CSV output filename
   write.csv(tFlora,file = outFlora,row.names=TRUE)
                                                                                      # write output file


