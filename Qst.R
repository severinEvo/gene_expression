Qst<-function(i, spec, tis=NULL, sex=NULL){
  spec<-as.factor(spec)
  tis<-as.factor(tis)
  sex<-as.factor(sex)
  if(length(levels(spec))!=2) stop('Two species needed.')

  lsp1<-length(spec[levels(spec)==levels(spec)[1]])
  lsp2<-length(spec[levels(spec)==levels(spec)[2]])
  n0<-length(i)-(lsp1^2+lsp2^2)/length(i)

  if(length(levels(tis))>0 & length(levels(sex))>0){
    dataset<-data.frame(expr=i,spec=spec,tis=tis,sex=sex)
    dataset_0<-dataset[!is.na(dataset[,1]),]
    if(length(levels(droplevels(dataset_0$tis)))<2 & length(levels(droplevels(dataset_0$sex)))==1){
      anova_0<-anova(aov(dataset_0[,1] ~ dataset_0$spec))
    }else if(length(levels(droplevels(dataset_0$tis)))>1 & length(levels(droplevels(dataset_0$sex)))==1){
      anova_0<-anova(aov(dataset_0[,1] ~ dataset_0$spec * dataset_0$tis))
    }else if(length(levels(droplevels(dataset_0$tis)))<2 & length(levels(droplevels(dataset_0$sex)))==2){
      anova_0<-anova(aov(dataset_0[,1] ~ dataset_0$spec * dataset_0$sex))
    }else if(length(levels(droplevels(dataset_0$tis)))>1 & length(levels(droplevels(dataset_0$sex)))==2){
      anova_0<-anova(aov(dataset_0[,1] ~ dataset_0$spec * dataset_0$tis * dataset_0$sex))
    }else stop('Unknown error.')
  }
  if(length(levels(tis))==0 & length(levels(sex))>0){
    dataset<-data.frame(expr=i,spec=spec,sex=sex)
    dataset_0<-dataset[!is.na(dataset[,1]),]
    if(length(levels(droplevels(dataset_0$sex)))==1){
      anova_0<-anova(aov(dataset_0[,1] ~ dataset_0$spec))
    }else if(length(levels(droplevels(dataset_0$sex)))==2){
      anova_0<-anova(aov(dataset_0[,1] ~ dataset_0$spec * dataset_0$sex))
    }else stop('Unknown error.')
  }
  if(length(levels(tis))>0 & length(levels(sex))==0){
    dataset<-data.frame(expr=i,spec=spec,tis=tis)
    dataset_0<-dataset[!is.na(dataset[,1]),]
    if(length(levels(droplevels(dataset_0$tis)))<2){
      anova_0<-anova(aov(dataset_0[,1] ~ dataset_0$spec))
    }else if(length(levels(droplevels(dataset_0$tis)))>1){
      anova_0<-anova(aov(dataset_0[,1] ~ dataset_0$spec * dataset_0$tis))
    }else stop('Unknown error.')
  }
  if(length(levels(tis))==0 & length(levels(sex))==0){
    dataset<-data.frame(expr=i,spec=spec)
    dataset_0<-dataset[!is.na(dataset[,1]),]
    anova_0<-anova(aov(dataset_0[,1] ~ dataset_0$spec))
  }
  
  vW<-tail(anova_0$'Mean Sq',n=1)
  vB<-(anova_0[1,3]-vW)/n0
  qst<-vB/(vB+2*vW)
  if(qst<0){qst<-0}
  return(c(qst,vW,vB))
}
