sub6 <- function() {
  train <- read.csv("train6_clean.csv")
  attach(train)
  fare[fare>40] <- 39
  survival_table <- array(0, dim=c(2, 3, 4))
  
  for (i in 1:3){
    for (j in 1:4){
      survival_table[1,i,j] <- mean(survived[(sex == 1) & (pclass == i) & (fare >= (j-1)*10) & (fare < j*10)])
      survival_table[2,i,j] <- mean(survived[(sex == 2) & (pclass == i) & (fare >= (j-1)*10) & (fare < j*10)])     
    }
  }
  st <- apply(survival_table,c(1,2,3),function(x) {if (is.nan(x) | x < 0.5) {0} else {1}})
  val <- apply(train,1,function(x) {
    fare <- as.numeric(x['fare'])
    if (fare %in% range(0,10.00)) {
      j <- 1
    } else if (fare %in% range(10.01,20.00)) {
      j <- 2
    } else if (fare %in% range(20.01,30.00)) {
      j <- 3
    } else {
      j <- 4
    }
    st[as.numeric(x['sex']),as.numeric(x['pclass']),j]
  })
  a<-accuracy<-((length(which(val == survived))) / length(survived)) * 100
  print(a)
  test <- read.csv("test6_clean.csv")
  sub <- apply(test,1,function(x) {
    fare <- as.numeric(x['fare'])
    if (fare %in% range(0,10.00)) {
      j <- 1
    } else if (fare %in% range(10.01,20.00)) {
      j <- 2
    } else if (fare %in% range(20.01,30.00)) {
      j <- 3
    } else {
      j <- 4
    }
    st[as.numeric(x['sex']),as.numeric(x['pclass']),j]
    #write.table(sub,"sub6.csv",row.names=F,col.names=F,quote=F)
  })
}

sub6b <- function() {
  train <- read.csv("train6_clean.csv")
  attach(train)
  ranges <- c(range(0,10.50),range(10.51-20),range(20.01,40),range(40.01,500))
  survival_table <- array(0, dim=c(2, 3, 4))
  
  for (i in 1:3){
    for (j in 1:4){
      survival_table[1,i,j] <- mean(survived[(sex == 1) & (pclass == i) & (fare %in% ranges[j])])
      survival_table[2,i,j] <- mean(survived[(sex == 2) & (pclass == i) & (fare %in% ranges[j])])     
    }
  }
  st <- apply(survival_table,c(1,2,3),function(x) {if (is.nan(x) | x < 0.5) {0} else {1}})
  val <- apply(train,1,function(x) {
    fare <- as.numeric(x['fare'])
    if (fare %in% ranges[1]) {
      j <- 1
    } else if (fare %in% ranges[2]) {
      j <- 2
    } else if (fare %in% ranges[3]) {
      j <- 3
    } else {
      j <- 4
    }
    st[as.numeric(x['sex']),as.numeric(x['pclass']),j]
  })
  a<-accuracy<-((length(which(val == survived))) / length(survived)) * 100
  print(a)
  test <- read.csv("test6_clean.csv")
  sub <- apply(test,1,function(x) {
    fare <- as.numeric(x['fare'])
    if (fare %in% ranges[1]) {
      j <- 1
    } else if (fare %in% ranges[2]) {
      j <- 2
    } else if (fare %in% ranges[3]) {
      j <- 3
    } else {
      j <- 4
    }
    st[as.numeric(x['sex']),as.numeric(x['pclass']),j]
    #write.table(sub,"sub6.csv",row.names=F,col.names=F,quote=F)
  })
}