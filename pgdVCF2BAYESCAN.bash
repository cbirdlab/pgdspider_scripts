#!/bin/bash

# edit the variable definitions then run this file
# for help with pgd spider: java -Xmx1024m -Xms512m -jar $pgdJAR

pgdJAR=~/Downloads/PGDSpider_2.1.1.5/PGDSpider2-cli.jar
inFILE=../fltrVCF_4revision/Pfalcifer.3.7.Fltr20.2.randSNPperLoc.vcf
inFORMAT=VCF
outFileEXT=bayescan
outFORMAT=GESTE_BAYE_SCAN
spidFILE=vcf2bayescan.spid

outFILE=$(basename $inFILE | sed "s/\.vcf/\.$outFileEXT/")

source ~/anaconda3/etc/profile.d/conda.sh
conda activate pgdspider
java -Xmx1024m -Xms512m -jar $pgdJAR \
        -inputfile $inFILE \
        -inputformat $inFORMAT \
        -outputfile $outFILE \
        -outputformat $outFORMAT \
        -spid $spidFILE
