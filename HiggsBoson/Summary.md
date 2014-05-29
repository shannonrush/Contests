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

**PRI_met_phi**

The azimuth angle φ of the missing transverse energy.


```r
create_plot(train, "PRI_met_phi")
```

![plot of chunk pri_met_phi](figure/pri_met_phi.png) 


```r
summary(train$PRI_met_phi)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -3.1400 -1.5800 -0.0240 -0.0101  1.5600  3.1400
```

```r
# just the signal
summary(train[signal, "PRI_met_phi"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -3.1400 -1.5500  0.0190  0.0086  1.5800  3.1400
```

```r
# just the background
summary(train[-signal, "PRI_met_phi"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -3.1400 -1.5800 -0.0440 -0.0199  1.5500  3.1400
```


**PRI_met_sumet**

The total transverse energy in the detector.

```r
create_plot(train, "PRI_met_sumet")
```

![plot of chunk pri_met_sumet](figure/pri_met_sumet.png) 


```r
summary(train$PRI_met_sumet)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    13.7   123.0   180.0   210.0   263.0  2000.0
```

```r
# just the signal
summary(train[signal, "PRI_met_sumet"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    13.7   146.0   208.0   234.0   291.0  1390.0
```

```r
# just the background
summary(train[-signal, "PRI_met_sumet"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    18.5   114.0   166.0   197.0   246.0  2000.0
```


```r
pms.750 <- subset(train, PRI_met_sumet < 750)
create_plot(pms.750, "PRI_met_sumet")
```

![plot of chunk pri_met_sumet_750](figure/pri_met_sumet_750.png) 


```r
pms.300 <- subset(train, PRI_met_sumet < 300)
create_plot(pms.300, "PRI_met_sumet")
```

![plot of chunk pri_met_sumet_300](figure/pri_met_sumet_300.png) 


```r
pms.200 <- subset(train, PRI_met_sumet < 200)
create_plot(pms.200, "PRI_met_sumet")
```

![plot of chunk pri_met_sumet_200](figure/pri_met_sumet_200.png) 

**PRI_jet_num**

The number of jets (a narrow cone of hadrons and other particles produced by the 
hadronization of a quark or gluon)
http://en.wikipedia.org/wiki/Jet_(particle_physics)


```r
ggplot(data = train, aes(x = PRI_jet_num, fill = Label)) + geom_bar(position = position_dodge())
```

