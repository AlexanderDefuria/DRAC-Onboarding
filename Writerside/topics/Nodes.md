# Nodes
Below is an overview of the main types of nodes typically found in a DRAC HPC environment. This is intended as a brief over


## 1. Login Nodes

**Purpose**
- Entry point to the cluster where you initially land after logging in.
- Lightweight tasks: editing files, preparing and submitting jobs, managing data.

**Important Usage Notes**
- Not intended for running resource-intensive computations.
- Long-running or CPU-heavy processes can degrade system performance for all users.

## 2. Compute Nodes

**Purpose**
- Actual workhorses of the cluster, executing the vast majority of computational tasks.
- Accessed via the job scheduler (e.g., `sbatch`, `srun`, `salloc` for Slurm).

**Important Usage Notes**
- Must be allocated through the scheduler to ensure fair resource sharing.
- Optimized for heavy computation, memory, or GPU workloads depending on node configuration.

## 3. Data Transfer Nodes (DTNs) or Data Mover Nodes

**Purpose**
- Designed to handle file transfers in and out of the cluster.
- Optimized with high-bandwidth connections and specialized configurations to move large datasets efficiently.

**Important Usage Notes**
- Preferred nodes for large or frequent data transfers (e.g., using `scp`, `rsync`, or [Globus](https://www.globus.org/)).
- Helps avoid overloading login nodes with data copy tasks.

