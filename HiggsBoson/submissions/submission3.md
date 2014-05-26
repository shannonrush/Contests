Submission 3 - Optimized Single Random Forest By Feature Selection
========================================================


```r
load("rf1.RData")
```


```r
train <- read.csv("../data/processed/processed_train.csv")
test <- read.csv("../data/original/test.csv")
```



```r
require(randomForest)
```

```
## Loading required package: randomForest
## randomForest 4.6-7
## Type rfNews() to see new features/changes/bug fixes.
```

```r
require(plyr)
```

```
## Loading required package: plyr
```

```r

rf$importance
```

```
##                                     b         s MeanDecreaseAccuracy
## DER_mass_MMC                0.0694906 0.1379587            0.0929499
## DER_mass_transverse_met_lep 0.0497179 0.0488061            0.0494058
## DER_mass_vis                0.0493432 0.0528785            0.0505553
## DER_pt_h                    0.0217379 0.0431074            0.0290606
## DER_deltaeta_jet_jet        0.0063268 0.0306668            0.0146673
## DER_mass_jet_jet            0.0086810 0.0258875            0.0145771
## DER_prodeta_jet_jet         0.0072948 0.0044366            0.0063138
## DER_deltar_tau_lep          0.0343305 0.0448628            0.0379402
## DER_pt_tot                  0.0116108 0.0080096            0.0103769
## DER_sum_pt                  0.0354522 0.0391069            0.0367061
## DER_pt_ratio_lep_tau        0.0258481 0.0264103            0.0260422
## DER_met_phi_centrality      0.0290101 0.0287805            0.0289309
## DER_lep_eta_centrality      0.0017128 0.0402441            0.0149157
## PRI_tau_pt                  0.0312563 0.0499112            0.0376483
## PRI_tau_eta                 0.0016172 0.0035424            0.0022770
## PRI_tau_phi                 0.0002129 0.0006165            0.0003511
## PRI_lep_pt                  0.0156537 0.0113583            0.0141824
## PRI_lep_eta                 0.0017264 0.0048161            0.0027852
## PRI_lep_phi                 0.0004734 0.0008659            0.0006079
## PRI_met                     0.0173918 0.0270294            0.0206946
## PRI_met_phi                 0.0005440 0.0007597            0.0006180
## PRI_met_sumet               0.0164029 0.0103920            0.0143438
## PRI_jet_num                 0.0051426 0.0032512            0.0044945
## PRI_jet_leading_pt          0.0209174 0.0226732            0.0215202
## PRI_jet_leading_eta         0.0158220 0.0061857            0.0125195
## PRI_jet_leading_phi         0.0086197 0.0123659            0.0099041
## PRI_jet_subleading_pt       0.0044766 0.0096404            0.0062455
## PRI_jet_subleading_eta      0.0047714 0.0050334            0.0048606
## PRI_jet_subleading_phi      0.0052324 0.0049865            0.0051475
## PRI_jet_all_pt              0.0226330 0.0270445            0.0241449
##                             MeanDecreaseGini
## DER_mass_MMC                         18088.2
## DER_mass_transverse_met_lep          11553.1
## DER_mass_vis                          8723.1
## DER_pt_h                              3649.0
## DER_deltaeta_jet_jet                  2338.1
## DER_mass_jet_jet                      1779.8
## DER_prodeta_jet_jet                    956.1
## DER_deltar_tau_lep                    5091.3
## DER_pt_tot                            3299.3
## DER_sum_pt                            3286.0
## DER_pt_ratio_lep_tau                  5058.8
## DER_met_phi_centrality                5712.0
## DER_lep_eta_centrality                1828.8
## PRI_tau_pt                            6472.1
## PRI_tau_eta                           2838.9
## PRI_tau_phi                           2630.5
## PRI_lep_pt                            3077.8
## PRI_lep_eta                           2969.4
## PRI_lep_phi                           2625.0
## PRI_met                               4376.8
## PRI_met_phi                           2622.1
## PRI_met_sumet                         2972.6
## PRI_jet_num                            495.6
## PRI_jet_leading_pt                    1807.2
## PRI_jet_leading_eta                   2309.4
## PRI_jet_leading_phi                   1685.5
## PRI_jet_subleading_pt                  677.8
## PRI_jet_subleading_eta                 672.6
## PRI_jet_subleading_phi                 645.3
## PRI_jet_all_pt                        1870.1
```

```r

# Mean Decrease Gini
g <- importance(rf, type = 2, scale = F)
gini <- data.frame(variables = rownames(g), MeanDecreaseGini = g[1:nrow(g)], 
    stringsAsFactors = F)
arrange(gini, desc(MeanDecreaseGini))
```

