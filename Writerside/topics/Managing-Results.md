# Managing Results

In the previous section we covered running python programs and saw some (largely) unstructured output in the `slurm-XXXXXX.out` file. For small amounts of output and data this can be more than fine. In cases where there is large amounts of output generated, especially non-textual data, this is clearly less than ideal. As such we can opt to output more complex files and data directly on the compute node, and copy them back to the login node when the computation is done.

One can also write directly back to the login node with output, similar to the log file but for arbitrary data. The benefit of this is that we can have periodic saving of results, the downside is that repeated writes will degrade performance and cause higher than under-utilization of the CPU. As a general rule of thumb the further the storage location from the compute node, the more overhead and waste of resources will occur. 

Opinions on how to solve this problem may differ. This guide takes the stance that results should be periodically and repeated saved to the compute node storage, and at the end of program execution the results should be copied back to the login node (or elsewhere) for subsequent analysis and reliable storage.

## Copying Files to Nodes

The workload manager provides functionality to copy large numbers of files between login and compute nodes efficiently at both the start and end of the program. This takes place within the bash script passed to `sbatch`. In the context of a single or serial job no special command is required, in the context of an array job, files must be copied to and from multiple jobs, as such the `srun` command may be used. More information about multi-job setups can be found in the [](Multiprocessing.md) section. More information about copying files can be found in the [](Copying-Files.md) section.

### Single Job
<code-block lang="Bash">
#!/bin/bash
#SBATCH --time=00:15:00
#... preamble ...
cp -r $HOME_DIR/some_dir $SLRUM_TMPDIR
#...Some Computation Here...
cp -r results/ $HOME_DIR/results
</code-block>

### Array Job
<code-block lang="Bash">
#!/bin/bash
#SBATCH --time=00:15:00
#... preamble ...
srun --ntasks=$SLURM_NNODES --ntasks-per-node=1 cp -r $HOME_DIR/some_dir $SLRUM_TMPDIR
#... Some Computation Here ...
cp -r results/ $HOME_DIR/results/$SLURM_ARRAY_TASK_ID/
</code-block>

## Outputting Results
In the previous subsection we showed how to copy files between compute and login nodes in both directions. In most cases you will have an output method that has already been functional for your purposes. In the case of single job projects this should not largely need to change if it is a significant burden but may still benefit from adjusting to a  multiprocessing output paradigm, this will not be covered here but best practices are available elsewhere (avoiding of I/O locking and race conditions, and more).

Multinode jobs in particular pose a challenge as thy do not share a local filesystem, thus the appropriate input and output files must be copied between the compute and login nodes. This is shown [here](Managing-Results.md#array-job). Dedicating some time to determine a simple file structure that can be joined easily without much subsequent computational effort will likely be beneficial later. Something as simple as maintaining a format across all files that can be concatenated or joining on some id. Creating a secondary job to do this might be beneficial.

