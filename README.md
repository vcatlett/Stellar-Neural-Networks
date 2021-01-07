# Stellar-Type-Neural-Networks
Completed as part of a project for the Fall 2019 section of PHYS 3330: Numerical Methods at the University of Texas at Dallas.

Group: [Victoria Catlett](https://github.com/vcatlett), [Amanda Ehnis](https://github.com/anehnis), and [Evan Meade](https://github.com/Evan-Meade)

Our project report is included in this repository as ```Report_Catlett_Ehnis_Meade.pdf```, which contains a full description of the projects and our sources. Essentially, this project explored the implementation of neural networks in MatLab using both built-in and custom methods. The networks were used to solve different astrophysical classification problems.

This repository serves as an appendix to our report, containing only the final versions of our code. All of the code in this repository was created in MatLab.

```Classification_Stars``` contains the scripts and data to create a classification neural network which estimates the spectral type of a star from its B-V color index and absolute magnitude.

```Convolutional_Galaxies``` contains the scripts to modify the AlexNet convolutional neural network to classify galaxies as smooth, featured, or artifacts (not actually a galaxy). The data comes from the [2013 Kaggle Galaxy Challenge](https://www.kaggle.com/c/galaxy-zoo-the-galaxy-challenge/overview). Per the rules, we cannot post the data (or any modified versions) publicly. Instead, you may download and sort the data yourself, and we have included the necessary folders in the repository. Right now, the folders contain pictures of V. Catlett's cats as placeholders for the galaxy images. 

```NNStart_Stars``` contains the master script and data to call the built-in neural network methods from *NNStart* on the spectral type data. Each network classifies a star by its spectral type based on its B-V color index and absolute magnitude. The script iterates the network construction process over different combinations of hidden layer sizes and training percentages, and plots the effects of each on error and accuracy for comparison. It also maps the last network's classification over the whole domain of inputs.