```
##                      variables MeanDecreaseGini
## 1                 DER_mass_MMC          18088.2
## 2  DER_mass_transverse_met_lep          11553.1
## 3                 DER_mass_vis           8723.1
## 4                   PRI_tau_pt           6472.1
## 5       DER_met_phi_centrality           5712.0
## 6           DER_deltar_tau_lep           5091.3
## 7         DER_pt_ratio_lep_tau           5058.8
## 8                      PRI_met           4376.8
## 9                     DER_pt_h           3649.0
## 10                  DER_pt_tot           3299.3
## 11                  DER_sum_pt           3286.0
## 12                  PRI_lep_pt           3077.8
## 13               PRI_met_sumet           2972.6
## 14                 PRI_lep_eta           2969.4
## 15                 PRI_tau_eta           2838.9
## 16                 PRI_tau_phi           2630.5
## 17                 PRI_lep_phi           2625.0
## 18                 PRI_met_phi           2622.1
## 19        DER_deltaeta_jet_jet           2338.1
## 20         PRI_jet_leading_eta           2309.4
## 21              PRI_jet_all_pt           1870.1
## 22      DER_lep_eta_centrality           1828.8
## 23          PRI_jet_leading_pt           1807.2
## 24            DER_mass_jet_jet           1779.8
## 25         PRI_jet_leading_phi           1685.5
## 26         DER_prodeta_jet_jet            956.1
## 27       PRI_jet_subleading_pt            677.8
## 28      PRI_jet_subleading_eta            672.6
## 29      PRI_jet_subleading_phi            645.3
## 30                 PRI_jet_num            495.6
```

```r

# Mean Decrease Accuracy
a <- importance(rf, type = 1, scale = F)
accuracy <- data.frame(variables = rownames(a), MeanDecreaseAccuracy = a[1:nrow(a)], 
    stringsAsFactors = F)
arrange(accuracy, desc(MeanDecreaseAccuracy))
```

```
##                      variables MeanDecreaseAccuracy
## 1                 DER_mass_MMC            0.0929499
## 2                 DER_mass_vis            0.0505553
## 3  DER_mass_transverse_met_lep            0.0494058
## 4           DER_deltar_tau_lep            0.0379402
## 5                   PRI_tau_pt            0.0376483
## 6                   DER_sum_pt            0.0367061
## 7                     DER_pt_h            0.0290606
## 8       DER_met_phi_centrality            0.0289309
## 9         DER_pt_ratio_lep_tau            0.0260422
## 10              PRI_jet_all_pt            0.0241449
## 11          PRI_jet_leading_pt            0.0215202
## 12                     PRI_met            0.0206946
## 13      DER_lep_eta_centrality            0.0149157
## 14        DER_deltaeta_jet_jet            0.0146673
## 15            DER_mass_jet_jet            0.0145771
## 16               PRI_met_sumet            0.0143438
## 17                  PRI_lep_pt            0.0141824
## 18         PRI_jet_leading_eta            0.0125195
## 19                  DER_pt_tot            0.0103769
## 20         PRI_jet_leading_phi            0.0099041
## 21         DER_prodeta_jet_jet            0.0063138
## 22       PRI_jet_subleading_pt            0.0062455
## 23      PRI_jet_subleading_phi            0.0051475
## 24      PRI_jet_subleading_eta            0.0048606
## 25                 PRI_jet_num            0.0044945
## 26                 PRI_lep_eta            0.0027852
## 27                 PRI_tau_eta            0.0022770
## 28                 PRI_met_phi            0.0006180
## 29                 PRI_lep_phi            0.0006079
## 30                 PRI_tau_phi            0.0003511
```

```r

include <- unique(c(gini$variables[1:5]), accuracy$variables[1:5])
```

Run a new random forest including only the top 5 variables based on Gini and Accuracy

```r
rf2 <- randomForest(x = train[, include], y = train$Label, importance = T)
rf2
```

```
## 
## Call:
##  randomForest(x = train[, include], y = train$Label, importance = T) 
##                Type of random forest: classification
##                      Number of trees: 500
## No. of variables tried at each split: 2
## 
##         OOB estimate of  error rate: 18.58%
## Confusion matrix:
##        b     s class.error
## b 145228 19105      0.1163
## s  27356 58311      0.3193
```

Looks like there's been a little improvement, make a prediction

```r
pred <- predict(rf2, test, type = "prob")
```


```r

## add EventId to pred
pred.df <- data.frame(EventId = test$EventId, b = pred[, "b"], s = pred[, "s"])

# order pred.df by increasing s to get the RankOrder
require(plyr)
ordered.pred <- arrange(pred.df, s)

Class <- apply(ordered.pred, 1, function(p) ifelse(p["s"] > p["b"], "s", "b"))

final.prediction <- data.frame(EventId = ordered.pred$EventId, RankOrder = 1:550000, 
    Class)

write.csv(final.prediction, file = "submission3.csv", row.names = F, quote = F)
```




