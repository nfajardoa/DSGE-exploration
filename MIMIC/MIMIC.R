MIMIC <- function (last.year = 2003, initial.values = 0, model = 1, upper, lower, custom.name = FALSE, pc = "NRO", filename = "", diffuse.filter = FALSE, no.warnings = TRUE){

  require(data.table)
  require(MARSS)
  require(openxlsx)
  require(ggplot2)

  # MANUAL DEBUGGING
  
  #last.year = 2003
  #initial.values = 0
  #model = 1
  #upper = up
  #lower = low
  #custom.name = FALSE
  #pc = "NicoLinux"
  #filename = ""
  #diffuse.filter = TRUE
  #no.warnings = FALSE
  
  # DIRECTORY LOADING
  
  if (pc == "NRO"){
    
    setwd("D:/Users/NRO/DEPE/ESPE/DemandadeDinero/MIMIC")
  
  } else if (pc == "Nico"){
    
    setwd("C:/Users/USR_PracticanteGT42/Documents/DSGE_Ferroni/Nicolas Fajardo/MIMIC")
    
  }  else if (pc == "NicoLinux"){
      
    setwd("/home/gfnun/Nicolas")
    
  } else {
    
    stop("No se ha especificado directorio")
    
  }
  
  # DATA LOADING
  
  if (last.year == 2003){ 
    
    data <- read.xlsx('Datos.xlsx')
    last.ob = dim(data)[1]
    col.Ut_1  = match("Ut-1",names(data))  
    col.LVAEAM = match("Yt(VAEAM)(ln)",names(data))
    
    if (model == 1){
      
      y.selector = c(2)                  # ln(EFR)
      d.selector  = c(9,10,11,12,13,14)
      
      ln_Y_r_lag = t(data[col.LVAEAM])
      ln_Y_r_lag = shift(ln_Y_r_lag, n=1, fill=NA, type="lag")
      ln_Y_r_lag[1] = ln_Y_r_lag[2]/(1+(1 - data[1,col.LVAEAM]/data[2,col.LVAEAM]))
      
      c.selector = c(15,16,17,18,19,20,21,22)
      
      y = t(data[y.selector])
      d = t(data[d.selector]) 
      c = rbind(ln_Y_r_lag,t(data[c.selector])) 
      
    } else if (model == 2){
      
      y.selector = c(2,3,5)           #  ln(EFR)	CP	W(GWh)(Ln)
      d.selector  = c(9,13,19,21,14)  # DTM DIPC CL Ut-1 LVAEAM
      c.selector = c(16,17,18,21,22)  # IC AN SMReal Ut-1 lnVCO
      
      ln_U_lead = t(data[col.Ut_1])
      ln_U_lead = shift(ln_U_lead, n=1, fill=NA, type="lead")
      ln_U_lead[last.ob] = ln_U_lead[last.ob-1]*(1+(data[last.ob,col.Ut_1]/data[last.ob-1,col.Ut_1]-1))
      
      ln_Y_r_lag = t(data[col.LVAEAM])
      ln_Y_r_lag = shift(ln_Y_r_lag, n=1, fill=NA, type="lag")
      ln_Y_r_lag[1] = ln_Y_r_lag[2]/(1+(1 - data[1,col.LVAEAM]/data[2,col.LVAEAM]))
      
      y = t(data[y.selector])
      d = t(data[d.selector]) 
      d[4,] = ln_U_lead
      row.names(d)[4] = "Ut"
      c = rbind(ln_Y_r_lag,t(data[c.selector]))
      
    } else if (model == 3){
      
      y.selector = c(2,3)
      d.selector  = c(9,13,19,21,14)  # DTM DIPC CL Ut-1 LVAEAM
      c.selector = c(16,17,18,21,22)  # IC AN SMReal Ut-1 lnVCO
      
      ln_U_lead = t(data[col.Ut_1])
      ln_U_lead = shift(ln_U_lead, n=1, fill=NA, type="lead")
      ln_U_lead[last.ob] = ln_U_lead[last.ob-1]*(1+(data[last.ob,col.Ut_1]/data[last.ob-1,col.Ut_1]-1))
      
      ln_Y_r_lag = t(data[col.LVAEAM])
      ln_Y_r_lag = shift(ln_Y_r_lag, n=1, fill=NA, type="lag")
      ln_Y_r_lag[1] = ln_Y_r_lag[2]/(1+(1 - data[1,col.LVAEAM]/data[2,col.LVAEAM]))
      
      y = t(data[y.selector])
      d = t(data[d.selector]) 
      d[4,] = ln_U_lead
      row.names(d)[4] = "Ut"
      c = rbind(ln_Y_r_lag,t(data[c.selector]))
    }
  }
  
  if (last.year == 2017){ 
    
    data <- read.xlsx('DdaDinero_BaseDatos_17Octubre2018_ANUAL.xlsx', sheet = 1)
    last.ob = dim(data)[1]
    col.Ut_1  = match("Ut_1",names(data))  
    col.LVAEAM = match("LVAEAM",names(data))
    
    if (model == 1){
      
      y.selector = c(2)                  # ln(EFR)
      d.selector  = c(8,9,10,11,12,13)
      
      ln_Y_r_lag = t(data[col.LVAEAM])
      ln_Y_r_lag = shift(ln_Y_r_lag, n=1, fill=NA, type="lag")
      ln_Y_r_lag[1] = ln_Y_r_lag[2]/(1+(1 - data[1,col.LVAEAM]/data[2,col.LVAEAM]))
      
      c.selector = c(14,15,16,17,18,19,21,22)
      
      y = t(data[y.selector])
      d = t(data[d.selector]) 
      c = rbind(ln_Y_r_lag,t(data[c.selector])) 
      
    } else if (model == 2){
      
      stop("La base de datos no está soportada aún")
      
      # y.selector = c(2,3,5)           #  ln(EFR)	CP	W(GWh)(Ln)
      # d.selector  = c(8,12,18,21,13)  # DTM DIPC CL Ut-1 LVAEAM
      # c.selector = c(15,16,17,21,22)  # IC AN SMReal Ut-1 lnVCO
      # 
      # ln_U_lead = t(data[col.Ut_1])
      # ln_U_lead = shift(ln_U_lead, n=1, fill=NA, type="lead")
      # ln_U_lead[last.ob] = ln_U_lead[last.ob-1]*(1+(data[last.ob,col.Ut_1]/data[last.ob-1,col.Ut_1]-1))
      # 
      # ln_Y_r_lag = t(data[col.LVAEAM])
      # ln_Y_r_lag = shift(ln_Y_r_lag, n=1, fill=NA, type="lag")
      # ln_Y_r_lag[1] = ln_Y_r_lag[2]/(1+(1 - data[1,col.LVAEAM]/data[2,col.LVAEAM]))
      # 
      # y = t(data[y.selector])
      # d = t(data[d.selector])
      # d[4,] = ln_U_lead
      # row.names(d)[4] = "Ut"
      # c = rbind(ln_Y_r_lag,t(data[c.selector]))
      
    } else if (model == 3){
      
      y.selector = c(2,3)
      d.selector  = c(8,12,18,21,13)  # DTM DIPC CL Ut-1 LVAEAM
      c.selector = c(15,16,17,21,22)  # IC AN SMReal Ut-1 lnVCO
      
      ln_U_lead = t(data[col.Ut_1])
      ln_U_lead = shift(ln_U_lead, n=1, fill=NA, type="lead")
      ln_U_lead[last.ob] = ln_U_lead[last.ob-1]*(1+(data[last.ob,col.Ut_1]/data[last.ob-1,col.Ut_1]-1))
      
      ln_Y_r_lag = t(data[col.LVAEAM])
      ln_Y_r_lag = shift(ln_Y_r_lag, n=1, fill=NA, type="lag")
      ln_Y_r_lag[1] = ln_Y_r_lag[2]/(1+(1 - data[1,col.LVAEAM]/data[2,col.LVAEAM]))
      
      y = t(data[y.selector])
      d = t(data[d.selector])
      d[4,] = ln_U_lead
      row.names(d)[4] = "Ut"
      c = rbind(ln_Y_r_lag,t(data[c.selector]))
    }
  }
  
  # MODEL SPECIFICATION
  
  ctl = list(lower = lower, upper = upper, trace = 1)
  
  if (model == 1){ 
    
    # Orden de las restricciones
    
    Z = matrix(list("theta1"),1,1)
    D = matrix(list("theta3","theta4","theta5","theta6","theta7","theta8"),1,6)
    A = matrix(list("theta2"),1,1)
    R = matrix(list("theta19"),1,1)
    B = matrix(list("theta9"),1,1)
    C = matrix(list("theta10","theta11","theta12","theta13","theta14","theta15","theta16","theta17","theta18"),1,9)
    U = matrix(0,1,1)
    Q = matrix(list("theta20"),1,1)
    V0 = matrix(100,1,1)
    
    if (length(upper) & length(lower) != 21) {
      
      stop("El número de retricciones no corresponde con el número de parámetros a estimar")
      
      }
    }  
  
  if (model == 2){ 
    
    # Orden de las restricciones
    
    Z = matrix(list("theta1","theta2","theta3"),3,1)
    D = matrix(list("theta4","theta5",0,0,"theta6",0,0,"theta7","theta8",0,0,0,0,0,"theta9"),3,5,byrow = TRUE)
    A = matrix(0,3,1)
    R = matrix(list("theta17",0,0,0,"theta18",0,0,0,"theta19"),3,3)
    B = matrix(list("theta10"),1,1)
    C = matrix(list("theta11","theta12","theta13","theta14","theta15","theta16"),1,6)
    U = matrix(0,1,1)
    Q = matrix(list("theta20"),1,1)
    V0 = matrix(100,1,1)
    
    if (length(upper) & length(lower) != 21) {
      
      stop("El número de retricciones no corresponde con el número de parámetros a estimar")
      
      }
    }
  
  if (model == 3){ 
    
    # Orden de las restricciones
    
    Z = matrix(list("theta1","theta2"),2,1)
    D = matrix(list("theta4","theta5",0,0,"theta6",0,0,"theta7","theta8",0),2,5,byrow = TRUE)
    A = matrix(0,2,1)
    R = matrix(list("theta17",0,0,"theta18"),2,2,byrow = TRUE)
    B = matrix(list("theta10"),1,1)
    C = matrix(list("theta11","theta12","theta13","theta14","theta15","theta16"),1,6)
    U = matrix(0,1,1)
    Q = matrix(list("theta20"),1,1)
    V0 = matrix(100,1,1)
    
    if (length(upper) & length(lower) != 18) {
      
      stop("El número de retricciones no corresponde con el número de parámetros a estimar")
      
      }
    }
  
  # ESTIMATION & PLOTTING
  
  model.list = list()
  plot.list = list()
  
  if (length(initial.values) <= 1){

  for (init in initial.values){
    
    x0 = matrix(init,1,1)
    model.specs = list(Z=Z,R=R,B=B,Q=Q,d=d,c=c,C=C,D=D,A=A,U=U,x0=x0,V0=V0, diffuse = diffuse.filter, tinitx = ifelse(diffuse.filter==TRUE, 1,0))
    
    # Estimation
    
    tryCatch(
      
      { est.model = MARSS(y = y, model = model.specs, method = "BFGS", control = ctl, silent = no.warnings, fun.kf = ifelse(diffuse.filter==TRUE,"MARSSkfas","MARSSkfss"))
        est.model.ci = MARSSparamCIs(est.model)
        model.list[[match(init, initial.values)]] = list( Modelo = est.model, "Intervalos de confianza" = est.model.ci, "Estado inicial" = init) 
      
    # Plots
      
      year = data[1]
      plot.state = data.frame(year = year, value = t(est.model$states), se.upp = t(est.model$states)+t(est.model$states.se), se.low = t(est.model$states)-t(est.model$states.se))
      names(plot.state) = c("year", "X", "Up", "Low")

      if(model == 1){
      
      p = ggplot(data = plot.state, aes(y=X, x=year)) + 
        geom_line(color = "#dc322f", size = 1) + 
        geom_ribbon(data= plot.state,aes(ymin=Low,ymax=Up),alpha=0.3) + 
        theme_bw() + 
        labs(y = NULL, caption = paste("tetha9 = ",round(est.model$par$B[1],5)), title = "Economia Subterranea", subtitle = "(Modelo 1)", x = "Año")
      
      }
      
      if(model == 2){
        
        p = ggplot(data = plot.state, aes(y=X, x=year)) + 
          geom_line(color = "#dc322f", size = 1) + 
          geom_ribbon(data= plot.state,aes(ymin=Low,ymax=Up),alpha=0.3) + 
          theme_bw() + 
          labs(y = NULL, caption = paste("tetha10 = ",round(model$par$B[1],5)), title = "Economia Subterranea", subtitle = "(Modelo 2)", x = "Año")
        
      }
      
      if(model == 3){
        
        p = ggplot(data = plot.state, aes(y=X, x=year)) + 
          geom_line(color = "#dc322f", size = 1) + 
          geom_ribbon(data= plot.state,aes(ymin=Low,ymax=Up),alpha=0.3) + 
          theme_bw() + 
          labs(y = NULL, caption = paste("tetha10 = ",round(model$par$B[1],5)), title = "Economia Subterranea", subtitle = "(Modelo 2 modificado)", x = "Año")
        
      }
      
      if (custom.name == FALSE){
      
      file.name = ifelse(model == 1, paste0("plot.state_modelo1_",init,".png"), 
                         ifelse(model == 2, paste0("plot.state_modelo2_",init,".png"), 
                                ifelse(model == 3, paste0("plot.state_modelo3_",init,".png"),
                                       stop("El modelo seleccionado no existe"))))
      } else if (custom.name == TRUE){
        
      file.name = paste0(filename, init, ".png")  
        
      }
      
      png(file.name)
      print(p)
      dev.off()
      
      print(paste("Iteration of initial state:",init,"---> COMPLETED"))
      return(model.list)
    
      }, error = function(e){
        print(paste("Skipping iteration of initial state:",init,"---> FAILED"))
      } 
    ) 
  }
  } else {
    
  Time <- txtProgressBar(min = min(initial.values), max = max(initial.values), style = 3)
    
  for (init in initial.values){
    
    x0 = matrix(init,1,1)
    model.specs = list(Z=Z,R=R,B=B,Q=Q,d=d,c=c,C=C,D=D,A=A,U=U,x0=x0,V0=V0)
    
    # Estimation
    
    tryCatch(
      
      { est.model = MARSS(y = y, model = model.specs, method = "BFGS", control = ctl, silent = no.warnings, fun.kf = ifelse(diffuse.filter==TRUE,"MARSSkfas","MARSSkfss"))
      est.model.ci = MARSSparamCIs(est.model)
      model.list[[match(init, initial.values)]] = list( Modelo = est.model, "Intervalos de confianza" = est.model.ci, "Estado inicial" = init) 
      
      # Plots
      
      year = data[1]
      plot.state = data.frame(year = year, value = t(est.model$states), se.upp = t(est.model$states)+t(est.model$states.se), se.low = t(est.model$states)-t(est.model$states.se))
      names(plot.state) = c("year", "X", "Up", "Low")
      
      if(model == 1){
        
        p = ggplot(data = plot.state, aes(y=X, x=year)) + 
          geom_line(color = "#dc322f", size = 1) + 
          geom_ribbon(data= plot.state,aes(ymin=Low,ymax=Up),alpha=0.3) + 
          theme_bw() + 
          labs(y = NULL, caption = paste("tetha9 = ",round(est.model$par$B[1],5)), title = "Economia Subterranea", subtitle = "(Modelo 1)", x = "Año")
        
      }
      
      if(model == 2){
        
        p = ggplot(data = plot.state, aes(y=X, x=year)) + 
          geom_line(color = "#dc322f", size = 1) + 
          geom_ribbon(data= plot.state,aes(ymin=Low,ymax=Up),alpha=0.3) + 
          theme_bw() + 
          labs(y = NULL, caption = paste("tetha10 = ",round(model$par$B[1],5)), title = "Economia Subterranea", subtitle = "(Modelo 2)", x = "Año")
        
      }
      
      if(model == 3){
        
        p = ggplot(data = plot.state, aes(y=X, x=year)) + 
          geom_line(color = "#dc322f", size = 1) + 
          geom_ribbon(data= plot.state,aes(ymin=Low,ymax=Up),alpha=0.3) + 
          theme_bw() + 
          labs(y = NULL, caption = paste("tetha10 = ",round(model$par$B[1],5)), title = "Economia Subterranea", subtitle = "(Modelo 2 modificado)", x = "Año")
        
      }
      
      if (custom.name == FALSE){
        
        file.name = ifelse(model == 1, paste0("plot.state_modelo1_",init,".png"), 
                           ifelse(model == 2, paste0("plot.state_modelo2_",init,".png"), 
                                  ifelse(model == 3, paste0("plot.state_modelo3_",init,".png"),
                                         stop("El modelo seleccionado no existe"))))
      } else if (custom.name == TRUE){
        
        file.name = paste0(filename, init, ".png")  
        
      }
      
      png(file.name)
      print(p)
      dev.off()
      
      print(paste("Iteration of initial state:",init,"---> COMPLETED"))
      return(model.list)
      
      }, error = function(e){
        print(paste("Skipping iteration of initial state:",init,"---> FAILED"))
      } 
    ) 
  }

  close(Time)
  
  }
}
