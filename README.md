# gene_expression
Some useful functions for gene expression analyses

## zFPKM.R

A function for normalising gene expression datasets in a comparative manner over different sequencing libraries and experiments. It builds on FPKM normalisation and needs FPKM normalised expression values as input. zFPKM has been developed by Hart and colleagues¹. I here implemented this function for R.

Usage: Input values must have NA's in stead of 0 (or log2(0) = -Inf) and be log2 transformed. On a gene (rows) by library (columns) matrix, use than as in

>\> zFPKM_data <- apply(FPKM_data, 2, z_fpkm)

¹Hart <i>et al.</i> 2013: Finding the active genes in deep RNA-seq gene expression studies. BMC Genomics 14:778.

## Qst.R

<i>Q</i><sub>ST</sub> is a measure for differentiation in quantitative traits similar to Fisher's fixation index <i>F</i><sub>ST</sub> for genetic differentiation. As gene expression constitutes a quantitative trait, this framework can be applied to gene expression levels when one wants to compare expression differences between populations or species. In essence, <i>Q</i><sub>ST</sub> compares within (vW) and between population variance (vB). The function as implemented here returns <i>Q</i><sub>ST</sub>, vW, vB.

Usage: Input data should be normalised (e.g., using zFPKM). This assumes a gene (rows) by individual (columns) matrix. First, fixed effects (the two populations to be compared; here called species) and random effects (here, sex) need to be defined like this:

>\> spec <- rep(c("A","B"),each=10,times=2)

>\> tis <- rep(c("tis\_1","tis\_2"),each=20)

>\> sex <- rep(c("f","m","f","m"),each=5,times=2)

The function is then called as follows:

>\> qst_data <- apply(dataset, 1, Qst, spec=spec [, tis=tis, sex=sex])

<i>Q</i><sub>ST</sub>, vW, and vB are then retrieved as the three dataframe rows:

>\> qst <- qst_data[1,]

>\> vW <- qst_data[2,]

>\> vB <- qst_data[3,]

## tau.R

tau is a measure for tissue specificity of gene expression as described by Yanai and colleagues².

Usage: Summarise tissue replicates using mean() or similar. For it to function correctly, NA's must be 0. For a gene (rows) by tissue (columns) matrix, apply then as:

>\> tau <- apply(dataset, 1, tau)

²Yanai <i>et al.</i> 2004: Genome-wide midrange transcription profiles reveal expression level relationships in human tissue specification. Bioinformatics 21:650-659.