```
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

![plot of chunk pri_jet_num](figure/pri_jet_num.png) 

**PRI_jet_leading_pt** 
The transverse momentum $\sqrt{p^2_x+p^2_y}$ of the leading jet, that is the jet with
largest transverse momentum (undeﬁned if PRI jet num = 0).


```r
create_plot(train, "PRI_jet_leading_pt")
```

![plot of chunk pri_jet_leading_pt](figure/pri_jet_leading_pt.png) 


```r
pjlp.na <- subset(train, PRI_jet_leading_pt == -999, select = Label)
table(pjlp.na)
```

```
## pjlp.na
##     b     s 
## 74421 25492
```

```r
length(which(pjlp.na == "b"))/nrow(pjlp.na)
```

```
## [1] 0.7449
```

75% of undefined are background.

```r
pjlp <- subset(train, PRI_jet_leading_pt != -999)
create_plot(pjlp, "PRI_jet_leading_pt")
```

![plot of chunk pri_jet_leading_pt_defined](figure/pri_jet_leading_pt_defined.png) 


```r
summary(pjlp$PRI_jet_leading_pt)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    30.0    44.4    65.6    84.8   103.0  1120.0
```

```r
pjlp.signal <- which(pjlp$Label == "s")
# just the signal
summary(pjlp[pjlp.signal, "PRI_jet_leading_pt"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    30.0    50.1    74.4    92.9   114.0   738.0
```

```r
# just the background
summary(pjlp[-pjlp.signal, "PRI_jet_leading_pt"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    30.0    41.7    60.1    79.4    95.2  1120.0
```

**PRI_jet_leading_eta**

The pseudorapidity η of the leading jet (undeﬁned if PRI jet num = 0).


```r
create_plot(train, "PRI_jet_leading_eta")
```

![plot of chunk pri_jet_leading_eta](figure/pri_jet_leading_eta.png) 


```r
pjle.na <- subset(train, PRI_jet_leading_eta == -999, select = Label)
table(pjle.na)
```

```
## pjle.na
##     b     s 
## 74421 25492
```

```r
length(which(pjle.na == "b"))/nrow(pjle.na)
```

```
## [1] 0.7449
```

74% of undefined are background.

```r
pjle <- subset(train, PRI_jet_leading_eta != -999)
v <- "PRI_jet_leading_eta"
p <- ggplot(pjle, aes(x = EventId, y = pjle[, v], color = Label), environment = environment())
l <- p + labs(y = v)
print(l + geom_point() + geom_hline(yintercept = c(-1.5, 1.5)))
```

![plot of chunk pri_jet_leading_eta_defined](figure/pri_jet_leading_eta_defined.png) 


```r
pjle.inrange <- which(pjle$PRI_jet_leading_eta >= -1.5 & pjle$PRI_jet_leading_eta <= 
    1.5)
table(pjle[pjle.inrange, "Label"])
```

```
## 
##     b     s 
## 55373 27680
```

```r
nrow(subset(pjle[pjle.inrange, ], Label == "b"))/length(pjle.inrange)
```

```
## [1] 0.6667
```

67% of defined observations in the -1.5 to 1.5 range are background

What percentange of defined observations outside the -1.5 to 1.5 range are signal?

```r
out.range <- subset(pjle, PRI_jet_leading_eta < -1.5 | PRI_jet_leading_eta > 
    1.5, select = "Label")
table(out.range)
```

```
## out.range
##     b     s 
## 34539 32495
```


```r
summary(pjle$PRI_jet_leading_eta)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##  -4.500  -1.340   0.000  -0.003   1.340   4.500
```

```r
pjle.signal <- which(pjle$Label == "s")
# just the signal
summary(pjle[pjle.signal, "PRI_jet_leading_eta"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##  -4.500  -1.630  -0.005  -0.003   1.620   4.500
```

```r
# just the background
summary(pjle[-pjle.signal, "PRI_jet_leading_eta"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##  -4.500  -1.170   0.002  -0.004   1.170   4.490
```

**PRI_jet_leading_phi**

The azimuth angle φ of the leading jet (undeﬁned if PRI jet num = 0).


```r
create_plot(train, "PRI_jet_leading_phi")
```

![plot of chunk pri_jet_leading_phi](figure/pri_jet_leading_phi.png) 


```r
pjlphi.na <- subset(train, PRI_jet_leading_phi == -999, select = Label)
table(pjlphi.na)
```

```
## pjlphi.na
##     b     s 
## 74421 25492
```

```r
length(which(pjlphi.na == "b"))/nrow(pjlphi.na)
```

```
## [1] 0.7449
```

75% of undefined are background

```r
pjlphi <- subset(train, PRI_jet_leading_phi != -999)
create_plot(pjlphi, "PRI_jet_leading_phi")
```

![plot of chunk pri_jet_leading_phi_defined](figure/pri_jet_leading_phi_defined.png) 


```r
summary(pjlphi$PRI_jet_leading_phi)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -3.1400 -1.5800 -0.0330 -0.0124  1.5600  3.1400
```

```r
pjlphi.signal <- which(pjlphi$Label == "s")
# just the signal
summary(pjlphi[pjlphi.signal, "PRI_jet_leading_phi"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -3.1400 -1.5900 -0.0360 -0.0129  1.5700  3.1400
```

```r
# just the background
summary(pjlphi[-pjlphi.signal, "PRI_jet_leading_phi"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -3.1400 -1.5800 -0.0310 -0.0121  1.5600  3.1400
```

**PRI_jet_subleading_pt**

The transverse momentum $\sqrt{p^2_x+p^2_y}$ of the second leading jet. 
 (undeﬁned if PRI jet num ≤ 1).
 

```r
create_plot(train, "PRI_jet_subleading_pt")
```

![plot of chunk pri_jet_subleading_pt](figure/pri_jet_subleading_pt.png) 


```r
pjsp.na <- subset(train, PRI_jet_subleading_pt == -999, select = Label)
table(pjsp.na)
```

```
## pjsp.na
##      b      s 
## 124255  53202
```

```r
length(which(pjsp.na == "b"))/nrow(pjsp.na)
```

```
## [1] 0.7002
```

70% of undefined are background

```r
pjsp <- subset(train, PRI_jet_subleading_pt != -999)
create_plot(pjsp, "PRI_jet_subleading_pt")
```

![plot of chunk pri_jet_subleading_pt_defined](figure/pri_jet_subleading_pt_defined.png) 


```r
summary(pjsp$PRI_jet_subleading_pt)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    30.0    37.3    47.9    57.7    66.6   721.0
```

```r
pjsp.signal <- which(pjsp$Label == "s")
# just the signal
summary(pjsp[pjsp.signal, "PRI_jet_subleading_pt"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    30.0    37.8    48.6    56.9    66.8   422.0
```

```r
# just the background
summary(pjsp[-pjsp.signal, "PRI_jet_subleading_pt"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    30.0    37.0    47.4    58.3    66.5   721.0
```

**PRI_jet_subleading_phi**

The azimuth angle φ of the subleading jet (undeﬁned if PRI jet num ≤ 1).

```r
create_plot(train, "PRI_jet_subleading_phi")
```

![plot of chunk pri_jet_subleading_phi](figure/pri_jet_subleading_phi.png) 


```r
pjsphi.na <- subset(train, PRI_jet_subleading_phi == -999, select = Label)
table(pjsphi.na)
```

```
## pjsphi.na
##      b      s 
## 124255  53202
```

```r
length(which(pjsphi.na == "b"))/nrow(pjsphi.na)
```

```
## [1] 0.7002
```

70% of undefined are background

```r
pjsphi <- subset(train, PRI_jet_subleading_phi != -999)
create_plot(pjsphi, "PRI_jet_subleading_phi")
```

![plot of chunk pri_jet_subleading_phi_defined](figure/pri_jet_subleading_phi_defined.png) 


```r
summary(pjsphi$PRI_jet_subleading_phi)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -3.1400 -1.5800 -0.0020 -0.0016  1.5800  3.1400
```

```r
pjsphi.signal <- which(pjsphi$Label == "s")
# just the signal
summary(pjsphi[pjsphi.signal, "PRI_jet_subleading_phi"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -3.1400 -1.5900 -0.0240 -0.0143  1.5600  3.1400
```

```r
# just the background
summary(pjsphi[-pjsphi.signal, "PRI_jet_subleading_phi"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -3.1400 -1.5700  0.0160  0.0087  1.5900  3.1400
```

**PRI_jet_all_pt** 

The scalar sum of the transverse momentum of all the jets.

```r
create_plot(train, "PRI_jet_all_pt")
```

![plot of chunk pri_jet_all_pt](figure/pri_jet_all_pt.png) 


```r
pjap.500 <- subset(train, PRI_jet_all_pt < 500)
create_plot(pjap.500, "PRI_jet_all_pt")
```

![plot of chunk pri_jet_all_pt_500](figure/pri_jet_all_pt_500.png) 


```r
pjap.300 <- subset(train, PRI_jet_all_pt < 300)
create_plot(pjap.300, "PRI_jet_all_pt")
```

![plot of chunk pri_jet_all_pt_300](figure/pri_jet_all_pt_300.png) 


```r
summary(train$PRI_jet_all_pt)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     0.0    40.5    73.1   110.0  1630.0
```

```r
# just the signal
summary(train[signal, "PRI_jet_all_pt"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     0.0    68.0    91.3   139.0  1190.0
```

```r
# just the background
summary(train[-signal, "PRI_jet_all_pt"])
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     0.0    33.6    63.6    89.8  1630.0
```

