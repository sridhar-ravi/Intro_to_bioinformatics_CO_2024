#!/bin/bash
#SBATCH --account=teaching
#SBATCH --reservation=teaching
##SBATCH --ntasks=4               # number of MPI processes
#SBATCH --cpus-per-task 4
#SBATCH --mem-per-cpu=4G      # memory; default unit is megabytes
#SBATCH --time=0-3:00           # time (DD-HH:MM)
#SBATCH --output=%x-%j.out

ml samtools

find . -name "*mysample*.sam" | parallel -j 4 "time samtools view -@ 6 -bS {} | samtools sort -o {.}_mt_sorted.bam"


