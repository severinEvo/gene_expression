Qst<-function(i, spec, sex=NULL){
  spec<-as.factor(spec)
  sex<-as.factor(sex)
  lsp1<-length(spec[levels(spec)==levels(spec)[1]])
  lsp2<-length(spec[levels(spec)==levels(spec)[2]])
  n0<-length(i)-(lsp1^2+lsp2^2)/length(i)
  if(length(levels(sex))==0 | is.null(sex)){
    dataset<-data.frame(expr=i,spec=spec)
    anova_0<-anova(aov(dataset$expr ~ dataset$spec))
    vW<-anova_0[2,3]
  }else if(length(levels(sex))==2){
    dataset<-data.frame(expr=i,spec=spec,sex=sex)
    anova_0<-anova(aov(dataset$expr ~ dataset$spec * dataset$sex))
    vW<-anova_0[4,3]
  }
  vB<-(anova_0[1,3]-vW)/n0
  qst<-vB/(vB+2*vW)
  if(qst<0){qst<-0}
  return(c(qst,vW,vB))
}
