#Helping an Atlas user out by finding culivars in a list of plants.

barcodes <- read.csv("data/AFP_barcodes.csv", header = TRUE)

cult_pull <- read.csv("data/cult_mod_AFP.csv", header = TRUE)

match = sapply(cult_pull$barcode, function(x){
  barcodes$SrcID[barcodes$SrcID == x]
})

cultivar_notes = vector("character", length = nrow(barcodes))
barcodes = cbind(barcodes, cultivar_notes)
cleanup_tracker = vector("logical", length = length(match))

for(i in 1:length(match)){
  if(length(match[[i]]) == 1){
    barcodes$cultivar_notes[barcodes$SrcID==match[[i]]] = cult_pull$PlDescr[i]
    cleanup_tracker[i] = TRUE
  } else {
    cleanup_tracker[i] = FALSE
    #barcodes$cultivar_notes[barcodes$SrcID==match[[i]]] = NA
  }
}

matched_table = cult_pull[cleanup_tracker == TRUE,]

write.csv(matched_table, "data/cultivar_matches.csv")
write.csv(barcodes, "data/barcode_notes.csv")
