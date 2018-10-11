#!/bin/bash


TEST_FILE=./data/test_data_1.txt
cp ./data/training_data_1.txt ./data/train_data
INPUT_FILE=./data/train_data
sed '1d' $TEST_FILE | awk -F "\t" '{print $3}' > ./data/test_feature
sed '1d' $TEST_FILE | awk '{print $1}' | sed 's/True/1/;s/False/0/' > ./data/test_label



### for iteration 

sed '1d' $INPUT_FILE | awk '{print $1}' | sed 's/True/1/;s/False/0/' > ./data/train_label
sed '1d' $INPUT_FILE | awk -F "\t" '{print $3}' > ./data/train_feature
n=`python src/findmax_N.py ./data/train_feature`
((n=n+1))
echo $n 





