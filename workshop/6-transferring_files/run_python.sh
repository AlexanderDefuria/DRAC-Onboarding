#!/bin/bash
#SBATCH --output=python_job.out
#SBATCH --job-name=python_job
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:15:00
#SBATCH --account=def-sponsor00

module load python/3.11
module load scipy-stack
cp csvfile.csv $SLURM_TMPDIR

# Create a virtual environment and install pandas.
python -m venv $SLURM_TMPDIR/venv
source $SLURM_TMPDIR/venv/bin/activate

pip install pandas

python some_analysis.py

cp ./outdata.txt $SLURM_SUBMIT_DIR
