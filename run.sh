#!/bin/bash


TEST_FILE=./data/test_data_1.txt
cp ./data/training_data_1.txt ./data/train_data
INPUT_FILE=./data/train_data
sed '1d' $TEST_FILE | awk -F "\t" '{print $3}' > ./data/test_feature
sed '1d' $TEST_FILE | awk '{print $1}' | sed 's/True/1/;s/False/0/' > ./data/test_label

n=`python src/findmax_N.py ./data/train_feature`
((n=n+1))

### for iteration 
END=5

for((i=1;i<=END;i++)); do

	sed '1d' $INPUT_FILE | awk '{print $1}' | sed 's/True/1/;s/False/0/' > ./data/train_label
	sed '1d' $INPUT_FILE | awk -F "\t" '{print $3}' > ./data/train_feature

	#### Decision Tree
	python ./src/vfdt.py --train_feature ./data/train_feature --train_label ./data/train_label \
 	--test_feature ./data/test_feature --test_label ./data/test_label --num $n --output_assign results/assign_file

	#### Prototype learning 
	  ### pre-train
	python2 ./src/rcnn_fc_softmax.py data/training_model_by_word2vec_1.vector data/train_feature \
	 ./data/train_label ./data/test_feature ./data/test_label ./data/train_lstm_output.npy ./data/test_lstm_output.npy ./results/rule_data_list
	  ### prototype 
	python2 ./src/prototype_save_distance.py results/rule_data_list ./data/train_lstm_output.npy ./data/train_label \
	  ./data/test_lstm_output.npy ./data/test_label ./results/similarity 
  
	### data reweight 


done 