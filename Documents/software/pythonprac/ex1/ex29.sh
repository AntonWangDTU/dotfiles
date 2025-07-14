#!/usr/bin/zsh

paste ../data/ex1.acc ../data/ex1.dat >ex1.tot
#Extract (cut) SwissProt ID and 3nd numerical data
#(column 1 and 5) from ex1.tot. Put results into a file ex1.res
cut -d$'\t' -f1,5 ex1.tot >ex1.res
#Find the 3 SwissProt ID's in ex1.res which have the largest number(s)
#in column 2, i.e. the top 3 entries. Display only the ID's.
echo 'Top 3 genes \n'
sort -rn -k 2 ex1.res | head -3 | cut -f1
#Find the lines (using grep) in orphans.sp which contain a GenBank
#accession number. There are 85, verify this.
#Note: An accession number is one or two capital letters and
#looks like this 'AB000114.CDS.1', i.e. Some letters followed by
#some numbers. The .CDS. part is kind of optional.
data="../data/orphans.sp"
echo "Acessions numbers in orphans.sp"
grep ">" $data | wc -l
#How many human genes with SwissProt IDs in orphans.sp exist ?
#How many of those are hypothetical ? (11)
echo "Human genes"
grep -c "_HUMAN" $data
#How many genes belong to the rat, and how many of those are precursors
#? (9) Note: A Swissprot ID looks like 'PARG_HUMAN' or 'TF1A_MOUSE',
#with the gene being before the underscore and the organism after the
#underscore.
cat $data | grep "_RAT" | grep -c "PRECURSOR"

#From the file ex1.res find the linels with positive numbers and put
#then into ex1.pos. The lines with negative number go into ex1.neg.
cut -f2 ex1.res | grep "^-" >ex1.neg
cut -f2 ex1.res | grep "^[0-9]" >ex1.pos
