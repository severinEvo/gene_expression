# gene_expression
Some useful functions for gene expression analyses

## zFPKM.R

A function for normalising gene expression datasets in a comparative manner over different sequencing libraries and experiments. It builds on FPKM normalisation and needs FPKM normalised expression values as input. zFPKM has been developed by Hart and colleagues [1]. I here implemented this function for R.

Usage: Input values must have NA's in stead of 0 (or log2(0) = -Inf) and be log2 transformed. On a gene (rows) by library (columns) matrix, use then as in
```> zFPKM_data <- apply(FPKM_data, 2, z_fpkm)
```
Note that this function also applies the cutoff suggested in the study¹ by removing genes below an expression value of log2(0.125) = -3.

[1] Hart *et al.* 2013: [Finding the active genes in deep RNA-seq gene expression studies](https://doi.org/10.1186/1471-2164-14-778). BMC Genomics 14:778.

## Pst.R

*P*<sub>ST</sub> is a measure for differentiation in phenotypic quantitative traits similar to Fisher's fixation index *F*<sub>ST</sub> for genetic differentiation. *P*<sub>ST</sub> is an approximation to *Q*<sub>ST</sub>, when the additive genetic variance cannot be estimated from breeding experiments [2]. As gene expression constitutes a quantitative trait, quantitative trait framework can be applied to gene expression levels when one wants to compare expression differences between populations or species. In essence, *P*<sub>ST</sub> compares within- (*v*<sub>W</sub>) and between-population variance (*v*<sub>B</sub>). The function as implemented here returns *P*<sub>ST</sub>, *v*<sub>W</sub>, *v*<sub>B</sub>. It is calculated as in Antoniazza and colleagues [3], but for two populations only as of now.

Usage: Input data should be normalised (e.g., using zFPKM). This assumes a gene (rows) by individual (columns) matrix. First, fixed effects (the two populations to be compared; here called species) and an optional number of random effects (here, sex and tissue) need to be defined like this:
```> spec <- rep(c("A","B"),each=10,times=2)
> tis <- rep(c("tis\_1","tis\_2"),each=20)
> sex <- rep(c("f","m","f","m"),each=5,times=2)
```
The function is then called as follows:
```> pst_data <- apply(dataset, 1, Pst, fixed=spec [, tis=tis, sex=sex])
```
*P*<sub>ST</sub>, *v*<sub>W</sub>, and *v*<sub>B</sub> are then retrieved as the three dataframe rows:
```> pst <- pst_data[1,]
> vW <- pst_data[2,]
> vB <- pst_data[3,]
```
Note that this formula allows for negative values in both *P*<sub>ST</sub> and variance. It is possible to constrain *P*<sub>ST</sub> at 0 depending on downstream analyses. I chose to not constrain *P*<sub>ST</sub>, because correlations are better done without such constraint.

[2] Leinonen *et al.* 2006: [Contrasting patterns of body shape and neutral genetic divergence in marine and lake populations of threespine sticklebacks](https://doi.org/10.1111/j.1420-9101.2006.01182.x). Journal of Evolutionary Biology 19:1803-1812.

[3] Antoniazza *et al.* 2010: [Local adaptation maintains clinal variation in melanin-based coloration of European barn owls (*Tyto alba*)](https://doi.org/10.1111/j.1558-5646.2010.00969.x). Evolution 64:1944-1954.

## tau.R

tau is a measure for tissue specificity of gene expression as described by Yanai and colleagues [4].

Usage: Summarise tissue replicates using mean() or similar. For it to function correctly, NA's must be 0. For a gene (rows) by tissue (columns) matrix, apply then as:
```> tau <- apply(dataset, 1, tau)
```
[4] Yanai *et al.* 2004: [Genome-wide midrange transcription profiles reveal expression level relationships in human tissue specification](https://doi.org/10.1093/bioinformatics/bti042). Bioinformatics 21:650-659.
