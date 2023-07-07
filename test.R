#! /bin/env Rscript


library(Seurat)
library(SeuratData)
library(patchwork)
library(ggplot2)
library(cowplot)


InstallData("ifnb")

LoadData("ifnb")
ifnb.list <- SplitObject(ifnb, split.by = "stim")
ifnb.list <- lapply(X = ifnb.list, FUN = SCTransform)
features <- SelectIntegrationFeatures(object.list = ifnb.list, nfeatures = 3000)
ifnb.list <- PrepSCTIntegration(object.list = ifnb.list, anchor.features = features)

immune.anchors <- FindIntegrationAnchors(object.list = ifnb.list, normalization.method = "SCT",
    anchor.features = features)
immune.combined.sct <- IntegrateData(anchorset = immune.anchors, normalization.method = "SCT")
immune.combined.sct <- RunPCA(immune.combined.sct, verbose = FALSE)
immune.combined.sct <- RunUMAP(immune.combined.sct, reduction = "pca", dims = 1:30)

p1 <- DimPlot(immune.combined.sct, reduction = "umap", group.by = "stim")
p2 <- DimPlot(immune.combined.sct, reduction = "umap", group.by = "seurat_annotations", label = TRUE,
    repel = TRUE)
ggsave('test.png',p1 + p2,width=20,height=10)


markers.to.plot <- c("CD3D", "CREM", "HSPH1", "SELL", "GIMAP5", "CACYBP", "GNLY", "NKG7", "CCL5",
    "CD8A", "MS4A1", "CD79A", "MIR155HG", "NME1", "FCGR3A", "VMO1", "CCL2", "S100A9", "HLA-DQA1",
    "GPR183", "PPBP", "GNG11", "HBA2", "HBB", "TSPAN13", "IL3RA", "IGJ", "PRSS57")
p3<-DotPlot(immune.combined.sct, features = markers.to.plot, cols = c("blue", "red"), dot.scale = 8, split.by = "stim") +
    RotatedAxis()

ggsave('test2.png',p3,width=10,height=20)



immune.combined.sct$celltype.stim <- paste(immune.combined.sct$seurat_annotations, immune.combined.sct$stim,
    sep = "_")
Idents(immune.combined.sct) <- "celltype.stim"

immune.combined.sct <- PrepSCTFindMarkers(immune.combined.sct)

b.interferon.response <- FindMarkers(immune.combined.sct, assay = "SCT", ident.1 = "B_STIM", ident.2 = "B_CTRL",
    verbose = FALSE)
head(b.interferon.response, n = 15)

immune.combined.sct.subset <- subset(immune.combined.sct, idents = c("B_STIM", "B_CTRL"))
b.interferon.response.subset <- FindMarkers(immune.combined.sct.subset, assay = "SCT", ident.1 = "B_STIM",
    ident.2 = "B_CTRL", verbose = FALSE, recorrect_umi = FALSE)

Idents(immune.combined.sct) <- "seurat_annotations"
DefaultAssay(immune.combined.sct) <- "SCT"
p4<- FeaturePlot(immune.combined.sct, features = c("CD3D", "GNLY", "IFI6"), split.by = "stim", max.cutoff = 3,
    cols = c("grey", "red"))
ggsave('test3.png',p4,width=20,height=30)

plots <- VlnPlot(immune.combined.sct, features = c("LYZ", "ISG15", "CXCL10"), split.by = "stim",
    group.by = "seurat_annotations", pt.size = 0, combine = FALSE)
p5<- wrap_plots(plots = plots, ncol = 1)
ggsave('test4.png',p5,width=10,height=30)