# 3. Running Parallel Jobs

1. **Create a Program**

    We want to run a few jobs in parallel. We're going to create a simple program that takes a number as input and prints the square of that number. We'll pass the number of the job as an argument to the program. There is an example saved in the directory called `myapplication.sh`.

    ```bash
    #!/bin/bash

    # Square the input integer
    input=$1
    result=$((input * input))

    # Print the result
    echo "The square of $input is $result"
    ```

2. **Create a Job Script**

    Create a file named `array_job.sh` with the following content. The `$SLURM_ARRAY_TASK_ID` variable will be set to the index of the job in the array. We'll be creating an array of 5 jobs.

    ```bash
    #!/bin/bash
    #SBATCH --account=def-sponsor00
    #SBATCH --time=0-0:5
    #SBATCH --array=1-5
    
    ./myapplication.sh $SLURM_ARRAY_TASK_ID
    ```

3. **Submit the Job**

    Use the `sbatch` command to submit your job script:

    ```bash
    sbatch array_job.sh
    ```

4. **Monitor the Job**
5. **Check the Output**
6. **Cancel Jobs**

## Additional Resources

- [Compute Canada Documentation](https://docs.computecanada.ca/wiki/Running_jobs)
- [SLURM Job Scheduler](https://slurm.schedmd.com/documentation.html)
