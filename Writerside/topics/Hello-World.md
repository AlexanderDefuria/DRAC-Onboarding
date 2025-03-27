# Hello World

To get started with a simple practical example, we assume that you have successfully logged in to one of the nodes listed in [Introduction to HPC](Nodes.md). You should be on a [login node](Nodes.md#1-login-nodes) for some general purpose system to start this guide.

To schedule and manage jobs submitted on our clusters, we use the [SLURM Workload Manager](https://en.wikipedia.org/wiki/Slurm_Workload_Manager). Documentation can be found [here](https://slurm.schedmd.com/documentation.html). For now that will not be needed.


<warning>
All jobs must be submitted via the scheduler!
</warning>
The login nodes are not suitable to computation, it will likely be slower and more limiting than running things locally. 

Instead, we can dispatch slurm scripts as seen below. This script includes 3 key lines that will appear often. The first `#!/bin/bash`, specifying it is a bash script. `#SBATCH --time=00:15:00` specifying a time limit of 15 minutes (Hours:Minutes:Seconds). `#SBATCH --account=def-someuser` specifies who is submitting this job (your account). And finally the remainder of the the script contains your code, in this case this simple hello-world program. This program is stored as `helloworld.sh` somewhere in your [project space](Navigating-the-Environment.md).

<code-block lang="Bash" >
#!/bin/bash
#SBATCH --time=00:15:00
#SBATCH --account=def-someuser
echo 'Hello, world!'
sleep 30
</code-block>

To run this script we simply execute the following:
<code-block lang="Bash" prompt="$">sbatch helloworld.sh</code-block>

Running locally you might expect the output to be printed directly to the terminal. In this case if that happens, it is a problem. All the output of a slurm job, once run, will be printed to a `.out` file in the directory the job was run from. There may be some delay between dispatching your job and seeing output, this is okay and not a problem. To check on the status of jobs we can run the following command:
<code-block lang="bash" prompt="$">squeue -u $USER</code-block>

This should output the following in a `.out` file:
<code-block lang="Bash">Hello World!</code-block>
The job may be in one of several states, Pending, Running, or some other state related to a Compute Node status.

Once the job has been accepted and you should see a new file in your current directory `slurm-XXXX.out`. Within this file there should be the output of `helloworld.sh`. You can check this using vim, or cat.

<note>Congratulations! You have your first HelloWorld program on HPC!</note>




