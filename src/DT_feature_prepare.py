

import argparse
import numpy as np

parser = argparse.ArgumentParser()
parser.add_argument('--feature', type=str, help='feature file')
parser.add_argument('--label', type=str, help='label file')
parser.add_argument('--num', type=int, help='feature num')
parser.add_argument('--npyfile', type=str, help='npy file')
args = parser.parse_args()

feature_file = open(args.feature, 'r')
label_file = open(args.label, 'r')
feature_dim = args.num
output_file = args.npyfile 


feature_lines = feature_file.readlines()
label_lines = label_file.readlines()

mat = np.zeros((len(feature_lines), feature_dim + 1), dtype = float)
for i, line in enumerate(feature_lines):
	line = line.rstrip().split() 
	line = [int(i) for i in line]
	for j in line:
		mat[i,j] += 1
	lab = int(label_lines[i])
	mat[i, -1] = lab




