#! /bin/bash

#! /bin/bash
set -e
set -o pipefail
set -x

rscript="
library(Seurat);
library(circlize);
library(gridExtra);
library(statmod);
library(ggalt);
library(magick);
library(sctransform);
library(Rcpp);
library(ggpubr);
library(edgeR);
library(DESeq2);
library(limma);
library(PCAtools);
library(MAST);
library(org.Hs.eg.db);
library(dittoSeq);
library(scater);
library(glmGamPoi)
sessionInfo()
"

r_package_version=$(Rscript -e "$rscript")

echo `date`
echo "# R packages version"
echo '```'
echo "$r_package_version"
echo '```'




