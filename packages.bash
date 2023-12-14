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
library(glmGamPoi);
library(glmnet);
library(RCircos);
library(magrittr);
library(stringr);
library(ggplot2);
library(clusterProfiler);
library(org.Hs.eg.db);
library(pROC);
library(igraph);
library(RColorBrewer);
library(Seurat);
library(glmGamPoi);
library(MetBrewer);
library(VennDiagram);
library(ggalluvial);
library(pheatmap);
library(ggExtra);
sessionInfo()
"

r_package_version=$(Rscript -e "$rscript")

echo `date`
echo "# R packages version"
echo '```'
echo "$r_package_version"
echo '```'




