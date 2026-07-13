#Helping an Atlas user out by finding culivars in a list of plants.

barcodes <- read.csv("data/AFP_barcodes.csv", header = TRUE)

cult_pull <- read.csv("data/cult_mod_AFP.csv", header = TRUE)

match = apply(cult_pull$barcode, function(x){
  barcodes$SrcID[barcodes$SrcID == x]
})



#for(i in 1:length(match)){
#  if(length(match[[i]]) >= 1){
#    id_pull = barcodes$SrcID[match[[i]]]
#  } else {}
#  print(id_pull)
#}

