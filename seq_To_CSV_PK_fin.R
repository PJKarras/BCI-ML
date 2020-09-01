# Current work 1/6/2020
############################################################################
# 
# Author: Daniel M. Griffith
# Date:
# Description: example script, suggestions welcomed
#Update Trina Merrick September 2019 to write out as a file.
#Update Peter Karras loop through files and convert to csv
#Update Kathryn Brill effficiency upgrade with data.table library
############################################################################
# library(devtools)
# install_github("griffithdan/thermocamTools")

# Set WD to location of script
  setwd("C:/Users/Peter/Desktop/Thermo_R_Code/FinalThermo")

# Package that does the .seq -> .csv conversion
install.packages("C:/Users/Peter/Desktop/Thermo_R_Code/Thermo/thermocamTools_0.1.tar.gz", repos = NULL, type = "source")
# Package that makes things go faster (pretty sure this is the "fwrite" function)
install.packages("data.table", 
                 repos = "https://Rdatatable.github.io/data.table", type = "source")
install.packages("stringr")
  
# LOAD LIBRARIES
library(thermocamTools)
library(stringr)
library(data.table)

# # # BEGIN # # #
  
# get all seq file names in example data
# Change path variable to whatever folder raw thermocam data is stored
# Note recursive = TRUE means that this will enter into any subdirectories
seqfile <- list.files(path = "C:/Users/Peter/Desktop/Thermo_R_Code/FinalThermo/rawdata", full.names = TRUE, recursive = TRUE, pattern = ".seq")
head(seqfile)
    
# For each file go through and convert to CSV and save
for(val in seqfile)
{
  # read thermocam image and save as object of "matrix" type
  thermoImg <- readThermocamRaw(file = val, output = "matrix")
  
  # Get date from attribute of thermoImg object (incorporated into object from readThermocamTools) and turn it into a string, with format
  # YEAR_MONTH_DAY_HOUR_MIN_bci_t which will represent filename
  dateOf <- toString(attributes(thermoImg)$info$Date)   # POSIXct -> String transform 
  dateOf = str_replace_all(dateOf, "[- :]", "_")        # Replace POSIXct formatting with underscores
  dateOf = substr(dateOf, 1, 16)                        # Chop off seconds (can be kept by commenting this step out)
  dateOf = paste(dateOf,"_bci_t",sep= "")               # Append _bci_t                      
  
  fwrite(thermoImg, file = paste("C:/Users/Peter/Desktop/Thermo_R_Code/FinalThermo/csvdata/",dateOf,".csv", sep = ""))
}


