% This file constructs the datasete in R-format used in the estimation, by calling the file 'dataset_by_country.R' \
% and then manipulating the series to construct first difference 
% 
% library(xlsx)
% library(AER)
% library(gdata)
% rm(list=ls())
%setwd('U:/My Documents/FIPE/Publication')

%%%%%%%%%%%%%%%%
% Choose country
country='UK'
%%%%%%%%%%%%%%%%


% Upload the country dataset. The file 'dataset_by_country.R' containes the rows and columns of the EUKLEMS file to be used
source('dataset_by_country.R')
dataset_list=dataset_country(country)
P=dataset_list$P
W=dataset_list$W
Y=dataset_list$Y
first.sector=dataset_list$first
last.sector=dataset_list$last
years=dataset_list$years

% Define initial dataset dimensions. 
nyears=length(years)
nsectors=nrow(P)

%%% Calculate log variables

% log marginal cost
mc=log(W)-log(P)-log(Y)

% Inflation series (lose first year of data)
p=log(P)
Dp=p[,2:nyears]-p[,1:c(nyears-1)]
nyears=nyears-1

% Calculate first differences (lose initial year)
DDp=Dp[,2:nyears]-Dp[,1:(nyears-1)]
Dmc=mc[,2:(nyears+1)]-mc[,1:(nyears)]
nyears=nyears-1

% Label matrices
colnames(DDp)=paste(years[3:(nyears+2)])
colnames(Dmc)=paste(years[2:(nyears+2)])

% Create and save dataset
keep(Dmc, DDp, nyears, nsectors, first.sector, last.sector, country, sure = TRUE)
save.image(paste(country, '_Bayes_data.RData', sep=''))