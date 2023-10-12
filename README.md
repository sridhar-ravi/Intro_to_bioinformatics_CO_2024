# Introduction to Bioinformatics CAC 2023

# Class Activity #1 – Working with Modules

If you have not done yet, ssh to your account on Frontenac or Alliance cluster eg: Graham or Cedar

```
ssh -X saxxxxx@login.cac.queensu.ca
ssh -X username@graham.computecanada.ca
```

Create a folder in scratch called bioinformatics and go into it
Type the following command in your terminal to see which versions of `samtools` avaible on out software stack
```
module spider samtools
module load samtools
module list
```
Now switch to `samtools` version `1.16.1` using the `module load` command.
Try loading module `blast+`
You can also use module spider with wildcard `$ module -r spider '.*blast.*'`
Now let’s see if we have a module called “Bioconductor”

Let try loading `busco` and use command `module list` to view all loaded modules

# Class Activity #2 – Installing python packages

DendroPy is a Python library for phylogenetic computing https://dendropy.org/index.html

Find all available versions of `dendropy` and `pyfasta` in the wheelhouse

Install `dendropy` and `pyfasta`

Run `pip freeze` to generate `requirements.txt` file

Check your installation:
```
python -c "import dendropy; print(dendropy.__version__)"
```
Create a new virtual environment and install packages using 'requirements.txt'

# Class Activity #3 - Installing software using Apptainer

Search for containers https://hub.docker.com/

Some tools such as `qiime2` are hosted on their own repository https://quay.io/repository/qiime2/core?tab=tags

````
module load apptainer
apptainer build qiime2-2023.5.sif docker://quay.io/qiime2/core:2023.5
````

Recipe file/definition file
```
Bootstrap: docker
From: ubuntu:22.04
Stage: build
%post
    apt-get update && apt-get install -y git
```

Now build a container from the recipe file/definition file

```
apptainer build ubuntu_test_git.sif my_test_def_file.def

apptainer build --sandbox ubuntu_sandbox ubuntu_test_git.sif

```

# Class Activity #5 – Text editing

View fasta header

```
grep "^>" edited.fa
```
Remove spaces from the reference seq
```
sed 's, ,|,g' 
```
Print transcript id and chromosomal position
```
awk -F '[ |,]' '{ if ($0 ~ /^>/) { print $1"|"$3;} else { print $0;}}'
