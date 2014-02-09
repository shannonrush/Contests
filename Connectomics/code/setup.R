# VALIDATION DATA

# Read fluorescense data
fluor.frame <- read.csv('../data/valid/fluorescence_valid.csv',header=F)
save(fluor.frame,file="fluor_valid.Rda")
dim(fluor.frame)
# [1] 179500   1000
# 179500 rows (neural activity in 20 ms intervals)
# 1000 columns (neurons)

# Read network position data
np.frame <- read.csv("../data/valid/networkPositions_valid.csv",header=F)
save(np.frame,file="np_valid.Rda")
dim(np.frame)
# [1] 1000    2
# 1000 rows (neurons)
# 2 columns (x position, y position)

# Examine Sample submission
sample_sub.frame <- read.csv("../samples/sampleSubmission.csv")
dim(sample_sub.frame)
# [1] 2000000       2
head(sample_sub.frame)
# NET_neuronI_neuronJ Strength
# 1           valid_1_1        0
# 2           valid_1_2        0
# 3           valid_1_3        0
# 4           valid_1_4        0
# 5           valid_1_5        0
# 6           valid_1_6        0
#
# Each entry is the network connectivity strength between neuron I (1-1000) and neuron J (1-1000)