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






