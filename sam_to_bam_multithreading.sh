#!/bin/bash
#SBATCH --account=teaching
#SBATCH --reservation=teaching
#SBATCH --cpus-per-task 2
#SBATCH --mem-per-cpu=4G      # memory; default unit is megabytes
#SBATCH --time=0-3:00           # time (DD-HH:MM)
#SBATCH --output=%x-%j.out

ml samtools

for files in *.sam
do
time samtools view -@ 4 -b ${files} | samtools sort -o ${files%.*}_mt_sorted.bam
done

