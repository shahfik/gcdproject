==============================================
Analysis of Human Activity Recognition dataset
v1.0
==============================================
Shahfik
shahfik@gmail.com
==============================================

This builds of the dataset of provided by the Smartlab team on Human Activity Recognition. The details of the dataset can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The objective of this analysis is to take the input from the HAR dataset and generate an average of the mean and standard deviation signals for each person and each activity.

==============================================

Each record in the output provides the following
- Volunteer ID
- Activity performed
- 66 average signals for the activity performed by the volunteer

==============================================

The dataset includes the following files:

- 'README.md': This file

- 'CodeBook.md': The codebook describing the variable names

- 'run_analysis.R': the R script to transform the UCI HAR dataset into the output

- 'avgHARdataset.txt': The output of the R script

Reference:
==========
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012