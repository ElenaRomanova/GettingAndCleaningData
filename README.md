1. Script reads features from test and train data sets.
Then reads train and test labels, subjects. And creates dataset binding features, activities labels and subjects.
THat is initial dataset

2. Script getting subset of features that contains mean and standart deviation values, gets the set of their indexes and 
 extracts values names

3. Gives the descriptive names for variables

4. Extractes columns with mean and standart deviation values  and replaces activity id with label

5. Creates new dataset with the average of each variable for each activity and each subject.

6. Writes the new tidy dataset into txt file
