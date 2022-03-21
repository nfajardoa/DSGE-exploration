# This file constructs the datasete in R-format used in the estimation, by calling the file "dataset_by_country.R" \
# and then manipulating the series to construct first difference 

#library(xlsx)
#library(AER)
#library(gdata)
rm(list=ls())
#setwd("U:/My Documents/FIPE/Publication")
setwd("C:/Users/USR_PracticanteGT42/Documents/DSGE_Ferroni/Nicolas Fajardo/FIPE")



################
# Choose country
country="COL"
transables=1
alimentos=1
################


# Upload the country dataset. The file "dataset_by_country.R" containes the rows and columns of the EUKLEMS file to be used
# source("dataset_by_country.R")
source("dataset_by_country_corregido_R.R")
dataset_list=dataset_country(country)
P=dataset_list$P
W=dataset_list$W
if (country !="COL") {Y=dataset_list$Y}
first.sector=dataset_list$first
last.sector=dataset_list$last
years=dataset_list$years

# Define initial dataset dimensions. 
nyears=length(years)
nsectors=nrow(P)

### Calculate log variables

# log marginal cost

if (country=='COL') {mc=log(W)}else{mc=log(W)-log(P)-log(Y)}

# Inflation series (lose first year of data)
p=log(P)
Dp=p[,2:nyears]-p[,1:c(nyears-1)]
nyears=nyears-1

# Calculate first differences (lose initial year)
DDp=Dp[,2:nyears]-Dp[,1:(nyears-1)]
Dmc=mc[,2:(nyears+1)]-mc[,1:(nyears)]
nyears=nyears-1

# Label matrices
colnames(DDp)=paste(years[3:(nyears+2)])
colnames(Dmc)=paste(years[2:(nyears+2)])

# Create and save dataset

if (country!='COL') {keep(Dmc, DDp, nyears, nsectors, first.sector, last.sector, country, sure = TRUE)}
save.image(paste(country,if(alimentos==0){"_sinalim"},if(transables==1){"_trans"},"_Bayes_data.RData", sep=""))

