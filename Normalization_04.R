library('scRNAseq')
sce.zeisel <- ZeiselBrainData(ensembl = TRUE)

# Quality control
library('scater')
is.mito <- which(rowData(sce.zeisel)$featureType == "mito")
stats <- perCellQCMetrics(sce.zeisel, subsets = list(Mt = is.mito))
qc <-
    quickPerCellQC(stats,
        percent_subsets = c("altexps_ERCC_percent", "subsets_Mt_percent"))
sce.zeisel <- sce.zeisel[, !qc$discard]

#After downloading the data and performing quality control by discarding low-quality cells we will now estimate library size factors to eliminate 
#individual-cell bias.

#Exercise

lib.sf.zeisel <- librarySizeFactors(sce.zeisel)

ls.zeisel <- colSums(counts(sce.zeisel))

#Are ls.zeisel and lib.sf.zeisel identical?
#The librarySizeFactors documentation gives us insight on what the function is doing: "Define per-cell size factors from the library sizes (i.e., total sum of counts per cell)."
#So it does the same as the code in line 20. To prove it we will use the identical() function on the two vectors. 

>identical(lib.sf.zeisel,ls.zeisel)
#[1] TRUE

#Are they proportional?
#Two values are proportional if you can multiply one by a factor and obtain the second one:  a * b = c. Here we say that a and c are proportional.


