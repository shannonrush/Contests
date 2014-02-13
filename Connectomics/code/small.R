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
flor1.frame <- read.csv('fluorescence_iNet1_Size100_CC01inh.txt',header=F)