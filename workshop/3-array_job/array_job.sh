#!/bin/bash
#SBATCH --account=def-sponsor00
#SBATCH --time=0-0:5
#SBATCH --array=1-10

chmod 777 ./myapplication.sh
./myapplication.sh $SLURM_ARRAY_TASK_ID