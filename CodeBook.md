#### project Code Book

1. The train and test data are merged resulting in 3 data set as follow:
Xdata: 10299 rows, 561 columns
ydata: 10299 rows, 1 columns
sdata: 10299 rows, 1 column

2. The mean and SD records are extracted from features file and become the respective 
column name of xdata. Brackets in the records are removed and converted to the lower
case before been assigned as column name in xdata.

3. The activity description is extracted from activity_labels file and assigned to the
ydata column. "-" is removed from the record before updating to ydata.

4. xdata,ydata and sdata are combined as one data set with descriptive name “subject” 
assigned to sdata.

5. The mean and SD column name in the final_dataset 
will be consolidated as a row instead to meet tidy data requirement. 
There are 30 subjects and 6 activities so the final clean data set group by subject and 
activity will have total 180 rows. The “average_final_dataset.txt” consisting of three 
columns “subject”, “activity” and “avg” is  the final output.
