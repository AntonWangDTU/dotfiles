#!/usr/bin/zsh

#Write a bash shell script that puts all the positive numbers in the
#file ex1.dat into a file ex1.pos2, and all the negative numbers
#intoa file  ex1.neg2. Column position does not matter. The script must
#clean up after itself, so if any temporary files are used,
#they must be deleted as the last action.
#Put the date and a description of the files in the first lines
#of the resulting output files.

data='../data/ex1.dat'

cut -f1 $data >numbers
cut -f2 $data >>numbers
cut -f3 $data >>numbers

echo data >ex1.pos2.re
echo This file contains some stuff >>ex1.pos2.re

grep -v - numbers >>ex1.pos2.re
rm numbers

for i in {1..3}; do
  cut -f$i $data | grep '^-' >>ex1.neg2
  cut -f$i $data | grep '^[0-9]' >>ex1.pos2
done

sort ex1.pos2.re | uniq >pos1.sorted
sort ex1.pos2 | uniq >pos2.sorted
diff pos1.sorted pos2.sorted
