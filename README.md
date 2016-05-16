# run_analysis

The get_dataset functions gets the name of the directory as a parameter.
Then it gets all of the .txt inside, loading "subject" with no further processing.
Then it proceeds to load the bulk of the data (using features.txt as names), the names
get filtered by a grep to select means and standar deviations only. After that it loads
the classified activities and then it sets their friendly names (as defined by activity_labels.txt),
pasting (binding) the data together in a dataframe.

Using that function, the script gets both "test" data and "train", and saves it as a unified dataset
call "dataset".

Finally, using the "aggregate" function a last dataset (called "dataset_2") gets built which gets the means 
of the selected features *by activity*.
