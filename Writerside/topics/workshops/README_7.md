# 7. Writing and Running Machine Learning

This guide introduces you to the basics of machine learning, walks you through building your first model, and explains how to run ML jobs on high-performance computing systems. You'll learn fundamental concepts, write code for a classification model, and discover resources for further exploration.

## Table of Contents
1. [Introduction](#introduction)
2. [Basic Concepts](#basic-concepts)
    - [Key Terminology](#key-terminology)
    - [Types of Machine Learning](#types-of-machine-learning)
3. [Building Your First ML Model](#building-your-first-ml-model)
4. [Running ML Jobs on HPC](#running-ml-jobs-on-hpc)
5. [Additional Resources](#additional-resources)

## Introduction
Machine learning is a field of artificial intelligence that enables systems to learn and improve from experience without explicit programming. Unlike traditional programming where humans write explicit instructions, machine learning algorithms learn patterns from data and make decisions based on that knowledge. This guide will introduce you to the fundamental concepts and help you create your first machine learning model.

Machine learning has three main elements as defined by experts in the field:
- **Representation**: How the model looks and how knowledge is represented
- **Evaluation**: How good models are differentiated and how programs are evaluated
- **Optimization**: The process for finding good models and how programs are generated[9]

## Basic Concepts

### Key Terminology

#### Features
In machine learning terminology, **features** are the **input** values used to make predictions. They are like the **x** values in a linear equation:

| Algebra | Machine Learning |
|--|--|
| y = ax + b | y = b + wx |[11]

Features are the characteristics or attributes of your data that the model uses to learn patterns. For example, in housing price prediction, features might include square footage, number of bedrooms, and location.

#### Labels
In machine learning terminology, the **label** is the thing we want to **predict**. It is like the **y** in a linear equation[11]. Labels are the target values you're trying to predict, such as house prices in a regression problem or categories in a classification problem.

#### Models
A **model** defines the relationship between the label (y) and the features (x)[11]. The model is trained on data to learn patterns and make predictions on new, unseen data. Different types of models, such as decision trees, neural networks, and support vector machines, have unique strengths and weaknesses for different applications[10].

#### Training and Inference
Machine learning has two main phases:

1. **Training**: Input data are used to calculate the parameters of the model.
2. **Inference**: The "trained" model outputs predictions from new input data[11].

During training, the model learns from examples. During inference, the model applies what it has learned to make predictions on new data.

### Types of Machine Learning

#### Supervised Learning
Supervised learning uses **labeled data** (data with known answers) to train algorithms to:
- **Classify Data**: Categorize inputs into discrete classes
- **Predict Outcomes**: Estimate continuous values[11]

Examples include spam detection, image recognition, and price prediction. Common algorithms include linear regression, logistic regression, and random forests[10][13].

#### Unsupervised Learning
Unsupervised learning uses patterns from unlabeled datasets, trying to understand patterns or groupings in the data without predefined categories[11]. It's about creating computer algorithms that can improve themselves without explicit guidance.

Examples include customer segmentation, anomaly detection, and dimensionality reduction. Common algorithms include k-means clustering and principal component analysis[10].

#### Reinforcement Learning
Reinforcement learning is based on a feedback system where the model receives rewards or penalties based on its actions, allowing it to learn optimal behavior through trial and error[11]. It's particularly useful in robotics, game playing, and autonomous systems.

#### Semi-Supervised Learning
Semi-supervised learning combines a small amount of labeled data with a large amount of unlabeled data during training[10]. This approach is useful when obtaining labeled data is expensive or time-consuming.

## Building Your First ML Model

1. **Set Up Your Environment**

   We'll be using Python with scikit-learn, a popular machine learning library that provides simple and efficient tools for data analysis and predictive modeling[16]. First, make sure you have Python installed, then install the necessary libraries:

    ```bash
    pip install numpy pandas matplotlib scikit-learn
    ```

2. **Create a Python Script**

   Create a file named `iris_classifier.py` with the following content. This will use the Iris dataset, often considered the "Hello World" of machine learning[12][14]:

    ```python
    import numpy as np
    import pandas as pd
    import matplotlib.pyplot as plt
    from sklearn.datasets import load_iris
    from sklearn.model_selection import train_test_split
    from sklearn.neighbors import KNeighborsClassifier
    from sklearn.metrics import accuracy_score, classification_report

    # Load the Iris dataset
    iris = load_iris()
    X = iris.data
    y = iris.target
    feature_names = iris.feature_names
    target_names = iris.target_names

    # Print basic information about the dataset
    print(f"Number of samples: {X.shape[0]}")
    print(f"Number of features: {X.shape[1]}")
    print(f"Features: {feature_names}")
    print(f"Classes: {target_names}")
    ```

3. **Explore and Visualize the Data**

   Add the following code to visualize the data:

    ```python
    # Visualize the data (first two features)
    plt.figure(figsize=(10, 6))
    for i, target_name in enumerate(target_names):
        plt.scatter(
            X[y == i, 0], X[y == i, 1], 
            label=target_name
        )
    plt.xlabel(feature_names[0])
    plt.ylabel(feature_names[1])
    plt.legend()
    plt.title('Iris Dataset - Sepal Length vs Sepal Width')
    plt.savefig('iris_visualization.png')
    plt.show()
    ```

4. **Split the Data**

   It's important to separate your data into training and testing sets to evaluate model performance[13]:

    ```python
    # Split the data into training and testing sets
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.3, random_state=42
    )
    ```

5. **Train a Model**

   Now we'll train a K-Nearest Neighbors classifier, which is simple yet effective for this dataset:

    ```python
    # Train a K-Nearest Neighbors classifier
    model = KNeighborsClassifier(n_neighbors=3)
    model.fit(X_train, y_train)
    ```

6. **Make Predictions**

   Use the trained model to make predictions on the test data:

    ```python
    # Make predictions on the test set
    y_pred = model.predict(X_test)
    ```

7. **Evaluate the Model**

   Add the following code to evaluate the model's performance:

    ```python
    # Evaluate the model
    accuracy = accuracy_score(y_test, y_pred)
    print(f"Accuracy: {accuracy:.2f}")
    print("\nClassification Report:")
    print(classification_report(y_test, y_pred, target_names=target_names))
    ```

8. **Experiment with Different Models**

   Try using different algorithms to see how they perform. For example, replace the KNN classifier with a Decision Tree or SVM:

    ```python
    # Using Decision Tree instead
    from sklearn.tree import DecisionTreeClassifier
    model = DecisionTreeClassifier(random_state=42)
    model.fit(X_train, y_train)
    
    # Or using SVM
    from sklearn.svm import SVC
    model = SVC(kernel='linear', random_state=42)
    model.fit(X_train, y_train)
    ```

## Running ML Jobs on HPC

1. **Create a Job Script**

   When running ML jobs on an HPC system, you'll need to create a job script. Create a file named `ml_job.sh` with the following content:

    ```bash
    #!/bin/bash
    #SBATCH --job-name=iris_ml
    #SBATCH --output=iris_ml.out
    #SBATCH --error=iris_ml.err
    #SBATCH --time=00:10:00
    #SBATCH --mem=1G
    #SBATCH --account=def-sponsor00

    # Load required modules
    module load python/3.9
    
    # Create a virtual environment and install required packages
    python -m venv $SLURM_TMPDIR/venv
    source $SLURM_TMPDIR/venv/bin/activate
    pip install numpy pandas matplotlib scikit-learn

    # Copy the script to the compute node
    cp iris_classifier.py $SLURM_TMPDIR
    cd $SLURM_TMPDIR

    # Run the script
    python iris_classifier.py
    
    # Copy results back to the submit directory
    cp iris_visualization.png $SLURM_SUBMIT_DIR
    ```

2. **Submit the Job**

   Use the `sbatch` command to submit your job script:

    ```bash
    sbatch ml_job.sh
    ```

3. **Monitor the Job**

   Check the status of your job using the `squeue` command:

    ```bash
    squeue -u $USER
    ```

4. **Check the Output**

   Once the job is complete, check the output files:

    ```bash
    cat iris_ml.out
    ```

5. **For GPU-Accelerated Jobs**

   If you're working with deep learning models that can benefit from GPU acceleration, modify your job script:

    ```bash
    #!/bin/bash
    #SBATCH --job-name=dl_job
    #SBATCH --output=dl_job.out
    #SBATCH --error=dl_job.err
    #SBATCH --time=01:00:00
    #SBATCH --mem=4G
    #SBATCH --gres=gpu:1
    #SBATCH --account=def-sponsor00

    # Load required modules
    module load python/3.9 cuda/11.4
    
    # Create a virtual environment and install required packages
    python -m venv $SLURM_TMPDIR/venv
    source $SLURM_TMPDIR/venv/bin/activate
    pip install numpy pandas matplotlib tensorflow torch

    # Copy your deep learning script
    cp deep_learning_model.py $SLURM_TMPDIR
    cd $SLURM_TMPDIR

    # Run the script
    python deep_learning_model.py
    
    # Copy results back
    cp -r results/ $SLURM_SUBMIT_DIR
    ```
