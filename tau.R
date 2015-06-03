tau<-function(x){
  if(any(is.na(x))) stop('NA\'s need to be 0.')
  if(any(x<0)) stop('Negative input values not permitted. Maybe data is log transformed?')
  d<-0
  for(i in 1:length(x)) d<-d+(1-x[i]/max(x))
  t<-d/(length(x)-1)
}
