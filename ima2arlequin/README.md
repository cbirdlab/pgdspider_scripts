# ima2arlequin

These scripts are used to convert the `*.ima` file created by `rad_haplotyper` and convert it to arlequin.


_pgdspider fails when trying to convert these files, which are ima2 formatted_


## How To

There is hardcoding in these scripts that you will have to adjust to work for your specific files.


```bash
# split ima file into 2 almost tidy files that can be read by the R script
ima2arlequin_files.bash

``` 

Run the `ima2arlequin.R` script.  I made this in Rstudio and have not made it commandline friendly


```
# run the next bash file which converts the output from the R script to be closer to arlequin format
ima2arlequin_afterR.bash
```

I manually copied and pasted the population specific haplotype data to an arelquin file that was made with pgdspider using the genepop output from `rad_haplotyper`


While you are manually editing that arlequin file, don't forget to rename it and change the data type to DNA

```bash
# remove the tidy formated population identifiers from each pop (you will need to modify the code for your popnames)
ima2arlequin_aftermanualcopypaste.bash
```
