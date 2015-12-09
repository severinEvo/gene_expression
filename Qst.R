Qst<-function(y, fixed, ...){
  chk = list(...)
  chk$fixed = fixed
  for(n in names(chk))
    if(length(unique(chk[[n]])) < 2)
      stop(n, " must contain at least 2 levels")
  d = data.frame(y = y, fixed = fixed, ...)
  dd = subset(d, !is.na(y))
  if(length(unique(dd$fixed)) < 2){
    warning("after excluding NA from y, fixed factor has one level")
    return(NA)
  }
  if(ncol(dd) > 2)
    for(n in names(dd)[-c(1,2)])
      if(length(unique(dd[[n]])) < 2)
        dd[[n]] = NULL
  res = anova(aov(y ~ fixed * ., data = dd))
  vW = res[nrow(res),3] # residual mean squares
  lf1 = length(fixed[fixed==unique(fixed)[1]])
  lf2 = length(fixed[fixed==unique(fixed)[2]])
  n0 = length(fixed)-(lf1^2+lf2^2)/length(fixed)
  vB = (res[1,3]-vW)/n0 # fixed effect factor mean squares
  qst = vB/(vB+2*vW)
  return(c(qst,vW,vB))
}
