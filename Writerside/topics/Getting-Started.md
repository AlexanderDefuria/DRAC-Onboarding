# Getting Started

This guide is designed to get up and running as a new user to the Digital Research Alliance of Canada. It covers the following topics:

- 

Below is an overview of the main types of nodes typically found in a DRAC HPC environment. This is intended as a brief over

---

## 1. Login Nodes

**Purpose**
- Entry point to the cluster where you initially land after logging in.
- Lightweight tasks: editing files, preparing and submitting jobs, managing data.

**Important Usage Notes**
- Not intended for running resource-intensive computations.
- Long-running or CPU-heavy processes can degrade system performance for all users.

**References**
- [1]: "These node types are relatively common for other HPC centers … [Use for]: editing scripts, moving files, scheduling jobs"
- [7]: "Login nodes are like a lobby area for the HPC … They are where you end up when you first enter."

---

## 2. Compute Nodes

**Purpose**
- Actual workhorses of the cluster, executing the vast majority of computational tasks.
- Accessed via the job scheduler (e.g., `sbatch`, `srun`, `salloc` for Slurm).

**Important Usage Notes**
- Must be allocated through the scheduler to ensure fair resource sharing.
- Optimized for heavy computation, memory, or GPU workloads depending on node configuration.

**References**
- [1]: "This is where jobs are executed after being passed to the scheduler … Intended for heavy computation."
- [7]: "The vast majority of the nodes in an HPC are compute nodes; they are the workhorses of the HPC."

---

## 3. Data Transfer Nodes (DTNs) or Data Mover Nodes

**Purpose**
- Designed to handle file transfers in and out of the cluster.
- Optimized with high-bandwidth connections and specialized configurations to move large datasets efficiently.

**Important Usage Notes**
- Preferred nodes for large or frequent data transfers (e.g., using `scp`, `rsync`, or [Globus](https://www.globus.org/)).
- Helps avoid overloading login nodes with data copy tasks.

---