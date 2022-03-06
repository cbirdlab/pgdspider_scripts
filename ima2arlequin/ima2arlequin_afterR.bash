#!/bin/bash

# run this script after the r script to get data near ready for arlequin


sed -i \
	-e 's/ .._Pfa..[0-9]B B /              /' \
	-e 's/ A / 1 /' Pfalcifer.3.7.Fltr19.popmap.3.7.ppr_genclust.haps2.ima.prearp
