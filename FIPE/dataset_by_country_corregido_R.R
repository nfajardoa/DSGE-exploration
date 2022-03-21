# For each country, this function chooses the appropriate rows and columns of relevant excel spreadsheet from EUKLEMS and
# uploads the data in R

dataset_country=function(country){

if (country=="COL"){
    
    # Dataset name
    #dataset_name="ColombiaSIM" #col_output_08I"
    dataset_name="Colombia_R" #col_output_08I"
    
    # vector of row and column indexes
    col.index=c(3:19)
    
    # year label
    years=c(2000:2016)
    
    # Sectors to be used. NB: sector_id gives the rows of Euklems spreadsheet that we include in the analysis
    
    sector_id=c(1:36)  # Sin alimentos
    # sector_id=c(1:44)  # todos los grupos  
    #sector_id=c(18, 19, 22:25, 27, 29, 30, 32, 33, 36, 37,39:41, 43, 45, 48, 52, 56, 61, 66,67, 69, 71:74, 76, 81, 83, 88, 89)
    
    if (alimentos==0 & transables==0) {
      # Sectors to be used.
      row.index=c(1:10,14,17,21:43) #SIN ALIMENTOS
      sector_id=c(1:35)  # Sin alimentos
      first.sector=c(1, 1, 12, 23, 0, 0)    # sin grupos de alimentos
      last.sector=c(35, 11, 22, 35, 0, 0)
    }
    if (alimentos==0 & transables==1) {
      # Sectors to be used.
      row.index=c(1:10,14,17,21:43) #SIN ALIMENTOS
      sector_id=c(1:35)  # Sin alimentos
      transability=c(1:21,27:28,31)
      first.sector=c(1, 0, 0, 0, 1, 25)    # sin grupos de alimentos
      last.sector=c(35, 0, 0, 0, 24, 35)
    }
    if (alimentos==1 & transables==0) {
      # Sectors to be used.
      row.index=c(1:43) # TOTAL
      sector_id=c(1:44)  # todos los grupos 
      first.sector=c(1, 1, 12, 31, 0, 0)  # con todos los grupos
      last.sector=c(43, 11, 30, 43, 0, 0)  # con todos los grupos
    }
    if (alimentos==1 & transables==1) {
      # Sectors to be used.
      row.index=c(1:43) # TOTAL
      sector_id=c(1:43)  # todos los grupos 
      transability=c(1:29,35:36,39)
      first.sector=c(1, 0, 0, 0, 1, 32)  # con todos los grupos
      last.sector=c(43, 0, 0, 0, 32, 43)  # con todos los grupos
    }
}
  
if (country=="USA"){

    # Dataset name
    dataset_name="usa_sic_output_08I"

    # vector of row and column indexes
    row.index=c(18:89)
    col.index=c(3:38)

    # year label
    years=c(1970:2005)

    # Sectors to be used. NB: sector_id gives the rows of Euklems spreadsheet that we include in the analysis
    sector_id=c(18, 19, 22:25, 27, 29, 30, 32, 33, 36, 37,39:41, 43, 45, 48, 52, 56, 57, 61,66, 67, 69, 71:74, 76, 81, 83, 88, 89)

    # Define groups for subsector analysis. This creates the three sector-groups used in the paper.
    first.sector=c(1, 1, 14, 24)
    last.sector=c(35, 13, 23, 35)
}


if (country=="JPN"){
  
  # Dataset name
  dataset_name="jpn_output_08I"
  
  # vector of row and column indexes
  row.index=c(18:89)
  col.index=c(6:38)
  
  # year label
  years=c(1973:2005)
  
  # Sectors to be used. NB: sector_id gives the rows of Euklems spreadsheet that we include in the analysis
  sector_id=c(18, 19, 22:25, 27, 29, 30, 32, 33, 36, 37,39:41, 43, 45, 48, 52, 56, 57, 61,66, 67, 69, 71:74, 76, 81, 83, 88, 89)  
  #sector_id=c(18, 19, 22:25, 27, 29, 30, 32, 33, 36, 37,39:41, 43, 45, 48, 52, 56, 61, 66,67, 69, 71:74, 76, 81, 83, 88, 89)
  
  # Define groups for subsector analysis. This creates the three sector-groups used in the paper.
  first.sector=c(1, 1, 14, 24)
  last.sector=c(35, 13, 23, 35)
}


if (country=="UK"){
  
  # Dataset name
  dataset_name="uk_output_08I"
  
  # vector of row and column indexes
  row.index=c(18:89)
  col.index=c(3:38)
  
  # year label
  years=c(1970:2005)
  
  # Sectors to be used. NB: sector_id gives the rows of Euklems spreadsheet that we include in the analysis
  sector_id=c(18, 19, 22:25, 27, 29, 30, 32, 33, 36, 37,39:41, 43, 45, 48, 52, 56, 57, 61,66, 67, 69, 71:74, 76, 81, 83, 88, 89)
  
  # Define groups for subsector analysis.This creates the three sector-groups used in the paper.
  first.sector=c(1, 1, 14, 24)
  last.sector=c(35, 13, 23, 35)
}

########################################
### Download data and create dataset ###
########################################
  
#P <- read.xlsx(dataset_name, sheetName="GO_P",  header=FALSE,rowIndex=row.index,  colIndex=col.index)     
#Y <- read.xlsx(dataset_name, sheetName="GO_QI", header=FALSE,rowIndex=row.index,  colIndex=col.index)
#W <- read.xlsx(dataset_name, sheetName="LAB",   header=FALSE,rowIndex=row.index,  colIndex=col.index)    

if (country !="COL"){
  
  P <- read.csv(paste0(dataset_name,"_P.csv"), header = FALSE)
  Y <- read.csv(paste0(dataset_name,"_QI.csv"), header = FALSE)
  W <- read.csv(paste0(dataset_name,"_LAB.csv"), header = FALSE)
  
  P <- P[row.index,col.index]
  Y <- Y[row.index,col.index]
  W <- W[row.index,col.index]
  
  P <- as.matrix(P)
  class(P) <- "numeric"
  Y <- as.matrix(Y)
  class(Y) <- "numeric"
  W <- as.matrix(W)
  class(W) <- "numeric"
  
} else {
  
  P <- read.csv(paste0(dataset_name,"_P.csv"), header = TRUE)
  W <- read.csv(paste0(dataset_name,"_LAB.csv"), header = TRUE)
  
  P <- P[row.index,col.index]
  W <- W[row.index,col.index]
  
  if (transables==1){
    
    P <- rbind(P[transability,],P[-transability,])
    W <- rbind(W[transability,],W[-transability,])
  
  }

  P <- as.matrix(P)
  class(P) <- "numeric"
  W <- as.matrix(W)
  class(W) <- "numeric"
  
}
  
#### Define parameters for the dataset. NB: sector_id gives the rows of Euklems spreadsheet that we include into the analyis
nyears=length(years)
nsectors=length(sector_id)
 
  if (country!="COL") {
    
    all_rows=1:sector_id[nsectors]
    row_exclude=all_rows[-c(sector_id+1-sector_id[1])]
    P= P[-row_exclude,]
    W= W[-row_exclude,]
    dataset_list=list("P"=P,"Y"=Y,"W"=W,"first"=first.sector, "last"=last.sector, "years"=years)
    
} else {
  
  dataset_list=list("P"=P,"W"=W,"first"=first.sector, "last"=last.sector, "years"=years)
  
  }

# Return list
return(dataset_list)}
