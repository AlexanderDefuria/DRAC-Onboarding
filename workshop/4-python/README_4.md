
# 4. Writing and Running a Python Program

1. **Create a Python Program**

    We are going to use a python library to read a CSV file and count the number of rows in it. We have to provide the file name as an argument to the program. Create a file named `count_rows.py` with the following content. There is also a example `count_rows.py` file in this directory if you are not sure what to write.

    ```python
    import pandas as pd

    def count_rows(file_name):
        df = pd.read_csv(file_name, index_col=False)
        print(df.head())
        print(f"Number of rows in {file_name}: {len(df)}")
    
    if __name__ == "__main__":
        import sys
        count_rows(sys.argv[1])
    ```
    Note that we are using a library `pandas` so we have to load it before running the program. We will do this in the job script. By using a virtual environment we can improve reproducibility and avoid conflicts with other libraries.

2. **Create a Job Script**

    Note that unlike the previous examples we have a file we need the program to read. We will need to copy this file to the compute node before running the program. Create a file named `compile_and_run.sh` with the following content:

    ```bash
    #!/bin/bash
    #SBATCH --job-name=count_rows
    #SBATCH --output=result.out
    #SBATCH --error=result.err
    #SBATCH --time=00:10:00
    #SBATCH --mem=1G

    module load python/3.11
    module load scipy-stack
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