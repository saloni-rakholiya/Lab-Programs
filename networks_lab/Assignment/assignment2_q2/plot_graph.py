import sys
import matplotlib.pyplot as plt
import collections

file1="node3_data"
file2="node5_data"
file3="node7_data"
x_label="Average interarival time"
y_label="sequence number "
title="interarrival time vs sequence number "
image_name="graph_result"

d = collections.defaultdict(lambda: list())

file_lines = open(file1).readlines()
x1 = [float(line.strip().split()[0]) for line in file_lines]
y1 = [float(line.strip().split()[1]) for line in file_lines]
plt.plot(x1, y1, marker='o', color="red",markersize=0.5, label="node3")

file_lines = open(file2).readlines()
x1 = [float(line.strip().split()[0]) for line in file_lines]
y1 = [float(line.strip().split()[1]) for line in file_lines]
plt.plot(x1, y1, marker='o', color="blue",markersize=0.5 ,label="node5")

file_lines = open(file3).readlines()
x1 = [float(line.strip().split()[0]) for line in file_lines]
y1 = [float(line.strip().split()[1]) for line in file_lines]
plt.plot(x1, y1, marker='o', color="green",markersize=0.5, label="node7")

plt.xlabel(x_label)
plt.ylabel(y_label)
plt.title(title)
plt.legend()
plt.savefig(image_name)