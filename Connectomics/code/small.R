# small data
# Six small networks with N=100 neurons. 
# Each network has the same connectivity degree but different levels of clustering coefficient, 
# intended for fast checks of the algorithms.
#
# consists of: 6 F files, 6 P (network position) files and 6 N files
#
# The goal of the challenge is to predict whether there is a (directed) connection between 
# neuron i and neuron j in a network of 1000 neurons (self-connections permitted). 
# We provide one hour of recording of the activity of all neurons as time series and the position 
# of the neurons (arranged on a flat surface). The data, which are simulated, reproduce as faithfully 
# as possible neural activity measured with calcium fluorescence imaging of neural cultures.
#

F1.frame <- read.csv('../data/small/fluorescence_iNet1_Size100_CC01inh.txt',header=F)
# [1] 179498    100
# 179498 neural activity readings over 20ms intervals for 100 neurons
P1.frame <- read.csv('../data/small/networkPositions_iNet1_Size100_CC01inh.txt',header=F)
# [1] 100   2
# X and Y positions for each neuron
N1.frame <- read.csv('../data/small/network_iNet1_Size100_CC01inh.txt',header=F)
# [1] 1249    3
# Neuron I, Neuron J and their connection weight
# self connections allowed
# connection of -1 indicates chemical blockage, effectively absent