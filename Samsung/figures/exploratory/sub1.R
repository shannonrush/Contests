load("../../../data/processed/validating_clean.rda")
table(validating$activity)

laying  sitting standing     walk walkdown   walkup 
334      306      327      299      235      257 

# Random Forest on validation

actual     laying sitting standing walk walkdown walkup
laying      334       0        0    0        0      0
sitting       0     295       11    0        0      0
standing      0      15      312    0        0      0
walk          0       0        0  292        2      5
walkdown      0       0        0    4      231      0
walkup        0       0        0    1        2    254

rf <- c(0,11/306,15/327,7/299,4/235,3/257)

# MLR on validation

actual     laying sitting standing walk walkdown walkup
laying      334       0        0    0        0      0
sitting       0     289       16    1        0      0
standing      0      20      307    0        0      0
walk          0       0        0  298        0      1
walkdown      0       0        0    1      233      1
walkup        0       0        0    1        0    256

mlr <- c(0,17/306,20/327,1/299,2/235,1/257)

df <- data.frame(models = factor(c(rep("Random Forest",6),rep("Multinomial Logistic Regression",6))),
                 activities = factor(rep(c("Laying Down","Sitting","Standing","Walking","Walking Down","Walking Up"),2)),
                 levels = c("Laying Down","Sitting","Standing","Walking","Walking Down","Walking Up"),
                 percents = c(rf,mlr)
                 )
library(ggplot2)
ggplot(data=df, aes(x=activities, y=percents, fill=models)) + geom_bar(stat="identity", position=position_dodge(), colour="black") +labs(title="Percentage Misclassified By Activity Performed", x="Activity Performed", y="Percentage Misclassified")+theme(legend.text = element_text(size=15),plot.title=element_text(size=16, vjust=1),axis.text.x=element_text(size=14),axis.text.y=element_text(size=14),axis.title.x=element_text(size=15, vjust=-.3),axis.title.y=element_text(size=15))