# Graficas

#install.packages("dplyr")
#install.packages("stringr")
#install.packages("reshape")
#install.packages("ggplot2")
#install.packages("grid")
#install.packages("gridExtra")

library("dplyr")
library("stringr")
library("reshape")
library("ggplot2")
library("grid")
library("gridExtra")

rm(list = ls())
#setwd("D:/users/NRO/DEPE/CurvaPhillipsSectorial/FIPE")
setwd("C:/Users/USR_PracticanteGT42/Documents/DSGE_Ferroni/Nicolas Fajardo/FIPE")

dataset_name="Colombia_R" #col_output_08I"
# row.index=c(1:43) # TOTAL
row.index=c(1:10,14,17,21:43) #SIN ALIMENTOS
col.index=c(1:19)

years=c(2000:2016)

sector_id=c(1:35)  # Sin alimentos
# sector_id=c(1:43)  # todos los grupos  

first.sector=c(1, 1, 11, 22)    # sin grupos de alimentos
last.sector=c(35, 10, 21, 35)    # sin grupos de alimentos
# first.sector=c(1, 1, 11, 30)  # con todos los grupos
# last.sector=c(43, 10, 29, 43)  # con todos los grupos

P <- read.csv(paste0(dataset_name,"_P.csv"), header = TRUE)
#Y <- read.csv(paste0(dataset_name,"_QI.csv"), header = TRUE)
W <- read.csv(paste0(dataset_name,"_SI_LAB.csv"), header = TRUE)

P <- P[row.index,]
#Y <- Y[row.index,]
W <- W[row.index,]

colnames(P) <- c("sector","industry",2000:2016)
names <- as.character(P[,2])
P <- P[,col.index]
datos_p <- melt(P, id.vars = c("sector","industry"))


colnames(datos_p) <- c("sector","industry","year","value")
head(datos_p)
datos_p <- as.data.frame(datos_p)
counter = 1

for (s in 1:3){
  
  #
  #s=1
  #
  
  datos <- filter(datos_p, sector==s)
  rm(group)
  
  for (i in first.sector[s+1]:last.sector[s+1]) {
    group <- tryCatch({c(group,as.name(paste0("out_",i)))}, error = function(e) {as.name(paste0("out_",i))})
  }
  
  for (i in first.sector[s+1]:last.sector[s+1]) {
    assign(paste0("out_",i) ,filter(datos, industry==names[i]) %>% ggplot(aes(y=value, x=year)) +  geom_line(group = 1, size=1) + geom_point() + labs(title="Índice de precios", subtitle=paste(names[i]), y="Índice", x="Año"))
    ggsave(paste0(str_replace_all(substr(names[i], 1, 5), "[^[:alpha:]]", ""),"_",counter,"_",s,"_IP.png"), width = 10, height = 5, units = "in", dpi = 300, limitsize = FALSE)
    counter = counter + 1
  }
  
  #group <- lapply(group, )
  plot <- do.call("arrangeGrob", group)
  plot <- grid.arrange(plot, top=ifelse(cond==1, "Durables",ifelse(cond==2, "No durables", "No manufactureros")))
  ggsave(plot, file=paste0("consolidado_precios_",s,".png"), width = 25, height = 15, units = "in", dpi = 300, limitsize = FALSE)
  
}

for (s in 1:3) {
  cond = s
  filter(datos_p, sector==s) %>% ggplot(aes(y=value, x=year)) + geom_line(aes(col=industry, group=industry)) + geom_point(aes(col=industry)) + labs(title="Índice de precios", subtitle=ifelse(cond==1, "Durables",ifelse(cond==2, "No durables", "No manufactureros")), y="Índice", x="AÃ±o", color = "Industria")
  ggsave(paste0("sector_",s,"_Precios.png"), width = 15, height = 5, units = "in", dpi = 300, limitsize = FALSE)
}

cols <- c(2:20)
W <- W[,cols]
names <- as.character(W[,2])
colnames(W) <- c("sector","industry",2000:2016)
datos_w <- melt(W, id.vars = c("sector","industry"))
colnames(datos_w) <- c("sector","industry","year","value")
head(datos_w)
datos_w <- as.data.frame(datos_w)
counter = 1

for (s in 1:3){
  datos <- filter(datos_w, sector==s)
  rm(group)
  
  for (i in first.sector[s+1]:last.sector[s+1]) {
    group <- tryCatch({c(group,as.name(paste0("out_",i)))}, error = function(e) {as.name(paste0("out_",i))})
  }
  
  for (i in first.sector[s+1]:last.sector[s+1]) {
    assign(paste0("out_",i) ,filter(datos, industry==names[i]) %>% ggplot(aes(y=value, x=year)) +  geom_line(group = 1, size=1) + geom_point() + labs(title="Participación del trabajo sobre el valor agregado", subtitle=paste(names[i]), y="Porcentaje", x="Año"))
    #ggsave(paste0(str_replace_all(substr(names[i], 1, 5), "[^[:alpha:]]", ""),"_",counter,"_",s,"_PT.png"), width = 10, height = 5, units = "in", dpi = 300, limitsize = FALSE)
    counter = counter + 1
  }
  
  plot <- do.call("arrangeGrob", group)
  ggsave(plot, file=paste0("consolidado_participacion_",s,".png"), width = 25, height = 15, units = "in", dpi = 300, limitsize = FALSE)
  
}

