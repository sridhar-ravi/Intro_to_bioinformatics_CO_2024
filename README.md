# Introduction to Bioinformatics CAC 2024

# Class Activity #1 – Working with Modules

If you have not done yet, ssh to your account on Frontenac or Alliance cluster eg: Graham or Cedar. If you don't have an Alliance account, use the guest account from your moodle. 

```
ssh -X username@graham.computecanada.ca
ssh -X userxxxx@coss-a.c3.ca
```

Create a folder in your `home` or `scratch` called bioinformatics and go into it
Type the following command in your terminal to see which versions of `samtools` avaible on out software stack
```
module spider samtools
module load samtools
module list
```
Now switch to `samtools` version `1.16.1` using the `module load` command.
Try loading module `blast+`
You can also use module spider with wildcard `module -r spider '.*blast.*'`. Now let’s see if we have a module called “Bioconductor”

Let try loading `busco` and use command `module list` to view all loaded modules. Pay attention to `StdEnv`.

https://docs.alliancecan.ca/wiki/Standard_software_environments, https://docs.alliancecan.ca/wiki/Standard_software_environments


# Class Activity #2 – Installing python packages

DendroPy is a Python library for phylogenetic computing https://dendropy.org/index.html

Find all available versions of `dendropy` and `fastasplit` in the wheelhouse

Install `dendropy` and `fastasplit`

Run `pip freeze` to generate `requirements.txt` file

Check your installation:
```
python -c "import dendropy"
python -c "import dendropy; print(dendropy.__version__)"
```
Create a new virtual environment and install packages using 'requirements.txt'
https://docs.alliancecan.ca/wiki/Python

# Class Activity #3 - Installing software using Apptainer

Search for containers https://hub.docker.com/

If you decide to build an image make sure to set `cache` and `tmp` for `apptainer` in a filesystem where you have read/write permission 

```
mkdir -p /scratch/$USER/apptainer/{cache,tmp}
export APPTAINER_CACHEDIR="/scratch/$USER/apptainer/cache"
export APPTAINER_TMPDIR="/scratch/$USER/apptainer/tmp"
```

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
https://docs.alliancecan.ca/wiki/Apptainer
# Class Activity #4 – Using mdsum

Lets download a file and verify integrity
     
```
wget https://ftp.ncbi.nlm.nih.gov/blast/db/18S_fungal_sequences.tar.gz
wget https://ftp.ncbi.nlm.nih.gov/blast/db/18S_fungal_sequences.tar.gz.md5
```
Verify integrity
```
md5sum -c 18S_fungal_sequences.tar.gz.md5
```
   
Split fasta file using pyfasta (hint: source ~/ENV/bin/activate)
```
pyfasta split -n 6 Triticum_aestivum_subset.IWGSC.cds.all.fa
```
# Class Activity #5 – Text editing

Clone repository `git clone https://github.com/sridhar-ravi/intro_to_bioinformatics_cac_2023.git`

View fasta header

```
grep "^>" Triticum_aestivum_subset.IWGSC.cds.all.fa
```
Remove spaces from the reference seq
```
sed 's, ,|,g' 
```
Print transcript id and chromosomal position
```
awk -F '[ |,]' '{ if ($0 ~ /^>/) { print $1"|"$3;} else { print $0;}}'
```
# Class Activity #6 – Job submission

Copy *.sam files from `/global/project/Workshop2023/IntroBioInfo/`
