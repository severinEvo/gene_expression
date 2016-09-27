z_fpkm<-function(i){
  if(all(i>0)) stop('Input not log2 transformed.')
  if(all(!is.na(i))) stop('0\'s need to be NA\'s.')
  my<-density(i,na.rm=T)$x[which.max(density(i,na.rm=T)$y)]
  U<-mean(i[i>my],na.rm=T)
  sigma<-(U-my)*(.5*pi)^.5
  z<-NULL
  for(j in 1:length(i)){
    z[j]<-(i[j]-my)/sigma
  }
  z[z< -3]<-NA
  return(z)
}
