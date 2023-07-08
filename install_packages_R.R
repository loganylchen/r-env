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
#     "clusterProfiler",
    "dittoSeq",
    "scater",
    "glmGamPoi"
)

install.packages(install_packages)

# for (l in install_packages) {
#     install.packages(l, dependencies = TRUE)
#     if (!library(l, character.only = TRUE, logical.return = TRUE)) {
#         quit(status = 1, save = "no")
#     }
# }

# devtools::install_github("YuLab-SMU/ggtree")
# if (!library(ggtree, logical.return = TRUE)) {
#     quit(status = 1, save = "no")
# }

# for (l in bioc_packages) {
#     BiocManager::install(l)
#     if (!library(l, character.only = TRUE, logical.return = TRUE)) {
#         quit(status = 1, save = "no")
#     }
# }

BiocManager::install(bioc_packages)

# devtools::install_github("jokergoo/ComplexHeatmap")
# if (!library(ComplexHeatmap, logical.return = TRUE)) {
#     quit(status = 1, save = "no")
# }
# devtools::install_github("immunogenomics/presto")
# if (!library(presto, logical.return = TRUE)) {
#     quit(status = 1, save = "no")
# }

# devtools::install_github("neurorestore/Libra")
# if (!library(Libra, logical.return = TRUE)) {
#     quit(status = 1, save = "no")
# }


devtools::install_github("satijalab/seurat-data")
if (!library(SeuratData, logical.return = TRUE)) {
    quit(status = 1, save = "no")
}


IRkernel::installspec(name = "VSCODE_DKD_R", displayname = "VSCODE_DKD_R", user = FALSE)