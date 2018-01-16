# A utility to sample 10000 randomly from the text file

import random

max_index = 700000000
num_sample= 10000

indices = set()

for i in range(num_sample):
    x = random.randint(0, max_index)
    while x in indices:
        x = random.randint(0, max_index)
    indices.add(x)
#    print x

rows = []
with open("/home/andrew/QA_HOME/test_100milion/xaa700m_row.csv", "rb") as f:
    for i in range(max_index):
        line = f.readline()
        if i in indices:
            rows.append(line)

#print rows

# Write an output file:
file = open("xaa700m_row_10000_random_col1.csv", "wb")

for item in rows:
    file.write(item)

file.close()

