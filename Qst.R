Qst<-function(i, spec, tis=NULL, sex=NULL){
  spec<-as.factor(spec)
  tis<-as.factor(tis)
  sex<-as.factor(sex)

  lsp1<-length(spec[levels(spec)==levels(spec)[1]])
  lsp2<-length(spec[levels(spec)==levels(spec)[2]])
  n0<-length(i)-(lsp1^2+lsp2^2)/length(i)

  if(length(levels(sex))==0 | is.null(sex)){
    dataset<-data.frame(expr=i,spec=spec)
    anova_0<-anova(aov(dataset$expr ~ dataset$spec))
  }else if((length(levels(sex))==0 | is.null(sex)) & length(levels(tis))>1){
    dataset<-data.frame(expr=i,spec=spec,tis=tis)
    anova_0<-anova(aov(dataset[,1] ~ dataset$spec * dataset$tis))
  }else if(length(levels(sex))==2 & (length(levels(tis))==0 | is.null(tis))){
    dataset<-data.frame(expr=i,spec=spec,sex=sex)
    anova_0<-anova(aov(dataset[,1] ~ dataset$spec * dataset$sex))
  }else if(length(levels(sex))==2 & length(levels(tis))>1){
    dataset<-data.frame(expr=i,spec=spec,tis=tis,sex=sex)
    if(sum(!is.na(dataset[,1]))<20 & sum(!is.na(dataset[,1]))>10){
      anova_0<-anova(aov(dataset[,1] ~ dataset$spec * dataset$sex))
    }else if(sum(!is.na(dataset[,1]))<11){
    anova_0<-anova(aov(dataset$expr ~ dataset$spec))
    }else{
      anova_0<-anova(aov(dataset[,1] ~ dataset$spec * dataset$sex * dataset$tis))
  }}
  vW<-tail(anova_0$'Mean Sq',n=1)
  vB<-(anova_0[1,3]-vW)/n0
  qst<-vB/(vB+2*vW)
  if(qst<0){qst<-0}
  return(c(qst,vW,vB))
}
