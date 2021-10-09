# <Anomaly Detection from Categorical Data in a Distributed Log Dataset>
This repository contains scripts to a semi-supervised anomaly detection framework

## Description
Anomalies are data points that deviate significantly from other observations. They are also referred as outliers, peculiarities, exceptions and more. Anomaly detection aims at identifying these unusual objects and the resulting regularities or irregularities. It can be applied to different kinds of data, such as discrete, continous, univariate or multivariate data. It can be used to boost feature engineering and even replace classification or prediction objectives.

In semi-supervised setting for an anomaly detection algorithm, the training data only contain normal instances. A model is designed to learn normality from the training data and any deviation from this normality is termed as an anomaly.

## Research
This research focusses on an approach to design and evaluate an anomaly detection algorithm that identifies the "normal behaviour" and extracts the anomalous data instances from a log dataset. The algorithm runs in a semi-supevised setting, capable of discovering and constantly updating the normality while detecting and visualizing anomalous data instances to the user. Though there are significant amount of work done in handling anomalies form numeric data, the focus here is on categorical data and identifying anomalous behaviour from it. The log dataset have been reduced and modified for security and privacy reasons. The framework is based on the paper [A Semi-Supervised Approach to the Detection and Characterization of Outliers in Categorical Data] (https://ieeexplore.ieee.org/document/7412753)

## Usage
To get up and running with this project you need MATLAB. 

### Setting up dependencies
Install `Statistics and Machine Learning` toolbox.
Statistics and Machine Learning Toolbox provides functions and apps to describe, analyze, and model data. You can use descriptive statistics, visualizations, and clustering for exploratory data analysis; fit probability distributions to data; generate random numbers for Monte Carlo simulations, and perform hypothesis tests. Regression and classification algorithms let you draw inferences from data and build predictive models either interactively, using the Classification and Regression Learner apps, or programmatically, using AutoML.

### Datasets
* `trainFile`- training file data
* `testFile`- test file data
* `acc_map` - contains the information of the manual entry where anomaly has been introduced for accuracy metric calculation.

### Running the project
To run the main program, use the `anomalyDetect.m`. This file can be directly run and it calls the following function in the below sequence.

1. `mainFun.m` - This function does the context selection and also calculates the distance between the values in each attribute from the given csv file ( fileName )
2. `SymUnc.m` - Symmetric uncertainity value for one contigency table
3. `redundancyRem.m` - Redundancy removal of attribute for ocontext selection
4. `DILCA.m` - provides the distance matrix for each attribute, where each attribute is with a table with distance value between the values present.
5. `labelMap.m` - Maps the attribute value present in input fileName with respect to the label present in 'label'
6. `disInstance.m` - calculates the distance between the two given data files
7. `rankingData.m` - OS_score calculated for k data instances with maxk algorithm
8. `rankingminData.m` - OS_score assigned according to mink algorithm .

## References
Dino Ienco, Ruggero Pensa, Rosa Meo. A Semi-Supervised Approach to the Detection and Characterization of Outliers in Categorical Data. IEEE Transactions on Neural Networks and Learning Systems, IEEE, 2017, 28 (5), pp.1017-1029. pp.10.1109/TNNLS.2016.2526063. lirmm-01275509