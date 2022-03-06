# pgdspider_scripts
these are scripts that will help you run pgdspider from the command line

for converting an ima file from rad_haplotyper, goto the [ima2arlequin](./ima2arlequin) dir

## How To

1.  Identify the `pgd*.bash` file you want to run
2.  Manually edit that `pgd*.bash` file to have the right file paths
3.  Review the matching `*.spid` file to be sure it's doning what you wnat it to.
4.  Run that bash script you just manually edited and give the input file as an argument.

```bash
pgdSCRIPT.bash infile
```

## Adding to this dir

If the conversion you want to do doesn't have a bash script or spid here, you can either run pgdspider as it was intended, or contribute to this directory.

To contribute:
1.  Make the spid file using the pgdspider GUI, follow the naming conventions in other `*.spid` here
2.  Look at the `*.spid` to see the official name given to the file formats you are converting from and to
3.  make a copy of the most similar exising `pgd*bash` script and rename it following the format of the other scripts
4.  update the variables in your `pgd*bash`, don't forgot to update the variable pointing to the `*.spid` file
5.  run `pgd*.bash`
6.  if successful, push the changes to this repo
