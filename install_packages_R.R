setRepositories(ind = 1:2)

install_packages <- c(
    'Seurat',
    'circlize',
    'gridExtra',
    'statmod',
    'ggalt',
    'magick',
    'sctransform',
    'Rcpp',
    'ggpubr',
    'SoupX',
    'metap',
    'glmnet',
    'RCircos',
    'magrittr',
    'stringr',
    'ggplot2',
    'pROC',
    'igraph',
    'RColorBrewer',
    'MetBrewer',
    'VennDiagram',
    'ggalluvial',
    'pheatmap',
    'ggExtra',
    'foreach',
    'doParallel',
    'do'
)

bioc_packages <- c(
    'edgeR',
    'DESeq2',
    'limma',
    'PCAtools',
    'MAST',
    'org.Hs.eg.db',
    'dittoSeq',
    'scater',
    'glmGamPoi',
    'clusterProfiler',
    'glmGamPoi',
    'ComplexHeatmap'
)

# install_packages.R
tryCatch({
    install.packages(install_packages)
    BiocManager::install(bioc_packages)
    setRepositories(ind = 1:3, addURLs = c('https://satijalab.r-universe.dev', 'https://bnprks.r-universe.dev/'))
    install.packages(c('BPCells', 'presto', 'glmGamPoi'))
    install.packages('Signac')
   devtools::install_github('satijalab/seurat-data', quiet = TRUE)
   devtools::install_github('satijalab/azimuth', quiet = TRUE)
   devtools::install_github('satijalab/seurat-wrappers', quiet = TRUE)
   devtools::install_github('jinworks/CellChat',quiet=TRUE)
   devtools::install_github('erocoar/gghalves',quiet=TRUE)
    IRkernel::installspec(name = 'VSCODE_R', displayname = 'VSCODE_R', user = FALSE)
}, error = function(e) {
  # 若安装过程中出现错误，打印错误信息并退出
  message('R 包安装失败: ', conditionMessage(e))
  quit(status = 1)
})


