Higgs Boson Machine Learning Challenge
========================================================

The goal of this challenge is to identify which simulated ATLAS experiment proton-proton collision
observations contain evidence of boson pairs ("signal"), and which do not ("background"). 

The challenge is [hosted by Kaggle](http://www.kaggle.com/c/higgs-boson) and provided by [The Atlas Experiment](http://atlas.ch/).  Technical details are found in the [Laboratoire de l’Accélerateur Linéaire](http://higgsml.lal.in2p3.fr/) technical documentation [PDF](http://higgsml.lal.in2p3.fr/files/2014/04/documentation_v1.5.pdf)

# The Data

Provided were a training set of 250,000 observations and a test set of 500,000 observations.
Unusable or unknown quantities are reported as -999.0.

The variables include 17 "primitive" quantities and 13 "derived" quantities. Also included
is the EventId identifying the observation. The training set also includes the goal label (b or s)
and a "Weight" metric not to be used in classification. For this reason I've stripped it out 
of the training set and saved a new CSV as processed_train.csv

## The Variables

```r
train <- read.csv("data/processed/processed_train.csv")
names(train)
```

```
##  [1] "EventId"                     "DER_mass_MMC"               
##  [3] "DER_mass_transverse_met_lep" "DER_mass_vis"               
##  [5] "DER_pt_h"                    "DER_deltaeta_jet_jet"       
##  [7] "DER_mass_jet_jet"            "DER_prodeta_jet_jet"        
##  [9] "DER_deltar_tau_lep"          "DER_pt_tot"                 
## [11] "DER_sum_pt"                  "DER_pt_ratio_lep_tau"       
## [13] "DER_met_phi_centrality"      "DER_lep_eta_centrality"     
## [15] "PRI_tau_pt"                  "PRI_tau_eta"                
## [17] "PRI_tau_phi"                 "PRI_lep_pt"                 
## [19] "PRI_lep_eta"                 "PRI_lep_phi"                
## [21] "PRI_met"                     "PRI_met_phi"                
## [23] "PRI_met_sumet"               "PRI_jet_num"                
## [25] "PRI_jet_leading_pt"          "PRI_jet_leading_eta"        
## [27] "PRI_jet_leading_phi"         "PRI_jet_subleading_pt"      
## [29] "PRI_jet_subleading_eta"      "PRI_jet_subleading_phi"     
## [31] "PRI_jet_all_pt"              "Label"
```

```r
signal <- which(train$Label == "s")
```


```r
require(ggplot2)
```

```
## Loading required package: ggplot2
```


```r
create_plot <- function(data, v) {
    p <- ggplot(data, aes(x = EventId, y = data[, v], color = Label), environment = environment())
    l <- p + labs(y = v)
    print(l + geom_point())
}
```



### Primitives

**PRI_tau_pt**

The transverse momentum $\sqrt{p^2_x+p^2_y}$, or the momentum perpendicular to the beam line, of the hadronic tau measured in GeV


```r
create_plot(train, "PRI_tau_pt")
```

![plot of chunk pri_tau_pt_fig](figure/pri_tau_pt_fig.png) 


```r
ptp <- train$PRI_tau_pt
summary(ptp)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    20.0    24.6    31.8    38.7    45.0   764.0
```

Most observations are < 175 GeV, let's replot on that subset

```r
ptp.175 <- subset(train, PRI_tau_pt < 175)
create_plot(ptp.175, "PRI_tau_pt")
```

![plot of chunk subset_ptp_175](figure/subset_ptp_175.png) 

It looks like the slower the transverse momentum, the more likely the observation is background noise. Let's replot for < 50

```r
ptp.50 <- subset(train, PRI_tau_pt < 50)
create_plot(ptp.50, "PRI_tau_pt")
```

![plot of chunk subset_ptp_50](figure/subset_ptp_50.png) 

**PRI_tau_eta**

The pseudorapidity η (the angle from the beam axis) of the hadronic tau.


```r
create_plot(train, "PRI_tau_eta")
```

![plot of chunk pri_tau_eta_fig](figure/pri_tau_eta_fig.png) 

It looks like a higher quantity of signal observations exist within -1.5 to 1.5 than outside this range.

```r
signal.obs <- subset(train, Label == "s", select = PRI_tau_eta)
# quantity signal in range -1.5 to 1.5
in.range <- subset(signal.obs, PRI_tau_eta >= -1.5 & PRI_tau_eta <= 1.5)
nrow(in.range)/nrow(signal.obs)
```

```
## [1] 0.7974
```

Almost 80% of signal observations fall in the -1.5 to 1.5 range. Is it also more likely that an
observation outside of this range is background?

```r
outside.range <- subset(train, PRI_tau_eta < -1.5 | PRI_tau_eta > 1.5, select = Label)
table(outside.range)
```

```
## outside.range
##     b     s 
## 49179 17355
```

```r
length(which(outside.range == "b"))/nrow(outside.range)
```

```
## [1] 0.7392
```

About 74% of observations outside the range -1.5 to 1.5 are background noise.

**PRI_tau_phi**

The azimuthal angle φ, from -pi to pi in the spherical coordinate system, of the hadronic tau 
around the beam axis.


```r
create_plot(train, "PRI_tau_phi")
```

![plot of chunk pri_tau_phi_fig](figure/pri_tau_phi_fig.png) 


```r
# all observations
summary(train$PRI_tau_phi)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -3.1400 -1.5800 -0.0330 -0.0082  1.5600  3.1400
```

```r
# just the signal
summary(train[signal, "PRI_tau_phi"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -3.1400 -1.5800 -0.0590 -0.0192  1.5400  3.1400
```

```r
# just the background
summary(train[-signal, "PRI_tau_phi"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -3.1400 -1.5700 -0.0170 -0.0024  1.5800  3.1400
```

**PRI_lep_pt**

The transverse momentum $\sqrt{p^2_x+p^2_y}$, or the momentum perpendicular to the beam line, of the lepton (electron or muon) measured in GeV


```r
create_plot(train, "PRI_lep_pt")
```

![plot of chunk pri_lep_pt_fig](figure/pri_lep_pt_fig.png) 

Replotting to < 200

```r
plp.200 <- subset(train, PRI_lep_pt < 200)
create_plot(plp.200, "PRI_lep_pt")
```

![plot of chunk pri_lep_pt_200](figure/pri_lep_pt_200.png) 


```r
summary(train$PRI_lep_pt)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    26.0    32.4    40.5    46.7    53.4   560.0
```

**PRI_lep_eta**

The pseudorapidity η (the angle from the beam axis) of the lepton.


```r
create_plot(train, "PRI_lep_eta")
```

![plot of chunk pri_lep_eta_fig](figure/pri_lep_eta_fig.png) 

Just as with the pseudorapidity of the hadronic tau it appears the signal
clusters in the range of -1.5 to 1.5

```r
signal.obs <- subset(train, Label == "s", select = PRI_lep_eta)
# quantity signal in range -1.5 to 1.5
in.range <- subset(signal.obs, PRI_lep_eta >= -1.5 & PRI_lep_eta <= 1.5)
nrow(in.range)/nrow(signal.obs)
```

```
## [1] 0.7837
```

Aabout 78% of signal observations fall in the -1.5 to 1.5 range. 


```r
outside.range <- subset(train, PRI_lep_eta < -1.5 | PRI_lep_eta > 1.5, select = Label)
table(outside.range)
```

```
## outside.range
##     b     s 
## 56096 18534
```

```r
length(which(outside.range == "b"))/nrow(outside.range)
```

```
## [1] 0.7517
```

About 75% of observations outside the range -1.5 to 1.5 are background noise.

**PRI_lep_phi**

The azimuthal angle φ, from -pi to pi in the spherical coordinate system, of the lepton 
around the beam axis.


```r
create_plot(train, "PRI_lep_phi")
```

![plot of chunk pri_lep_phi_fig](figure/pri_lep_phi_fig.png) 


```r
# all observations
summary(train$PRI_lep_phi)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -3.1400 -1.5200  0.0860  0.0435  1.6200  3.1400
```

```r
# just the signal
summary(train[signal, "PRI_lep_phi"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -3.1400 -1.5000  0.1030  0.0539  1.6300  3.1400
```

```r
# just the background
summary(train[-signal, "PRI_lep_phi"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -3.1400 -1.5300  0.0760  0.0381  1.6100  3.1400
```

**PRI_met**
The missing transverse energy $\overrightarrow{E}^{miss}_T$ 


```r
create_plot(train, "PRI_met")
```

![plot of chunk pri_met](figure/pri_met.png) 


```r
summary(train$PRI_met)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.1    21.4    34.8    41.7    51.9  2840.0
```

```r
# just the signal
summary(train[signal, "PRI_met"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.2    17.9    31.9    42.7    54.5  2840.0
```

```r
# just the background
summary(train[-signal, "PRI_met"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.1    23.3    35.9    41.2    51.0   951.0
```

That one outlier really makes this blurry...

```r
pm.500 <- subset(train, PRI_met < 500)
create_plot(pm.500, "PRI_met")
```

![plot of chunk pri_met_500](figure/pri_met_500.png) 


```r
pm.200 <- subset(train, PRI_met < 200)
create_plot(pm.200, "PRI_met")
```

![plot of chunk pri_met_200](figure/pri_met_200.png) 


```r
pm.100 <- subset(train, PRI_met < 100)
create_plot(pm.100, "PRI_met")
```

![plot of chunk pri_met_100](figure/pri_met_100.png) 

There appears to be a lot of signal clustered < 25

```r
under.25 <- subset(train[signal, ], PRI_met < 25)
nrow(under.25)/length(signal)
```

```
## [1] 0.3842
```

About 38% of the signal is < 25 






