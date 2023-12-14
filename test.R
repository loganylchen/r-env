#! /bin/env Rscript


library(Seurat)
library(SeuratData)
library(patchwork)
library(ggplot2)
library(cowplot)
library(glmnet)
library(RCircos)
library(magrittr)
library(stringr)
library(ggplot2)
library(clusterProfiler)
library(org.Hs.eg.db)
library(pROC)
library(igraph)
library(RColorBrewer)
library(Seurat)
library(glmGamPoi)
library(MetBrewer)
library(VennDiagram)
library(ggalluvial)
library(pheatmap)
library(ggExtra)


pbmc_data <- Read10X(data.dir = "filtered_gene_bc_matrices/hg19/")
pbmc <- CreateSeuratObject(counts = pbmc_data)
pbmc <- PercentageFeatureSet(pbmc, pattern = "^MT-", col.name = "percent.mt")

# run sctransform
pbmc <- SCTransform(pbmc, vars.to.regress = "percent.mt", verbose = FALSE)


pbmc <- RunPCA(pbmc, verbose = FALSE)
pbmc <- RunUMAP(pbmc, dims = 1:30, verbose = FALSE)

pbmc <- FindNeighbors(pbmc, dims = 1:30, verbose = FALSE)
pbmc <- FindClusters(pbmc, verbose = FALSE)



p1 <- DimPlot(pbmc, label = TRUE)

ggsave('test.png',p1 ,width=10,height=10)


p2<-VlnPlot(pbmc, features = c("CD8A", "GZMK", "CCL5", "S100A4", "ANXA1", "CCR7", "ISG15", "CD3D"),
    pt.size = 0.2, ncol = 4)

ggsave('test2.png',p2,width=10,height=20)

p3 <-FeaturePlot(pbmc, features = c("CD8A", "GZMK", "CCL5", "S100A4", "ANXA1", "CCR7"), pt.size = 0.2,
    ncol = 3)


ggsave('test3.png',p3,width=20,height=30)

p4<- FeaturePlot(pbmc, features = c("CD3D", "ISG15", "TCL1A", "FCER2", "XCL1", "FCGR3A"), pt.size = 0.2,
    ncol = 3)

ggsave('test4.png',p4,width=20,height=30)

features <- c("LYZ", "CCL5", "IL32", "PTPRCAP", "FCGR3A", "PF4")

p5 <- RidgePlot(pbmc, features = features, ncol = 2)

ggsave('test5.png',p5,width=20,height=30)


p6<-DotPlot(pbmc, features = features) + RotatedAxis()
ggsave('test6.png',p6,width=10,height=10)

p7<- DoHeatmap(subset(pbmc, downsample = 100), features = features, size = 3)
ggsave('test7.png',p7,width=10,height=10)

p8<-FeaturePlot(pbmc, features = c("MS4A1", "CD79A"), blend = TRUE)

ggsave('test8.png',p8,width=10,height=10)

p9<-VlnPlot(pbmc, features = "percent.mt")

ggsave('test9.png',p9,width=10,height=10)

p10<-DotPlot(pbmc, features = features) + RotatedAxis()
ggsave('test10.png',p10,width=10,height=10)
p11 <- DoHeatmap(pbmc, features = VariableFeatures(pbmc)[1:100], cells = 1:500, size = 4,
    angle = 90) + NoLegend()
ggsave('test11.png',p11,width=10,height=10)
