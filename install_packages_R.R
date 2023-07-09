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
    "ggpubr"
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
    "glmGamPoi"
)

install.packages(install_packages)
BiocManager::install(bioc_packages)
devtools::install_github("satijalab/seurat-data")
if (!library(SeuratData, logical.return = TRUE)) {
    quit(status = 1, save = "no")
}

IRkernel::installspec(name = "VSCODE_R", displayname = "VSCODE_R", user = FALSE)