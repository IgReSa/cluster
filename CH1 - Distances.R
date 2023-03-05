install.packages("sf")
install.packages("sp")
install.packages("riverdist")
install.packages("tidyverse")

library(sf)
library(sp)
library(riverdist)
library(tidyverse)

load("REC_islands.RData")
load("NZFFD_islands.RData")
load("Gauges_islands.RData")

# Calculate distances for the North Island
NI_rNet <- line2network(NI_rec) # First, we need to create the river network object to calculate distances 
save(NI_rNet, file = "NI_rNet.RData")

NI_cdec_gau <- xy2segvert(x = NI_gauges$eastingNZTM, y = NI_gauges$northingNZTM, rivers = NI_rNet) # Create the segvert for both point dataframes
NI_cdec_nzffd <- xy2segvert(x = NI_nzffd$midcoordX, y = NI_nzffd$midcoordY, rivers=NI_rNet)
save(NI_cdec_gau, NI_cdec_nzffd, file = "NI_segvert.RData")


NI_distances <- riverdistancetofrom(seg1 = NI_cdec_nzffd$seg, vert1=NI_cdec_nzffd$vert, #Calculate distances along the NI river network
                                 seg2 = NI_cdec_gau$seg, vert2 = NI_cdec_gau$vert, rivers = NI_rNet)
save(NI_distances, file = "NI_distmat.RData")

# Calculate distances for the South Island 
SI_rNet <- line2network(SI_rec) # First, we need to create the river network object to calculate distances 
save(SI_rNet, file = "SI_rNet.RData")

SI_cdec_gau <- xy2segvert(x = SI_gauges$eastingNZTM, y = SI_gauges$northingNZTM, rivers = SI_rNet) # Create the segvert for both point dataframes
SI_cdec_nzffd <- xy2segvert(x = SI_nzffd$midcoordX, y = SI_nzffd$midcoordY, rivers=SI_rNet)
save(SI_cdec_gau, SI_cdec_nzffd, file = "SI_segvert.RData")


distances <- riverdistancetofrom(seg1 = SI_cdec_nzffd$seg, vert1=SI_cdec_nzffd$vert, #Calculate distances along the NI river network
                                 seg2 = SI_cdec_gau$seg, vert2 = SI_cdec_gau$vert, rivers = SI_rNet)
save(SI_distances, file = "SI_distmat.RData")
