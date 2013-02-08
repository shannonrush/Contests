#data<-read.csv("merged_train.csv",na.string=c("","NA"))
#filename<-"cleaned_train.csv"
data<-read.csv("merged_test.csv",na.string=c("","NA"))
dataCleanup <- function(data, filename) {
  ## clean up NAs ##
  
  #find missing fiManufacturerIDs
  for (modelID in unique(data[is.na(data$fiManufacturerID),"ModelID"])) {
    manID<-data[data$ModelID==modelID&!is.na(data$fiManufacturerID),"fiManufacturerID"][1]
    if (!is.na(manID)) {
      data$fiManufacturerID[data$ModelID==modelID]<-manID
    }
  }
  
  data$fiManufacturerID[is.na(data$fiManufacturerID)]<-0
  
  #fiManufacturerDesc is human for fiManufacturerID
  data$fiManufacturerDesc <- NULL
  
  #Enclosure
  for (modelID in unique(data[is.na(data$Enclosure),"ModelID"])) {
    enc<-data[data$ModelID==modelID&!is.na(data$Enclosure),"Enclosure"][1]
    if (!is.na(enc)) {
      data$Enclosure[data$ModelID==modelID]<-enc
    }
  }
  
  data$Enclosure[is.na(data$Enclosure)]<-"None or Unspecified"
  # Enclosure Type
  # seems to be mostly duplicate information and enclosure has better coverage
  data$Enclosure_Type <- NULL
  
  # keep fiBaseModel, get rid of related - base model is probably the most influential variable of these
  data$fiBaseModel <- as.character(data$fiBaseModel)
  data$fiModelDesc <- NULL
  data$fiSecondaryDesc <- NULL
  data$fiModelSeries <- NULL
  data$fiModelDescriptor <- NULL
  
  # Product Group is first part of fiProductClassDesc
  # PrimarySize Basis, Primary Lower and Primary Upper are the second part of fiProductClassDesc
  data$fiProductClassDesc <- NULL
  # Product Group Desc is the exact same as Product Group
  data$ProductGroupDesc <- NULL
  
  # Machine Size Variables
  for (modelID in unique(data[is.na(data$PrimarySizeBasis),"ModelID"])) {
    psb<-data[data$ModelID==modelID&!is.na(data$PrimarySizeBasis),"PrimarySizeBasis"][1]
    if (!is.na(psb)) {
      data$PrimarySizeBasis[data$ModelID==modelID]<-psb
    }
  }
  levels(data$PrimarySizeBasis) <- c(levels(data$PrimarySizeBasis),"Unidentified")
  data$PrimarySizeBasis[which(is.na(data$PrimarySizeBasis))] <- "Unidentified"
  
  for (modelID in unique(data[is.na(data$PrimaryLower),"ModelID"])) {
    pl<-data[data$ModelID==modelID&!is.na(data$PrimaryLower),"PrimaryLower"][1]
    if (!is.na(pl)) {
      data$PrimaryLower[data$ModelID==modelID]<-pl
    }
  }
  data$PrimaryLower[which(is.na(data$PrimaryLower))] <- mean(data$PrimaryLower,na.rm=T)
  
  for (modelID in unique(data[is.na(data$PrimaryUpper),"ModelID"])) {
    pu<-data[data$ModelID==modelID&!is.na(data$PrimaryUpper),"PrimaryUpper"][1]
    if (!is.na(pu)) {
      data$PrimaryUpper[data$ModelID==modelID]<-pu
    }
  }
  data$PrimaryUpper[which(is.na(data$PrimaryUpper))] <- mean(data$PrimaryUpper,na.rm=T)
  
  # MfgYear  
  # 1000 seems to be just a placeholder
  data$MfgYear<-sapply(data$MfgYear,function(x)replace(x,x==1000,NA)) 
  data$YearMade<-sapply(data$YearMade,function(x)replace(x,x==1000,NA))
  # == uptoprimaryupper
  
  data$MfgYear[is.na(data$MfgYear)]<-sapply(data[is.na(data$MfgYear),"YearMade"],function(x)ifelse(!is.na(x),x,NA))
  for (modelID in unique(data[is.na(data$MfgYear),"ModelID"])) {
    my<-data[data$ModelID==modelID&!is.na(data$MfgYear),"MfgYear"][1]
    ym<-data[data$ModelID==modelID&!is.na(data$YearMade),"YearMade"][1]
    if (!is.na(my)) {
      data$MfgYear[data$ModelID==modelID&is.na(data$MfgYear)]<-my
    } else if (!is.na(ym)) {
      data$MfgYear[data$ModelID==modelID&is.na(data$MfgYear)]<-ym
    }
  }
  # uptoyearreplace
  data$MfgYear[which(is.na(data$MfgYear))]<-mean(data$MfgYear,na.rm=T)
  data$YearMade <- NULL
  # uptomfgyear
  
  #auctioneerID
  data$auctioneerID <- as.factor(data$auctioneerID)
  levels(data$auctioneerID)<-c(levels(data$auctioneerID),"Unspecified")
  data$auctioneerID[which(is.na(data$auctioneerID))] <- "Unspecified"
  
  # MachineHoursCurrentMeter 
  # notes indicate 0 means NA not brand new
  data$MachineHoursCurrentMeter<-sapply(data$MachineHoursCurrentMeter,function(x)replace(x,x==0,NA)) 
  data$MachineHoursCurrentMeter[which(is.na(data$MachineHoursCurrentMeter))] <- mean(data$MachineHoursCurrentMeter,na.rm=T)
  
  # UsageBand
  data$UsageBand[which(is.na(data$UsageBand))] <- "Medium" 
  
  # ProductSize
  for (modelID in unique(data[is.na(data$ProductSize),"ModelID"])) {
    ps<-data[data$ModelID==modelID&!is.na(data$ProductSize),"ProductSize"][1]
    if (!is.na(ps)) {
      data$ProductSize[data$ModelID==modelID&is.na(data$ProductSize)]<-ps
    }
  }
  levels(data$ProductSize) <- c(levels(data$ProductSize),"Unspecified")
  data$ProductSize[is.na(data$ProductSize)] <- "Unspecified"
  
  # Drive System
  for (modelID in unique(data[is.na(data$Drive_System),"ModelID"])) {
    ds<-data[data$ModelID==modelID&!is.na(data$Drive_System),"Drive_System"][1]
    if (!is.na(ds)) {
      data$Drive_System[data$ModelID==modelID&is.na(data$Drive_System)]<-ds
    }
  }
  levels(data$Drive_System)<-c(levels(data$Drive_System),"Unspecified")
  data$Drive_System[which(is.na(data$Drive_System))]<-"Unspecified"
  
  # Forks
  for (modelID in unique(data[is.na(data$Forks),"ModelID"])) {
    f<-data[data$ModelID==modelID&!is.na(data$Forks),"Forks"][1]
    if (!is.na(f)) {
      data$Forks[data$ModelID==modelID&is.na(data$Forks)]<-f
    }
  }
  data$Forks[is.na(data$Forks)]<-"None or Unspecified"
  
  # Pad_Type
  for (modelID in unique(data[is.na(data$Pad_Type),"ModelID"])) {
    pt<-data[data$ModelID==modelID&!is.na(data$Pad_Type),"Pad_Type"][1]
    if (!is.na(pt)) {
      data$Pad_Type[data$ModelID==modelID&is.na(data$Pad_Type)]<-pt
    }
  }
  data$Pad_Type[is.na(data$Pad_Type)]<-"None or Unspecified"
  
  #Ride_Control
  for (modelID in unique(data[is.na(data$Ride_Control),"ModelID"])) {
    rc<-data[data$ModelID==modelID&!is.na(data$Ride_Control),"Ride_Control"][1]
    if (!is.na(rc)) {
      data$Ride_Control[data$ModelID==modelID&is.na(data$Ride_Control)]<-rc
    }
  }
  data$Ride_Control[is.na(data$Ride_Control)]<-"None or Unspecified"
  
  #Stick
  for (modelID in unique(data[is.na(data$Stick),"ModelID"])) {
    s<-data[data$ModelID==modelID&!is.na(data$Stick),"Stick"][1]
    if (!is.na(s)) {
      data$Stick[data$ModelID==modelID&is.na(data$Stick)]<-s
    }
  }
  levels(data$Stick)<-c(levels(data$Stick),"Unspecified")
  data$Stick[is.na(data$Stick)]<-"Unspecified"
  
  #Transmission
  for (modelID in unique(data[is.na(data$Transmission),"ModelID"])) {
    t<-data[data$ModelID==modelID&!is.na(data$Transmission),"Transmission"][1]
    if (!is.na(t)) {
      data$Transmission[data$ModelID==modelID&is.na(data$Transmission)]<-t
    }
  }
  data$Transmission[is.na(data$Transmission)]<-"None or Unspecified"
  
  #Turbocharged
  for (modelID in unique(data[is.na(data$Turbocharged),"ModelID"])) {
    t<-data[data$ModelID==modelID&!is.na(data$Turbocharged),"Turbocharged"][1]
    if (!is.na(t)) {
      data$Turbocharged[data$ModelID==modelID&is.na(data$Turbocharged)]<-t
    }
  }
  data$Turbocharged[which(is.na(data$Turbocharged))]<-"None or Unspecified"
  
  #Blade_Extension
  for (modelID in unique(data[is.na(data$Blade_Extension),"ModelID"])) {
    be<-data[data$ModelID==modelID&!is.na(data$Blade_Extension),"Blade_Extension"][1]
    if (!is.na(be)) {
      data$Blade_Extension[data$ModelID==modelID&is.na(data$Blade_Extension)]<-be
    }
  }
  data$Blade_Extension[which(is.na(data$Blade_Extension))]<-"None or Unspecified"
  
  #Blade_Width
  for (modelID in unique(data[is.na(data$Blade_Width),"ModelID"])) {
    bw<-data[data$ModelID==modelID&!is.na(data$Blade_Width),"Blade_Width"][1]
    if (!is.na(bw)) {
      data$Blade_Width[data$ModelID==modelID&is.na(data$Blade_Width)]<-bw
    }
  }
  data$Blade_Width[which(is.na(data$Blade_Width))]<-"None or Unspecified"
  
  #Engine_Horsepower
  for (modelID in unique(data[is.na(data$Engine_Horsepower),"ModelID"])) {
    eh<-data[data$ModelID==modelID&!is.na(data$Engine_Horsepower),"Engine_Horsepower"][1]
    if (!is.na(eh)) {
      data$Engine_Horsepower[data$ModelID==modelID&is.na(data$Engine_Horsepower)]<-eh
    }
  }
  levels(data$Engine_Horsepower)<-c(levels(data$Engine_Horsepower),"Unspecified")
  data$Engine_Horsepower[which(is.na(data$Engine_Horsepower))]<-"Unspecified"
  
  #Hydraulics
  for (modelID in unique(data[is.na(data$Hydraulics),"ModelID"])) {
    h<-data[data$ModelID==modelID&!is.na(data$Hydraulics),"Hydraulics"][1]
    if (!is.na(h)) {
      data$Hydraulics[data$ModelID==modelID&is.na(data$Hydraulics)]<-h
    }
  }
  levels(data$Hydraulics)<-c(levels(data$Hydraulics),"Unspecified")
  data$Hydraulics[is.na(data$Hydraulics)]<-"Unspecified"
  
  #Pushblock
  for (modelID in unique(data[is.na(data$Pushblock),"ModelID"])) {
    pb<-data[data$ModelID==modelID&!is.na(data$Pushblock),"Pushblock"][1]
    if (!is.na(pb)) {
      data$Pushblock[data$ModelID==modelID&is.na(data$Pushblock)]<-pb
    }
  }
  data$Pushblock[is.na(data$Pushblock)]<-"None or Unspecified"
  
  #Ripper
  for (modelID in unique(data[is.na(data$Ripper),"ModelID"])) {
    r<-data[data$ModelID==modelID&!is.na(data$Ripper),"Ripper"][1]
    if (!is.na(r)) {
      data$Ripper[data$ModelID==modelID&is.na(data$Ripper)]<-r
    }
  }
  data$Ripper[which(is.na(data$Ripper))]<-"None or Unspecified"
  
  #Scarifier
  for (modelID in unique(data[is.na(data$Scarifier),"ModelID"])) {
    s<-data[data$ModelID==modelID&!is.na(data$Scarifier),"Scarifier"][1]
    if (!is.na(s)) {
      data$Scarifier[data$ModelID==modelID&is.na(data$Scarifier)]<-s
    }
  }
  data$Scarifier[which(is.na(data$Scarifier))]<-"None or Unspecified"
  
  #Tip_Control
  for (modelID in unique(data[is.na(data$Tip_Control),"ModelID"])) {
    tc<-data[data$ModelID==modelID&!is.na(data$Tip_Control),"Tip_Control"][1]
    if (!is.na(tc)) {
      data$Tip_Control[data$ModelID==modelID&is.na(data$Tip_Control)]<-tc
    }
  }
  data$Tip_Control[which(is.na(data$Tip_Control))]<-"None or Unspecified"
  
  #Tire_Size
  for (modelID in unique(data[is.na(data$Tire_Size),"ModelID"])) {
    ts<-data[data$ModelID==modelID&!is.na(data$Tire_Size),"Tire_Size"][1]
    if (!is.na(ts)) {
      data$Tire_Size[data$ModelID==modelID&is.na(data$Tire_Size)]<-ts
    }
  }
  data$Tire_Size[which(is.na(data$Tire_Size))]<-"None or Unspecified"
  
  #Coupler
  for (modelID in unique(data[is.na(data$Coupler),"ModelID"])) {
    c<-data[data$ModelID==modelID&!is.na(data$Coupler),"Coupler"][1]
    if (!is.na(c)) {
      data$Coupler[data$ModelID==modelID&is.na(data$Coupler)]<-c
    }
  }
  data$Coupler[which(is.na(data$Coupler))]<-"None or Unspecified"
  
  #Coupler_System
  for (modelID in unique(data[is.na(data$Coupler_System),"ModelID"])) {
    cs<-data[data$ModelID==modelID&!is.na(data$Coupler_System),"Coupler_System"][1]
    if (!is.na(cs)) {
      data$Coupler_System[data$ModelID==modelID&is.na(data$Coupler_System)]<-cs
    }
  }
  data$Coupler_System[which(is.na(data$Coupler_System))]<-"None or Unspecified"
  
  #Grouser_Tracks
  for (modelID in unique(data[is.na(data$Grouser_Tracks),"ModelID"])) {
    gt<-data[data$ModelID==modelID&!is.na(data$Grouser_Tracks),"Grouser_Tracks"][1]
    if (!is.na(gt)) {
      data$Grouser_Tracks[data$ModelID==modelID&is.na(data$Grouser_Tracks)]<-gt
    }
  }
  data$Grouser_Tracks[which(is.na(data$Grouser_Tracks))]<-"None or Unspecified"
  
  #Grouser_Type
  for (modelID in unique(data[is.na(data$Grouser_Type),"ModelID"])) {
    gt<-data[data$ModelID==modelID&!is.na(data$Grouser_Type),"Grouser_Type"][1]
    if (!is.na(gt)) {
      data$Grouser_Type[data$ModelID==modelID&is.na(data$Grouser_Type)]<-gt
    }
  }
  levels(data$Grouser_Type)<-c(levels(data$Grouser_Type),"Unspecified")
  data$Grouser_Type[which(is.na(data$Grouser_Type))]<-"Unspecified"
  
  #Hydraulics_Flow
  for (modelID in unique(data[is.na(data$Hydraulics_Flow),"ModelID"])) {
    hf<-data[data$ModelID==modelID&!is.na(data$Hydraulics_Flow),"Hydraulics_Flow"][1]
    if (!is.na(hf)) {
      data$Hydraulics_Flow[data$ModelID==modelID&is.na(data$Hydraulics_Flow)]<-hf
    }
  }
  levels(data$Hydraulics_Flow)<-c(levels(data$Hydraulics_Flow),"Unspecified")
  data$Hydraulics_Flow[which(is.na(data$Hydraulics_Flow))]<-"Unspecified"
  
  #Track_Type
  for (modelID in unique(data[is.na(data$Track_Type),"ModelID"])) {
    tt<-data[data$ModelID==modelID&!is.na(data$Track_Type),"Track_Type"][1]
    if (!is.na(tt)) {
      data$Track_Type[data$ModelID==modelID&is.na(data$Track_Type)]<-tt
    }
  }
  levels(data$Track_Type)<-c(levels(data$Track_Type),"Unspecified")
  data$Track_Type[which(is.na(data$Track_Type))]<-"Unspecified"
  
  #Undercarriage_Pad_Width
  for (modelID in unique(data[is.na(data$Undercarriage_Pad_Width),"ModelID"])) {
    upw<-data[data$ModelID==modelID&!is.na(data$Undercarriage_Pad_Width),"Undercarriage_Pad_Width"][1]
    if (!is.na(upw)) {
      data$Undercarriage_Pad_Width[data$ModelID==modelID&is.na(data$Undercarriage_Pad_Width)]<-upw
    }
  }
  data$Undercarriage_Pad_Width[which(is.na(data$Undercarriage_Pad_Width))]<-"None or Unspecified"
  
  #Stick_Length
  for (modelID in unique(data[is.na(data$Stick_Length),"ModelID"])) {
    sl<-data[data$ModelID==modelID&!is.na(data$Stick_Length),"Stick_Length"][1]
    if (!is.na(sl)) {
      data$Stick_Length[data$ModelID==modelID&is.na(data$Stick_Length)]<-sl
    }
  }
  data$Stick_Length[which(is.na(data$Stick_Length))]<-"None or Unspecified"
  
  #Thumb
  for (modelID in unique(data[is.na(data$Thumb),"ModelID"])) {
    t<-data[data$ModelID==modelID&!is.na(data$Thumb),"Thumb"][1]
    if (!is.na(t)) {
      data$Thumb[data$ModelID==modelID&is.na(data$Thumb)]<-t
    }
  }
  data$Thumb[which(is.na(data$Thumb))]<-"None or Unspecified"
  
  #Pattern_Changer
  for (modelID in unique(data[is.na(data$Pattern_Changer),"ModelID"])) {
    pc<-data[data$ModelID==modelID&!is.na(data$Pattern_Changer),"Pattern_Changer"][1]
    if (!is.na(pc)) {
      data$Pattern_Changer[data$ModelID==modelID&is.na(data$Pattern_Changer)]<-pc
    }
  }
  data$Pattern_Changer[which(is.na(data$Pattern_Changer))]<-"None or Unspecified"
  
  #Blade_Type
  for (modelID in unique(data[is.na(data$Blade_Type),"ModelID"])) {
    bt<-data[data$ModelID==modelID&!is.na(data$Blade_Type),"Blade_Type"][1]
    if (!is.na(bt)) {
      data$Blade_Type[data$ModelID==modelID&is.na(data$Blade_Type)]<-bt
    }
  }
  data$Blade_Type[which(is.na(data$Blade_Type))]<-"None or Unspecified"
  
  #Travel_Controls
  for (modelID in unique(data[is.na(data$Travel_Controls),"ModelID"])) {
    tc<-data[data$ModelID==modelID&!is.na(data$Travel_Controls),"Travel_Controls"][1]
    if (!is.na(tc)) {
      data$Travel_Controls[data$ModelID==modelID&is.na(data$Travel_Controls)]<-tc
    }
  }
  data$Travel_Controls[which(is.na(data$Travel_Controls))]<-"None or Unspecified"
  
  #Differential_Type
  for (modelID in unique(data[is.na(data$Differential_Type),"ModelID"])) {
    dt<-data[data$ModelID==modelID&!is.na(data$Differential_Type),"Differential_Type"][1]
    if (!is.na(dt)) {
      data$Differential_Type[data$ModelID==modelID&is.na(data$Differential_Type)]<-dt
    }
  }
  levels(data$Differential_Type)<-c(levels(data$Differential_Type),"Unspecified")
  data$Differential_Type[which(is.na(data$Differential_Type))]<-"Unspecified"
  
  #Steering_Controls
  for (modelID in unique(data[is.na(data$Steering_Controls),"ModelID"])) {
    sc<-data[data$ModelID==modelID&!is.na(data$Steering_Controls),"Steering_Controls"][1]
    if (!is.na(sc)) {
      data$Steering_Controls[data$ModelID==modelID&is.na(data$Steering_Controls)]<-sc
    }
  }
  levels(data$Steering_Controls)<-c(levels(data$Steering_Controls),"Unspecified")
  data$Steering_Controls[which(is.na(data$Steering_Controls))]<-"Unspecified"
  
  # Backhoe Mounting
  # There's no good data in this variable, just "None or Unspecified" or NA
  data$Backhoe_Mounting <- NULL
  
  ## add and remove variables ##
  # month sold
  data$monthSold <- apply(data,1,function(x) {
    date <- as.Date(x['saledate'], format="%m/%d/%Y")
    as.numeric(format(date,format="%m"))
  })
  
  # season sold
  seasons<-c("Winter","Spring","Summer","Autumn")
  data$seasonSold <- apply(data,1,function(x) {
    date <- as.Date(x['saledate'], format="%m/%d/%Y")
    month <- as.numeric(format(date,format="%m"))
    if (month %in% c(1,2,3)) {
      seasons[1]
    } else if (month %in% c(4,5,6)) {
      seasons[2]
    } else if (month %in% c(7,8,9)) {
      seasons[3]
    } else {
      seasons[4]
    }
  })
  # remove saledate
  data$saledate <- NULL
  data$monthSold <- as.factor(data$monthSold)
  data$seasonSold<- as.factor(data$seasonSold)
  write.csv(data,filename,row.names=F)
}

randomForestTest3 <- function() {
  # Vars with >=25 importance and appears in >= 4 importance from sp2.*.rf
  train <- read.csv("training_Clean.csv")
  library(randomForest)
  library(foreach)
  library(doMC)
  registerDoMC(cores=4)
  
  set.seed(345)
  
  x<-train[,c("ModelID", "MfgYear", "PrimaryLower", "PrimaryUpper", "SalesID", "auctioneerID","Enclosure", "monthSold")]
  y<-train[,"SalePrice"]
  sp3a.rf <- foreach(ntree=rep(25, 4), .combine=combine, .packages='randomForest') %dopar%
    randomForest(y=y,x=x,ntree=ntree,importance=T,proximity=F,replace=F,nodesize=3)
  save(sp3a.rf,file="sp3arf.rda")
  importance(sp3a.rf)
  valid <- read.csv("validating_Clean.csv")
  p3a <- predict(sp3a.rf,valid)
  load("sp3arf.rda")
  test <- read.csv("test_Clean.csv")
  test$fiManufacturerID <- NULL
  
  pt <- predict(sp3a.rf,test)
}

