### run_analysis.R

### Project Paper for Getting and Cleaning Data
### Coursera, May 2014

### Date: 25 May, 2014
### By: Xon-Xoff

##   Assumptions:
##   1.   The data set is available/accessible locally, and in the user's
##   current working directory
##
##   2.   As per the project directions, we are interested only in the "mean"
##   and "std" values stored in the dataset
##
##   3.   The "cleaned data" will be a data frame that comprises only the values
##   referred to above, from where the data analyst may use various tools to 
##   extract needed information

##   Output:
##   Two data frames will be output as files in the current working directory:
##   1: ./cleanMeanStd.Rda
##        the merged and cleaned R-data file that may be used for further analysis
##
##   2: ./meandata.Rda
##        the R-data file with the summary mean values for the "mean" and "std" 
##        values for the relevant variable measurements


##   Summary: 
##
##   Function Name: "run_analysis.R"
##
##   The functions takes two arguments, which would be text strings with the 
##   names of two local directories, both accessible, and in the current working
##   directory that contains the datasets.
##   The two datasets, stored within files within the two directories, will be
##   read in as data frames.
##   Both data frames will be merged, then a subset that includes the needed
##   "mean" and "std" values extracted to the final "cleaned data" dataframe.
##   The "cleaned data" dataframe then will be used to generate summary "mean"
##   and "std" values for the "Activity" and "Subject" variables, which will be
##   used as factors

run_anlysis <- function(dir1, dir2) {
     
     # Read in the data from the various data files in the "dir1" directory
     d1dataX <- read.table(paste("./", dir1, "/X_", dir1, ".txt", sep=""))
     d1dataY <- read.table(paste("./", dir1, "/y_", dir1, ".txt", sep=""))
     d1dataS <- read.table(paste("./", dir1, "/subject_", dir1, ".txt", sep=""))
     
     # Read in the data from the various data files in the "dir2" directory
     d2dataX <- read.table(paste("./", dir2, "/X_", dir2, ".txt", sep=""))
     d2dataY <- read.table(paste("./", dir2, "/y_", dir2, ".txt", sep=""))
     d2dataS <- read.table(paste("./", dir2, "/subject_", dir2, ".txt", sep=""))
     
     # Merge "dir1" and "dir2" component datasets using rbind()
     mdataX <- rbind(d1dataX, d2dataX)
     mdataY <- rbind(d1dataY, d2dataY)
     mdataS <- rbind(d1dataS, d2dataS)
     
     # Read in column names from "./features.txt"
     fColNames <- read.table("./features.txt")
     
     # convert "fColNames" to character vector of names
     fColNames <- as.character(fColNames[,"V2"])
          
     # remove "()-" from the element text strings in "fColNames"
     fColNames <- gsub("[()-]", "", fColNames)
     
     # Set column names of "mdataX", "mdataY", and "mdataS"
     colnames(mdataX) <- fColNames
     colnames(mdataY)[1] <- "Subject"
     colnames(mdataS)[1] <- "Activity"
     
     # Extract column indices for all columns with the "mean" and
     # "stddev" characters in the column names of "mdataX"
     colmeanidx <- grep("mean", names(mdataX))
     colstddevidx <- grep("std", names(mdataX))
     
     # Combine the indices
     colidx <- sort(c(colmeanidx, colstddevidx))
     
     # Retrieve and store subset of main dataframe using the combined index
     mMSdataX <- mdataX[, colidx]
     
     # Merge all datframes: place the dataframes "mdataY" (with "Subject"
     # data) and "mdataS" (with "Activity" data) as additional columns to 
     # the "mMSdataX" (with "mean" and "std" data) dataframe
     cMSData <- cbind(mMSdataX, mdataY, mdataS)
     
     # save "cleaned data" in current working directory
     save(cMSData, file="./cleanMeanStd.txt", ascii=TRUE)
     
     # Reshape dataframe "cMSData" to extract summary "mean" values
     # For the "dcast()" function, use "Activity" and "Subject" columns
     # as "indices"; use all other columns as "variables"
     # Create list for the "variables" -- remove the "Activity" and 
     # "Subject" strings from the names list
     mColNames <- names(cMSData)
     mColNames <- mColNames[-length(mColNames)]
     mColNames <- mColNames[-length(mColNames)]
     
     # Use "melt()" to reshape the dataframe to have the "Activity" and
     # "Subject" columns serve as indices for the measured variables columns
     rData <- melt(cMSData, id=c("Activity", "Subject"), measure.vars=mColNames)
     
     # Read in "activity_labels.txt" to retrieve list of activities
     aLabelNames <- read.table("./activity_labels.txt")
     
     # Convert "aLabelNames" to character vector of names
     aLabelNames <- as.character(aLabelNames[,"V2"])
     
     # Retrieve mean of the values and store into new data frame
     # The acast() function returns a matrix
     meanData <- acast(testdata, Activity + Volunteers ~ variable, mean)
     meanData <- as.data.frame(meanData)
     
     # save meanData data frame to file in current working directory 
     save(meanData, file="./meandata.txt", ascii=TRUE)
}