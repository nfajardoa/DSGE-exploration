This package contains the code for "Is there a Phillips Curve? A Full Information Partial Equilibrium approach" by Roberto Piazza.
***Please cite accordingly***


(a) Before running the code, you may have to obtain some packages from the R distribution. 
The libraries called are the following:

library('latex2exp')
library(xlsx)
library(AER)
library(gdata)
library(AER)
library(mvtnorm)
library(lmtest)
library(MHadaptive)

(b) To replicate the figures in the paper, first modify (and save) the file "parameters.R" by entering the appropriate country name ("UK", "JPN" or "USA"). 
Then run the file "main.R". You are done.

(c) You may wish to modify some other parameters in the estimation. For instance, you may want to set manually the number of principal components extracted.
Just use the file "parameters.R".

(d) As explained in the comments to the file, you may want to used "FIPE_lag_auto.R" in isolation from "main.R". You can easily do so.

(e) This distribution contains the original Excel files from EUKLEMS alongside with the corresponding data files that were created for use in R.  
For each country, the R data file is created from the Excel file using "Extract_Bayes_data.R". By appropriately modifying "dataset_by_country" 
you can easily create new R data files to perfom analyses for other countries (beyond USA, UK, JPN) in the EUKLEMS database.  