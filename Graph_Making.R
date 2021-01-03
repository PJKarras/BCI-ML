setwd("C:/Users/Peter/Desktop/Thermo_R_Code/FinalThermo/new/BCI-ML/Monthly_Data_Summaries_csv/DAYTIME_new3601492")
file_name <- "test_data_DAYTIME_2-304235878625022.csv"

setwd("C:/Users/Peter/Desktop/Thermo_R_Code/FinalThermo/new/BCI-ML/Monthly_Data_Summaries_csv/DAYTIMEcopy_new8941230")
file_name <- "test_data_DAYTIMEcopy_0-8236985411673727.csv"

setwd("C:/Users/Peter/Desktop/Thermo_R_Code/FinalThermo/new/BCI-ML/Monthly_Data_Summaries_csv/FULL_new7329405")
file_name <- "test_data_FULL_2-789648598807384.csv"

setwd("C:/Users/Peter/Desktop/Thermo_R_Code/FinalThermo/new/BCI-ML/Monthly_Data_Summaries_csv/4000_new2570910")
file_name <- "test_data_4000_11-047669204261345.csv"


setwd("C:/Users/Peter/Desktop/Thermo_R_Code/FinalThermo/new/BCI-ML/Monthly_Data_Summaries_csv/DAYTIME_new9930834")
file_name <- "test_data_DAYTIME_13-446994955314361.csv"

data <-read.csv(file = file_name)
head(data)
targets <- data[,1]
outputs <- data[,2]
head(targets)
head(outputs)
abline(a=0,b=1, col="red")
plot(targets, outputs, main="Observed vs Predicted GPP: Trained with Daytime Values",cex.main=1.95,cex=0.8,cex.axis=2,cex.lab=1.7, xlab="Observed", ylab="Predicted")
axis(1,cex.axis=2)
cor(targets, outputs)**2
text(3.2,34,"R^2:", cex = 2, col="dark red") 
text(11.2,34,"0.8905117", cex = 2, col="dark red", font=2)

# NEW STUFF PAR ANAYLSIS
setwd("C:/Users/Peter/Desktop/Thermo_R_Code/FinalThermo/new/BCI-ML/Images and Plots/PAR Data")
file_name <- "merged_PAR_Analysis_test_data_DAYTIME_13-446994955314361.csv"

data <- read.csv(file = file_name)
data$PARDIFF
plot(data$PARDIFF, data$gppdiff, main="PAR Diff vs GPP Error",cex.main=1.95,cex=0.8,cex.axis=2,cex.lab=1.7, xlab="PAR Diff", ylab="GPP Error")
axis(1,cex.axis=2)
abline(a=0,b=1, col="red")
cor(data$PARDIFF, data$gppdiff)**2
text(1020,18,"R^2:", cex = 2, col="dark red") 
text(1210,18,"0.06860969", cex = 2, col="dark red", font=2)

