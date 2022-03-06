sed 's/\.3\.7\([AB]\)/\1    /' Pfalcifer.3.7.Fltr19.popmap.3.7.ppr_genclust.haps.ima > Pfalcifer.3.7.Fltr19.popmap.3.7.ppr_genclust.haps2.ima

grep -v 'dDocent' Pfalcifer.3.7.Fltr19.popmap.3.7.ppr_genclust.haps2.ima > Pfalcifer.3.7.Fltr19.popmap.3.7.ppr_genclust.haps2.ima.seqs

 grep 'dDocent' Pfalcifer.3.7.Fltr19.popmap.3.7.ppr_genclust.haps2.ima > Pfalcifer.3.7.Fltr19.popmap.3.7.ppr_genclust.haps2.ima.metadata
 