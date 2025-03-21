
## Compiling and Running a R Program

1. **Create a R Program**

    Also commonly used in data analysis, R is a programming language that is especially powerful for data exploration, visualization, and statistical analysis. We are going to create a simple visualization program that plots some random data. The R script we are using is included in this directory.


2. **Create a Job Script**

    Note that unlike the previous examples we have a file we need the program to read. We will need to copy this file to the compute node before running the program. Create a file named `compile_and_run.sh` with the following content:

    ```bash
    #!/bin/bash
    #SBATCH --job-name=count_rows
    #SBATCH --output=result.out
    #SBATCH --error=result.err
    #SBATCH --time=00:10:00
    #SBATCH --mem=1G

    module load python/3.8
    cp /path/to/your/csvfile.csv $SLURM_TMPDIR

    # Create a virtual environment and install pandas.
    python -m venv $SLURM_TMPDIR/venv
    source $SLURM_TMPDIR/venv/bin/activate
    pip install pandas

    python count_rows.py $SLURM_TMPDIR/csvfile.csv
    ```

3. **Submit the Job**

    Use the `sbatch` command to submit your job script:

    ```bash
    sbatch run_python.sh
    ```

4. **Monitor the Job**
5. **Check the Output**
6. **Cancel Jobs**

## Additional Resources

- [Compute Canada Documentation](https://docs.computecanada.ca/wiki/Running_jobs)
- [SLURM Job Scheduler](https://slurm.schedmd.com/documentation.html)
- [GCC Documentation](https://gcc.gnu.org/onlinedocs/)