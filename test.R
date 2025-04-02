#! /bin/env Rscript

args <- commandArgs(trailingOnly = FALSE)
script_path <- sub("--file=", "", args[grep("--file=", args)])
script_dir <- dirname(script_path)

base_packages <- scan(file.path(script_dir, "CRAN_packages.txt"), what="", sep="\n")
bioc_packages <- scan(file.path(script_dir, "bioconductor_packages.txt"), what="", sep="\n")
github_packages <-  read.table(file.path(script_dir, "devtools_packages.txt"), 
                               header = FALSE, 
                               stringsAsFactors = FALSE)

all_packages <- unique(c(base_packages, bioc_packages, github_packages$V2))
for (pkg in all_packages) {
    if (!require(pkg, character.only = TRUE)) {
        stop(paste("Package load filled:", pkg))
    }
}

for (pkg in all_packages) {
    library(pkg,character.only=TRUE)
}


pbmc_data <- Read10X(data.dir = "test_data/filtered_gene_bc_matrices/hg19/")
pbmc <- CreateSeuratObject(counts = pbmc_data)
pbmc <- PercentageFeatureSet(pbmc, pattern = "^MT-", col.name = "percent.mt")

# run sctransform
pbmc <- SCTransform(pbmc, vars.to.regress = "percent.mt", verbose = FALSE)


pbmc <- RunPCA(pbmc, verbose = FALSE)
pbmc <- RunUMAP(pbmc, dims = 1:30, verbose = FALSE)

pbmc <- FindNeighbors(pbmc, dims = 1:30, verbose = FALSE)
pbmc <- FindClusters(pbmc, verbose = FALSE)



p1 <- DimPlot(pbmc, label = TRUE)

ggsave('test_data/figures/test.png',p1 ,width=10,height=10)


p2<-VlnPlot(pbmc, features = c("CD8A", "GZMK", "CCL5", "S100A4", "ANXA1", "CCR7", "ISG15", "CD3D"),
    pt.size = 0.2, ncol = 4)

ggsave('test_data/figures/test2.png',p2,width=10,height=20)

p3 <-FeaturePlot(pbmc, features = c("CD8A", "GZMK", "CCL5", "S100A4", "ANXA1", "CCR7"), pt.size = 0.2,
    ncol = 3)


ggsave('test_data/figures/test3.png',p3,width=20,height=30)

p4<- FeaturePlot(pbmc, features = c("CD3D", "ISG15", "TCL1A", "FCER2", "XCL1", "FCGR3A"), pt.size = 0.2,
    ncol = 3)

ggsave('test_data/figures/test4.png',p4,width=20,height=30)

features <- c("LYZ", "CCL5", "IL32", "PTPRCAP", "FCGR3A", "PF4")

p5 <- RidgePlot(pbmc, features = features, ncol = 2)

ggsave('test_data/figures/test5.png',p5,width=20,height=30)


p6<-DotPlot(pbmc, features = features) + RotatedAxis()
ggsave('test_data/figures/test6.png',p6,width=10,height=10)

p7<- DoHeatmap(subset(pbmc, downsample = 100), features = features, size = 3)
ggsave('test_data/figures/test7.png',p7,width=10,height=10)

p8<-FeaturePlot(pbmc, features = c("MS4A1", "CD79A"), blend = TRUE)

ggsave('test_data/figures/test8.png',p8,width=10,height=10)

p9<-VlnPlot(pbmc, features = "percent.mt")

ggsave('test_data/figures/test9.png',p9,width=10,height=10)

p10<-DotPlot(pbmc, features = features) + RotatedAxis()
ggsave('test_data/figures/test10.png',p10,width=10,height=10)
p11 <- DoHeatmap(pbmc, features = VariableFeatures(pbmc)[1:100], cells = 1:500, size = 4,
    angle = 90) + NoLegend()
ggsave('test_data/figures/test11.png',p11,width=10,height=10)