for (s in 1:3) {
  cond = s
  filter(datos_w, sector==s) %>% ggplot(aes(y=value, x=year)) + geom_line(aes(col=industry, group=industry)) + geom_point(aes(col=industry)) + labs(title="Participación del trabajo sobre el valor agregado", subtitle=ifelse(cond==1, "Durables",ifelse(cond==2, "No durables", "No manufactureros")), y="Porcentaje", x="Año", color = "Industria")
  ggsave(paste0("sector_",s,"_Participacion.png"), width = 15, height = 5, units = "in", dpi = 300, limitsize = FALSE)
}

#VARIACIONES
nyears=length(years)
nsectors=nrow(P)
valores_p <- P[,3:19]
DP=valores_p[,2:nyears]-valores_p[,1:c(nyears-1)]
nyears=nyears-1
DP=data.frame(P[1:2],DP)
colnames(DP) <- c("sector","industry",2001:2016)
variacion_p <- melt(DP, id.vars = c("sector","industry"))
colnames(variacion_p) <- c("sector","industry","year","value")
head(variacion_p)
variacion_p <- as.data.frame(variacion_p)
names <- as.character(P[,2])
counter = 1

for (s in 1:3){
  datos <- filter(variacion_p, sector==s)
  rm(group)
  
  for (i in first.sector[s+1]:last.sector[s+1]) {
    group <- tryCatch({c(group,as.name(paste0("out_",i)))}, error = function(e) {as.name(paste0("out_",i))})
  }
  
  for (i in first.sector[s+1]:last.sector[s+1]) {
    assign(paste0("out_",i) ,filter(datos, industry==names[i]) %>% ggplot(aes(y=value, x=year)) +  geom_line(group = 1, size=1) + geom_point() + labs(title="Inflación", subtitle=paste(names[i]), y="Porcentaje", x="Año"))
    #ggsave(paste0(str_replace_all(substr(names[i], 1, 5), "[^[:alpha:]]", ""),"_",counter,"_",s,"_PI.png"), width = 10, height = 5, units = "in", dpi = 300, limitsize = FALSE)
    counter = counter + 1
  }
  
  plot <- do.call("arrangeGrob", group)
  ggsave(plot, file=paste0("consolidado_inflación_",s,".png"), width = 25, height = 15, units = "in", dpi = 300, limitsize = FALSE)
  
}

for (s in 1:3) {
  cond = s
  filter(variacion_p, sector==s) %>% ggplot(aes(y=value, x=year)) + geom_line(aes(col=industry, group=industry)) + geom_point(aes(col=industry)) + labs(title="Inflación", subtitle=ifelse(cond==1, "Durables",ifelse(cond==2, "No durables", "No manufactureros")), y="Porcentaje", x="Año", color = "Industria")
  ggsave(paste0("sector_",s,"_Inflacion.png"), width = 15, height = 5, units = "in", dpi = 300, limitsize = FALSE)
}

cphillips <- merge(variacion_p, datos_w,by=c("sector","industry","year"))
colnames(cphillips) <- c("sector","industry","year","inflation","cost")
head(cphillips)
cphillips <- as.data.frame(cphillips)
counter = 1

for (s in 1:3){
  datos <- filter(cphillips, sector==s)
  rm(group)
  
  for (i in first.sector[s+1]:last.sector[s+1]) {
    group <- tryCatch({c(group,as.name(paste0("out_",i)))}, error = function(e) {as.name(paste0("out_",i))})
  }
  
  for (i in first.sector[s+1]:last.sector[s+1]) {
    assign(paste0("out_",i) ,filter(datos, industry==names[i]) %>% ggplot(aes(y=inflation, x=cost)) + geom_point() + labs(title="Curva de Phillips", subtitle=paste(names[i]), y="Inflación", x="Costo marginal"))
    #ggsave(paste0(str_replace_all(substr(names[i], 1, 5), "[^[:alpha:]]", ""),"_",counter,"_",s,"_CP.png"), width = 10, height = 5, units = "in", dpi = 300, limitsize = FALSE)
    counter = counter + 1
  }
  
  plot <- do.call("arrangeGrob", group)
  ggsave(plot, file=paste0("consolidado_phillips_",s,".png"), width = 25, height = 15, units = "in", dpi = 300, limitsize = FALSE)
  
}

for (s in 1:3) {
  cond = s
  filter(cphillips, sector==s) %>% ggplot(aes(y=inflation, x=cost)) + geom_point(aes(col=industry)) + labs(title="Curva de Phillips", subtitle=ifelse(cond==1, "Durables",ifelse(cond==2, "No durables", "No manufactureros")), y="Inflación", x="Costo marginal", color = "Industria")
  ggsave(paste0("sector_",s,"_Phillips.png"), width = 15, height = 5, units = "in", dpi = 300, limitsize = FALSE)
}