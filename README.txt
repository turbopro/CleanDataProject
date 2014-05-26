In developing the script, we first did the data cleaning interactively at the prompt.
After the data files were read-in, merged, and subsets extracted, the code snippets
used in the process were transposed into the R-script.

Steps 

1:   Downloaded the zip file, unzip into my workspace, change to the unzipped main directory,
"UCI HAR Dataset", and set this sub-directory as my current working directory ("CWD").

2.   Read the README.txt file a few times to try to grasp the nature of the contents of 
the datset.  Read also the accompanying "features_info.txt", the "features.txt", and the
"activity_lables.txt" files.

3.   Listed and took note of the file chatracterisitcs--size, type, archive details--of
the files in the "./test" and "./train" sub-directories.  As the "y_test.txt" file of the
"./test" sub-directory was the smallest, I opened this file in a text editor to have a look
at the data directly.
     The format appeared to be fixed-width text in one long column, with what looked to
be repeating factors for the "Activity" labels, identified by the numbers 1 through 6.
     Because the "subject_test.txt" was a small file also, I opened it and saw that it 
too listed factors for the "Subject" volunteers, identified by the numbers 1 through 30.
     The corresponding files in the "./train" sub-directory were larger, but still small
enough to be viewed in a text editor.  When viewed, the text appeared to be similar to
the text in the files opened as detailed above.
     From this initial look at the files, I believed that all of them may be read in 
as a fixed-length, delimited text file, into a dataframe for further analysis.

4.   I used the "read.table" function to read in the smaller files of the "./test"
sub-directory.  Thereafter, I looked at the summary, the structure, the class, and some
of the attributes of the variables of the resultant dataframe.  There appeared to be no
errors in the read-in of the files, so I read in all files from both sub-directories.

5.   With the larger data files, the larger data frames had to be probed a little more
to determine if the reading-in processes were ok.  After some time probing, it appeared
that there were no errors in the dataframes; thus, for the script, we will use the
"read.table()" function.

6.   At this stage, I was not quite sure what the project asked for, so I did some 
surfing through the Discussion Forums for the project, where I received lots of good
hints about what I should do next.

7.   I merged the correlated dataframes, read-in from the relevant files in the two
sub-directories: i.e., the dataframes derived from the "./test/y_test.txt" and the 
"./train/y_train.txt" were merged via the rbind() function, and the same done for the
other two correlated files.  The rows of the "./test/y_test.txt" data frame derived 
object were added to the bottom of the correlated "./train/y_train.txt" data frame 
derived object.

8.   The merged dataframes were probed again to ascertain if the merge completed 
without error--in as much as may be possible to ascertain, by counting number of rows,
number of cloumns, column names, column classes, file sizes, and the like.  Moreover,
some subsetting was done on the original and merged dataframes to compare output.
After all these checks, it appeared that the merge completed successfully.

9.   Given that the merged data frame with the full complement of 561 variables with
mesaurements may not be required to complete the project, a subset of this dataframe
was made to extract only those variables that included either of the text strings 
"mean" and "std" in their names.  The result of the filtering left only 79 columns 
(measured variables) to be included in the new dataframe.
     This new dataframe was given a new name and stored temporarily to a file in the
CWD on disk.

10.  With the new trimmed down dataframe (containing the variables with the "mean" 
and "std" text), along with the other two, the "Subject" dataframe, and the
"Activity" dataframe, I merged the three via the cbind() function.  The "Activity" 
and "Subject" datframes were added as columns to the end of the larger dataframe 
with the variables.
     This merged dataframe was saved to an appropriately named file in the CWD on
disk.  I then loaded in the file, probed and played with the file to confirm that
it contained "cleaned data" that could be used for further analysis later.  

11.  In order to analyse and retrieve data from the newly merged dataframe, I used
the "melt()" function to reshape the dataframe whereby the "Activity" and "Subject"
columns, converted to factors, were used as indices to the other measured variables
of the dataframe.

12.  I then used the acast() function to calculate and return a dataframe with the
requisite summary mean values for the "mean" and "std" values from the original 
datasets.
     This dataframe was saved to an appropriately named file in the CWD on disk.
Here too, the file was loaded and probed to ascertain that it contained what was 
required for the project.