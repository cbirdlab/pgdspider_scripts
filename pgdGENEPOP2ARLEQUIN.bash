#!/bin/bash

pgdJAR=~/Downloads/PGDSpider_2.1.1.5/PGDSpider2-cli.jar
inFILE=~/Projects/PuntioplitesFalcifer/fltrVCF_4revision/Pfalcifer_3_7_Fltr19_popmap_3_7_ppr_genclust_haps_genepop.txt
inFORMAT=GENEPOP
outFileEXT=arp
outFORMAT=ARLEQUIN
spidFILE=~/Projects/PuntioplitesFalcifer/pgdspider/genepop2arlequin.spid

outFILE=$(basename $inFILE | sed "s/\.txt/\.$outFileEXT/")

source ~/anaconda3/etc/profile.d/conda.sh
conda activate pgdspider
java -Xmx1024m -Xms512m -jar $pgdJAR \
	-inputfile $inFILE \
	-inputformat $inFORMAT \
	-outputfile $outFILE \
	-outputformat $outFORMAT \
	-spid $spidFILE
