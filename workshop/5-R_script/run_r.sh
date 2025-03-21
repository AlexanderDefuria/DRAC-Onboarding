#!/bin/bash
#SBATCH --job-name=serial_job
#SBATCH --output=serial_job.out
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:15:00
#SBATCH --account=def-sponsor00

module load gcc/12.3 r/4.4.0

rm -rf ./R_libs/
mkdir -p ./R_libs/
chmod 777 ./R_libs/
export R_LIBS=./R_libs/

Rscript example.r

cp ./* $SLURM_SUBMIT_DIR