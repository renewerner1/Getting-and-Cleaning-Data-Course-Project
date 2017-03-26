# Getting-and-Cleaning-Data-Course-Project
Course Project for Coursera Course on Data Science

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

**CONTENTS OF THE REPOSITORY**

1) README.md has a background and overview with regards to the project that is being addressed by this repository, the data and where it comes from .
2) tidy_data.txt contains the data set.
3) CodeBook.md describes the data set (data, variables & procedures applied to generate the data).
4) run_analysis.R, represents the R script used to create the data set (see **FUNCTIONALITY OF THE R CODE** below)

**INPUT DATA USED**

The input data used is from a study as cited below:

_Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013._

**STUDY DESIGN**

The study design by the authors is being described as per following outline:

_The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain._

**FUNCTIONALITY OF R CODE IN THE REPOSITORY**

run_analysis.R is used to create a tidy data set. It retrieves the source data set from the study and cleans it up to generate a tidy data set. 

The steps outlined as below are being applied for this:

1) Download and unzip source data if it doesn't exist.
2) Read data.
3) Merge the training and the test sets to create one data set.
4) Extract only the measurements on the mean and standard deviation for each measurement.
5) Use descriptive activity names to name the activities in the data set.
6) Appropriately label the data set with descriptive variable names.
7) Create a second, independent tidy set with the average of each variable for each activity and each subject.
8) Write the data set to the tidy_data.txt file.

For further details pls review the Code book and refer to the commentary in the code.
