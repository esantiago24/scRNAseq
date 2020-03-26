#Exercise

qc.lib_true<-which(qc.lib == TRUE)
qc.spike_true<-which(qc.spike== TRUE)
qc.mito_true<-which(qc.mito==TRUE)

###########
qc.lib_true
[1] 123 129 191
> qc.spike_true
[1]  14  21  22  37  44  47  53  54  69  70  71  75  85  87  92  93 165 167 191
> qc.mito_true
[1]  22  62  67  75  97  98 101 104 106 125 127 130 133 152

> intersect(qc.lib_true,qc.spike_true)
[1] 191
> intersect(qc.lib_true,qc.mito_true)
integer(0)
##########
