# GPU Compute

The Digital Research Alliance of Canada provides robust GPU-accelerated computing resources through its national HPC infrastructure. This guide details practical aspects of GPU job execution, including infrastructure specifications, allocation strategies, and concrete scripting examples.

## GPU Infrastructure and Allocation
Canada's HPC systems offer 3,278 GPUs across five major clusters (Niagara, Béluga, Cedar, Graham, Narval) as of March 2022[1]. The 2025 infrastructure renewal introduces fractional GPU scheduling via NVIDIA's Multi-Instance GPU (MIG) technology, enabling finer resource allocation[7]:

| GPU Instance Type | Fraction | RGU Value |
|-------------------|----------|-----------|
| A100-40gb (Full)  | 100%     | 4.0       |
| A100-3g.20gb      | 50%      | 2.0       |
| H100-80gb (Full)  | 100%     | 12.2      |
| H100-2g.20gb      | 28%      | 3.5       |

Researchers request GPU resources through Slurm using core-year and GPU-year allocations[7]. The Resource Allocation Competition (RAC) process requires justification of GPU:CPU:memory ratios[4].

## Requesting GPUs via Slurm
Basic GPU requests use the syntax:
```bash
#SBATCH --gpus-per-node=[type:]quantity
```
Example requests:
```bash
--gpus-per-node=2          # Any GPU type
--gpus-per-node=a100:1     # Specific A100 GPU
--gpus-per-node=h100-2g.20gb:3  # Fractional H100 instances[7]
```

## Example Job Scripts

**Single-GPU Training (PyTorch):**
```bash
#!/bin/bash
#SBATCH --account=def-research
#SBATCH --gpus-per-node=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=32G
#SBATCH --time=1:00:00

module load python/3.10 cuda/12.2
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install torch torchvision --no-index

python train.py --batch-size 512 --epochs 50
```


**Multi-Node Distributed Training:**
```bash
#!/bin/bash
#SBATCH --nodes=4
#SBATCH --gpus-per-node=a100:4
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=0
#SBATCH --exclusive

srun python -m torch.distributed.launch \
    --nproc_per_node=$SLURM_GPUS_PER_NODE \
    --nnodes=$SLURM_JOB_NUM_NODES \
    train_ddp.py --batch-size 1024
```


**Whole Node Utilization (Cedar):**
```bash
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --gpus-per-node=p100l:4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=0
#SBATCH --time=28-00:00

nvidia-smi --query-gpu=name,memory.total \
           --format=csv,noheader
./multi_gpu_simulation --device all
```


## Advanced Configuration
For memory-intensive workloads:
```bash
#SBATCH --mem-per-gpu=40G  # HBM2e memory allocation
export CUDA_MPS_PIPE_DIRECTORY=/tmp/nvidia-mps
export CUDA_MPS_LOG_DIRECTORY=/tmp/nvidia-log
```


The Alliance recommends:
1. Matching CPU cores to GPU count:
    - Béluga: ≤10 CPU cores/GPU
    - Cedar P100: ≤6 CPU cores/GPU
    - Graham: ≤16 CPU cores/GPU[6]

2. Using `--exclusive` flag for full-node reservations
3. Requesting MIG instances for small-batch inference[7]

## Performance Considerations
GPUs demonstrate optimal performance when:
- Batch sizes ≥512 (vision) / ≥1024 (language models)
- Utilizing Tensor Cores through mixed precision
- Leveraging NVLink for multi-GPU communication[1][2]

Researchers should validate GPU necessity through profiling - small models (<1M parameters) often run faster on CPU clusters[5]. The Alliance provides benchmarking tools through its HPC helper repository[3].

Citations:

[1] https://alliancecan.ca/sites/default/files/2024-03/Digital%20Research%20Alliance%20of%20Canada%20HPC%20Strategy.pdf
[2] https://www.hbs.edu/research-computing-services/Shared%20Documents/Training/Leveraging%20GPUs%20on%20the%20HBSGrid.pdf
[3] https://github.com/DSL-Lab/HPC_helper
[4] https://alliancecan.ca/en/document/678
[5] https://docs.alliancecan.ca/wiki/PyTorch
[6] https://docs.alliancecan.ca/wiki/Using_GPUs_with_Slurm
[7] https://docs.alliancecan.ca/wiki/Allocations_and_compute_scheduling
[8] https://docs.alliancecan.ca/wiki/R
[9] https://docs.alliancecan.ca/wiki/Graham
[10] https://alliancecan.ca/en/services/advanced-research-computing/accessing-resources/resource-allocation-competition/available-resources
[11] https://docs.mila.quebec/Extra_compute.html
[12] https://www.youtube.com/watch?v=oPRu90GAALU
[13] https://docs.alliancecan.ca/wiki/Modules_sse3
[14] https://www.sharcnet.ca/my/help/gpu
