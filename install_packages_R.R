setRepositories(ind = 1:2)

install_packages <- c(
    "Seurat",
    "circlize",
    "gridExtra",
    "statmod",
    "ggalt",
    "magick",
    "sctransform",
    "Rcpp",
    "ggpubr",
    "SoupX",
    "metap",
    "glmnet",
    "RCircos",
    "magrittr",
    "stringr",
    "ggplot2",
    "pROC",
    "igraph",
    "RColorBrewer",
    "MetBrewer",
    "VennDiagram",
    "ggalluvial",
    "pheatmap",
    "ggExtra"
)

bioc_packages <- c(
    "edgeR",
    "DESeq2",
    "limma",
    "PCAtools",
    "MAST",
    "org.Hs.eg.db",
    "dittoSeq",
    "scater",
    "glmGamPoi",
    "multtest",
    "clusterProfiler",
    "glmGamPoi"
)

install.packages(install_packages)
BiocManager::install(bioc_packages)
devtools::install_github("satijalab/seurat-data")


IRkernel::installspec(name = "VSCODE_R", displayname = "VSCODE_R", user = FALSE)