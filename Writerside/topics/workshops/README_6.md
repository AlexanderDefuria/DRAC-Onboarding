
# 6. Transferring Files To and Fro!

1. **Upload a File to The Login Node**

    You can use `scp` to upload files to the login node. For example, to upload a file named `example.txt` to the login node, you can use the following command. Alternatively you can directly upload the file using JuptyerLab. 

    ```bash
    scp /path/to/local/example.txt <user>@magic.puzzlefish.org:/home/<user>/def-sponsor00/<user>/6-transferring_files/
    ```


2. **Create a Job Script**

    There is a barebones jobscript that you can use to run a python program that reads a CSV file and saves some information about the data to a CSV on the compute node. You can copy that file back to your local directory on the login node and interact with it there.

    ```bash
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
    ```

3. **Submit the Job**

    Use the `sbatch` command to submit your job script:

    ```bash
    sbatch run_python.sh
    ```

4. **Monitor the Job**
5. **Check the Output**

    We can check that the output file was created by using `ls` to list the files in the directory.

    ```bash
    ls
    ```

    And then we can use `cat` to view the contents of the output file.

    ```bash
    cat outdata.txt
    ```



6. **Cancel Jobs**

## Additional Resources

- [Compute Canada Documentation](https://docs.computecanada.ca/wiki/Running_jobs)
- [SLURM Job Scheduler](https://slurm.schedmd.com/documentation.html)
- [GCC Documentation](https://gcc.gnu.org/onlinedocs/)