# Running a Basic Serial Job on Compute Canada

1. **Create a Job Script**

    Create a file named `job.sh` with the following content:

    ```bash
    #!/bin/bash
    #SBATCH --time=00:15:00
    #SBATCH --account=def-sponsor00
    echo 'Hello, world!'
    sleep 1000 # Sleep for a thousand seconds



2. **Submit the Job**

    Use the `sbatch` command to submit your job script:

    ```bash
    sbatch job.sh
    ```

3. **Monitor the Job**

    Check the status of your job using the `squeue` command:

    ```bash
    squeue -u $USER
    ```

4. **Check the Output**

    Once the job is complete, check the output file `serial_job.out` for results.

    ```bash
    cat slurm-<job_id>.out
    ```

5. **Cancel Jobs**

    If you need to cancel a job, use the `scancel` command:

    ```bash
    scancel <job_id>

6. **Check the Job Efficiency**

    To check the efficiency of your job, use the `seff` command:
    ```bash
    seff <job_id>
    ```


## Additional Resources

- [Compute Canada Documentation](https://docs.computecanada.ca/wiki/Running_jobs)
- [SLURM Job Scheduler](https://slurm.schedmd.com/documentation.html)
