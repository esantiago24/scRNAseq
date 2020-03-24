-------------------------------------------------------------------------
library('scRNAseq')
library('scater')
library('scran')
library('plotly')

--------------------------------------------------------------------------------
#Load object
sce <- scRNAseq::MacoskoRetinaData()

## How big is the data?
pryr::object_size(sce)

## How does it look?
sce

# Quality control.
is.mito <- grepl("^MT-", rownames(sce))
qcstats <-
    scater::perCellQCMetrics(sce, subsets = list(Mito = is.mito))
filtered <-
    scater::quickPerCellQC(qcstats, percent_subsets = "subsets_Mito_percent")
sce <- sce[, !filtered$discard]

# Normalization.
sce <- scater::logNormCounts(sce)

# Feature selection.
dec <- scran::modelGeneVar(sce)
hvg <- scran::getTopHVGs(dec, prop = 0.1)

# Dimensionality reduction.
set.seed(1234)
sce <- scater::runPCA(sce, ncomponents = 25, subset_row = hvg)
sce <- scater::runUMAP(sce, dimred = 'PCA', external_neighbors = TRUE)

# Clustering.
g <- scran::buildSNNGraph(sce, use.dimred = 'PCA')
sce$clusters <- factor(igraph::cluster_louvain(g)$membership)

# Visualization.
scater::plotUMAP(sce, colour_by = "clusters")

## # Interactive visualization
p <- scater::plotUMAP(sce, colour_by = "clusters")
plotly::ggplotly(p)
