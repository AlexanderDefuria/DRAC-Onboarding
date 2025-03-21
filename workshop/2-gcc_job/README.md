
## Compiling and Running a C Program

1. **Create a C Program**

    Create a file named `hello.c` with the following content. There is also a example `c_app.c` file in this directory if you are not sure what to write.

    ```c
    #include <stdio.h>

    int main() {
        printf("Hello, Compute Canada!\n");
        return 0;
    }
    ```

2. **Create a Job Script**

    Create a file named `compile_and_run.sh` with the following content. Likewise there is a example `compile_job.sh` file in this directory if you are not sure what to write. Feel free the reference that for more detailed explanations.

    ```bash
    #!/bin/bash
    #SBATCH --time=00:15:00
    #SBATCH --account=def-sponsor00
    gcc hello.c -o hello
    ./hello
    ```

3. **Submit the Job**

    Use the `sbatch` command to submit your job script:

    ```bash
    sbatch compile_and_run.sh
    ```

4. **Monitor the Job**
5. **Check the Output**
6. **Cancel Jobs**

## Additional Resources

- [Compute Canada Documentation](https://docs.computecanada.ca/wiki/Running_jobs)
- [SLURM Job Scheduler](https://slurm.schedmd.com/documentation.html)
- [GCC Documentation](https://gcc.gnu.org/onlinedocs/)