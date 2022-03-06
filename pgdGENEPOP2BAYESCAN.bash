#!/bin/bash

# ex
# bash pgdGENEPOP2BAYESCAN.bash genepop_infile.txt

# edit this path for your computer
pgdJAR=~/Downloads/PGDSpider_2.1.1.5/PGDSpider2-cli.jar

# you shouldn't have to edit anything from here forward
inFILE=$1
inFORMAT=GENEPOP
outFileEXT=bayescan
outFORMAT=GESTE_BAYE_SCAN
spidFILE=./genepop2bayescan.spid

outFILE=$(basename $inFILE | sed "s/\.txt/\.$outFileEXT/")

source ~/anaconda3/etc/profile.d/conda.sh
conda activate pgdspider
java -Xmx1024m -Xms512m -jar $pgdJAR \
	-inputfile $inFILE \
	-inputformat $inFORMAT \
	-outputfile $outFILE \
	-outputformat $outFORMAT \
	-spid $spidFILE
