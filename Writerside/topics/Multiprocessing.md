# Multiprocessing

Multiprocessing can be a massive improvement in computational efficiency. In many cases it is crucial to parallelize operations to complete tasks in a reasonable amount of time. It is also one of the main draws of the alliance HPC given the large number of high core-count CPU's available. Multiprocessing has many unique across different applications. In this guide we aim to provide an overview of both basic multiprocessing and distributed computing.

<tip>This is an introduction, more advanced documentation can be found <a href="https://google.ca">here</a>.</tip>

Python in particular has many nuances in parallel programming due to the Global Interpreter Lock (GIL). By using a multiprocessing library like the [built-in library](https://docs.python.org/3/library/multiprocessing.html) or [pathos library](https://pathos.readthedocs.io/en/latest/) one can effectively "side step the GIL" allowing for full performance parallelization **When Implemented Correctly**. More information can be found in [this medium article](https://medium.com/@kyeg/unleashing-pythons-potential-how-pathos-and-multi-processing-overcome-the-gil-lock-and-other-2e2d590b8dfd)

<warning>Many application libraries perform parallelization on their own, this often may conflict with user implemented parallelization. This occurs with libraries like <code>XGBoost</code> and <code>Sci-kit Opt</code></warning>

Conflicting parallelization libraries may cause locking or other erroneous behaviour. It is good practice to disable the backend parallelization if issues arise but not before this is confirmed to be problematic, simply be aware it may arise. If issues do arise many programs have options within the python source code to disable this behaviour like <code>Sci-kit Opt</code>. Other libraries like <code>XGBoost</code> require environment variable manipulation. If you are trying to perform multiprocessing and issues are arising, check to see if any libraries are conflicting with your design.

## Example

<code-block lang="Python">
import multiprocessing
import csv
import os

def worker(task_id):
    #Simulate some dummy computation
    result = {'TaskID': task_id, 'Result': task_id * 2}
    return result

def collect_results():
    num_cpu = int(os.getenv('SLURM_CPUS_PER_TASK', 10))  # Number of tasks to simulate
    num_task = 100
    with multiprocessing.Pool(processes=num_cpu) as pool:
    results = pool.map(worker, range(num_tasks))
    return results

#Collect results from multiprocessing tasks
results = collect_results()

#Save results to a CSV file
output_file = 'dummy_results.csv'
with open(output_file, mode='w', newline='') as file:
    writer = csv.DictWriter(file, fieldnames=['TaskID', 'Result'])
    writer.writeheader()
    writer.writerows(results)

#Check if the file was created
print(os.path.exists(output_file))

</code-block>


<code-block lang="Python">
from pathos.pools import ProcessPool
import time

def slow_function(x):
    time.sleep(1)  # Simulate a time-consuming operation
    return x * x

if __name__ == '__main__':
    num_cpu = int(os.getenv('SLURM_CPUS_PER_TASK', 10))  # Number of tasks to simulate
    pool = ProcessPool(nodes=num_cpu)  # Create a pool with 4 worker processes

    # Start an asynchronous map
    tasks = range(
    async_result = pool.amap(slow_function, range(100))
    
    print("Tasks submitted, now we can do other work...")
    
    # Check if the result is ready
    while not async_result.ready():
        print("Waiting for results...")
        time.sleep(0.5)
    
    # Get the results
    results = async_result.get()
    print("Results:", results)


</code-block>