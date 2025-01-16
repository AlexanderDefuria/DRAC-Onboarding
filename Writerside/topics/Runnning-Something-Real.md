# Beginning With Python

So we have the very basics. Every program we write moving forward will have some kind of output that will be analyzed or at least used in some fashion. This may be the direct result of computation, length of runtime, or some other result. In this example we show how to perform some interesting computation, in the next section we show how to effectively manage these results.

In almost any project there are a substantial number of dependencies installed from some source, in python this is typically pip. As has become standard practice in python project management, all packages must be installed in a [virtual environment](https://docs.python.org/3/library/venv.html). Note that not every package or package version available through pip is available on compute nodes. The Alliance uses a limited mirror of PyPi with specifically chosen packages optimized for HPC use. The full list is [available here](https://docs.alliancecan.ca/wiki/Available_Python_wheels).

To begin we assume that you have some sort of python project with a `requirements.txt` already. If you do not we will be using an example project found [here](https://github.com/alexanderdefuria). Our default script will begin as follows, and will evolve throughout this guide.
<code-block lang="Bash">
#!/bin/bash
#SBATCH --time=00:15:00
#SBATCH --account=def-someuser
# Script will be here.
</code-block>

## Loading Python
Python is not loaded by default in compute node instances. As such we must specifically load the particular version of python we wish to use. This will give access to pip, virtualenv, etc.
<tip>Different python versions (3.10, 3.11, etc...) have different available packages. Make sure to double-check availability.</tip>

<code-block lang="Bash">
#!/bin/bash
#SBATCH --time=00:15:00
#SBATCH --account=def-someuser

#Load python 3.10 and scipy
module load StdEnv/2023 python/3.10
module load scipy-stack
</code-block>

## Virtual Environments
In order to install packages and run python scripts we must set up a virtual environment. This is where our python executable and packages will be installed. Using the default python executable can cause issues with programs, especially when trying to use external packages. For more information refer to the `virtualenv` [documentation](https://docs.python.org/3/library/venv.html).

<code-block lang="Bash" >
#!/bin/bash
#SBATCH --time=00:15:00
#SBATCH --account=def-someuser
module load StdEnv/2023 python/3.10
module load scipy-stack

#Setup Virtual Environment (venv)
virtualenv --no-download $SLURM_TMPDIR/venv
source $SLURM_TMPDIR/venv/bin/activate
pip install --no-index --upgrade pip
</code-block>

If you would like you can test this by running it the same way as the original `helloworld.sh` script. If you want to jump to running your own python file that is covered in the [next subsection](Runnning-Something-Real.md#running-the-python-script).

Note that the virtual environment is created in a temporary directory. This is useful as everything is contained close to compute node, improving compute time. Installing the environment to the login node for example will cause significant performance issues.

## Copying Files
## Install requirements.txt
Given some required packages they can now be installed *almost* as per usual. Due to the fact that the script executes on the compute node, in a different location, as opposed to the project folder where the script was dispatched using slurm, we need to reference the original `requirements.txt` using the absolute path. This can be determined by executing `pwd` in the same directory as `requirements.txt`.
<code-block>
# requirements.txt
scikit-learn==1.5.0
pandas==2.1.4
...
xgboost==2.0.0
</code-block>

<code-block lang="Bash" >
#!/bin/bash
#SBATCH --time=00:15:00
#SBATCH --account=def-someuser
module load StdEnv/2023 python/3.10
module load scipy-stack

#Setup Virtual Environment (venv)
virtualenv --no-download $SLURM_TMPDIR/venv
source $SLURM_TMPDIR/venv/bin/activate
pip install --no-index --upgrade pip

#Install requirements.txt
pip install --no-index -r /home/someuser/.../requirements.txt
</code-block>

## Running the Python Script 
Now that we have environment and dependencies set up we can actually run the python script. Below is an example python script with expected output.



<code-block lang="Bash" >
#!/bin/bash
#SBATCH --time=00:15:00
#SBATCH --account=def-someuser
module load StdEnv/2023 python/3.10
module load scipy-stack

#Setup Virtual Environment (venv)
virtualenv --no-download $SLURM_TMPDIR/venv
source $SLURM_TMPDIR/venv/bin/activate
pip install --no-index --upgrade pip

#Install requirements.txt
pip install --no-index -r /home/someuser/.../requirements.txt

#Run python script (below)
python3 example.py
</code-block>

<code-block lang="Python">
# Import necessary libraries
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression

# Load the Iris dataset
iris = load_iris()
X, y = iris.data, iris.target

# Split the dataset into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# Initialize and train the Logistic Regression model
model = LogisticRegression(max_iter=200)
model.fit(X_train, y_train)

# Make predictions on the test data
predictions = model.predict(X_test)

# Output the predictions
print("Predictions:", predictions)

# Calculate and print the accuracy
accuracy = model.score(X_test, y_test)
print(f"Accuracy: {accuracy:.2f}")

</code-block>

The following is some example output that might be returned from the above program. Storing results in simple log file text like this is not ideal for later parsing and analysis. The section ["Managing Results"](Managing-Results.md) is dedicated to best practices for managing these results more effectively.
<code-block>
Predictions: [1 0 2 1 1 0 1 2 1 1 2 0 0 0 0 1 2 1 1 2 0 2 0 2 2 2 2 2 0 0 0 0 1 0 0 2 1 0 0 0 2 1 1 0 0]
Accuracy: 0.98
</code-block>


<note>We now have python programs running on HPC!</note>
