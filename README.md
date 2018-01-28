Archived: Jan 28 2018
By: Xon-Xoff

run_analysis.R

Project Paper for "Getting and Cleaning Data""
Coursera, May 2014

Date: 25 May, 2014
By: Xon-Xoff

Assumptions:

1.   The data set is available/accessible locally, and in the user's
current working directory

2.   As per the project directions, we are interested only in the "mean"
and "std" values stored in the dataset

3.   The "cleaned data" will be a data frame that comprises only the values
referred to above, from where the data analyst may use various tools to 
extract needed information


To use the fucntion:

run_analysis("directoryname_1", "directoryname_2")


OUTPUT:

Two data frames will be output as ascii text files in the current working directory:
1: "./cleanMeanStd.txt"
        the merged and cleaned file that may be used for further analysis

2: "./meandata.txt"
        the ascii text file with the summary mean values for the "mean" and "std" 
        values for the relevant variable measurements

Note: these files may be loaded into R using the load() function


Summary: 

Function Name: "run_analysis.R"

The functions takes two arguments, which would be text strings with the 
names of two local directories, both accessible, and in the current working
directory that contains the datasets.
The two datasets, stored within files within the two directories, will be
read in as data frames.

Both data frames will be merged, then a subset that includes the needed
"mean" and "std" values extracted to the final "cleaned data" dataframe.
The "cleaned data" dataframe then will be used to generate summary "mean"
and "std" values for the "Activity" and "Subject" variables, which will be
used as factors.

The output of the script will be two ascii text files:
1: "./cleanMeanStd.txt"
2: "./meandata.txt"
