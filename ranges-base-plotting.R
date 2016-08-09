# base plot ------------------------------------------------------------------

# parameters for the plot (constants)
cex<-0.6  
colour<-c("purple", "cyan3")
par(mar=c(5,10,3,2), 
    xpd=NA)

# empty plot
plot(NA, 
     xlim=c(0, max(ranges$upper_limit)+500), # or whatever elevational range you want
     xlab="Elevation (m)", 
     main="Elevational ranges of nocturnal birds", 
     ylim=c(1, length(ranges$name)), 
     ylab="", 
     yaxt="n")

# plot 1: plot the data for each row from the data set ....
for(i in seq_along(ranges$name)){
  if(ranges$genus[i]=="Megascops"){
    col<-colour[1]
  } 
  else{
    col<-colour[2]
  }
  lines(x=c(ranges$lower_limit[i], ranges$upper_limit[i]),
        y=c(i, i),
        col=col,
        lwd=8,  #line thickness
        lend=0) #rounded ends
  
  #align left of y-axis  
  text(x=-180, 
       y=i+0.04,
       labels=ranges$name[i],  
       cex=cex+.2,
       pos=2,
       offset=1)
}

legend(x=3500, 
       y=length(ranges$name), 
       legend=c("Megacops", "Other"), 
       cex=0.8, 
       lty=1, 
       lwd=7, 
       col=colour)
