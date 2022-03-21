
rm(list = ls())
#install.packages("R.matlab")
require(R.matlab)

#setwd("C:/Users/NRO/DEPE/CurvadePhillipsSectorial/FIPE")
setwd("D:/Users/NRO/DEPE/CurvaPhillipsSectorial/FIPE")

 country = 'COL'
# country = 'UK'
# country = 'USA'
#country = 'JPN'

#load("UK_Bayes_data.Rdata")
load(paste(country,"_Bayes_data.Rdata",sep=""))

filename <- paste(country,"_Bayes_data.mat", sep="")
writeMat(filename,DDp=DDp, Dmc=Dmc, country=country, first_sector=first.sector, last_sector=last.sector, nsectors=nsectors, nyears=nyears)
data <- readMat(filename)



##### export by example
filename <- paste("UK_Bayes_data.mat", sep="")
writeMat(filename, A=A, B=B, C=C)
data <- readMat(filename)

A <- matrix(1:27, ncol=3)
B <- as.matrix(1:10)
C <- array(1:18, dim=c(2,3,3))
#filename <- paste(tempfile(), ".mat", sep="")
filename <- paste("ABC.mat", sep="")
writeMat(filename, A=A, B=B, C=C)
data <- readMat(filename)
str(data)
X <- list(A=A, B=B, C=C)
stopifnot(all.equal(X, data[names(X)]))
unlink(filename)

