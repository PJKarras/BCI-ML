setwd("C:/Users/Peter/Desktop/Thermo_R_Code/FinalThermo/new2/csvdataFULL/BCIML_Dataset")
file_name <- "populatedGPPsFULL.csv"


data <-read.csv(file = file_name)
head(data)
targets <- data[,1]
outputs <- data[,2]
head(targets)
head(outputs)
hist(outputs, main="Distribution of GPP Values for Full Dataset", xlab="GPP", freq=FALSE)

setwd("C:/Users/Peter/Desktop/Thermo_R_Code/FinalThermo/new2/csvdataFULL/BCIML_Dataset")
file_name2 <- "populatedGPPsDAYTIME.csv"


data2 <-read.csv(file = file_name2)
head(data2)
targets2 <- data2[,1]
outputs2 <- data2[,2]
head(targets2)
head(outputs2)
hist(outputs2, main="Distribution of GPP Values for Daytime Dataset", xlab="GPP", freq=FALSE)

boxplot(outputs2,main="Distribution of GPP Values in Dataset",xlab="GPP",horizontal = TRUE)
summary(outputs2)
boxplot(outputs2,horizontal = TRUE, main="")
summary(outputs)
sd(outputs2)

# 2015_03_15_00_00_bci_t.csv (128) -> 2015_03_19_00_00_bci_t.csv (1280)
setwd("C:/Users/Peter/Desktop/Thermo_R_Code/FinalThermo/new/BCI-ML/Monthly_Data_Summaries_csv/DAYTIME_new9930834")
file_name <- "training_data_DAYTIME.csv"


data3 <-read.csv(file = file_name)
epochs <- data3[,1]
train_loss <- data3[,2]
valid_loss <- data3[,3]

plot(epochs,train_loss, col='red', main="Generalization Plot",cex.main=1.95,cex.axis=1.8,cex.lab=1.7,xlab="Epoch", ylab="MSE Loss")
lines(epochs,train_loss, col='red')
points(epochs,valid_loss, col='green')
lines(epochs,valid_loss, col='green')
legend("topright",legend=c("Training Loss","Validation Loss"),col=c("red","green"),bg="white",lwd=2.5,cex=1.8)
