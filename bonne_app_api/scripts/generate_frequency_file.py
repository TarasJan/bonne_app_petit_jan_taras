#! /usr/bin/python3

from collections import Counter

file = open("tmp/ingredients.txt")
text = file.read()
file.close()

c = Counter(text.split())

output_file = open("tmp/frequencies.txt", "w")
for k,v in c.most_common():
  output_file.write(f'{k}: {v}\n')

output_file.close()


