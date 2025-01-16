# Monitoring Jobs

Jobs should be using all or almost all the resources allocated to them. Poor resource usage efficiency takes up resources that could be allocated to other projects that need them. Particularly poor efficicency may lower the priority of your submitted jobs. 

There are three primary ways to monitor jobs, their status, errors, and efficiency.

<code>squeue -u $USER</code>
: Check currently running and queued jobs status before or during run time.

`seff <job-id>`
: Summarize performance and usage statistics post job completion.

Calcul Quebec Portal
: Full information portal to view advanced statistics and detailed information about all jobs submitted on the Calcul Quebec clusters (Beluga and Narval). Available [here for Beluga](https://portail.beluga.calculquebec.ca/) and [here for Narval](https://portail.narval.calculquebec.ca/)

## Under Utilization
It can often be the case that one begins with a high number of concurrent tasks that are executed on a node, and over the course of execution certain tasks end early and some end late. This is typically not a problem and is somewhat expected. Cases that should be avoided are below, where the majority of the execution time is taken by a small minority of processes leading to severe under utilization of resources. The same is true of both compute and memory.

![process-crashing.png](process-crashing.png)


![joblist.png](joblist.png)