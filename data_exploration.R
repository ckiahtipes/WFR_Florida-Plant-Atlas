#Some R Basics using Atlas of Florida Plants data.

Carex <- read.csv("Carex_FL.csv", header = TRUE)

#Some basic information can be retrieved immediately.

species = unique(Carex$species)

Carex_counties = table(Carex$county)

#We can even do a fast barplot.

barplot(Carex_counties,
        horiz = TRUE,
        las = 1,
        cex.names = 0.5)

#This reveals that we need to do some data cleanup (null county entry).

Carex_clean = Carex[Carex$county != "null",] #We employ some R syntax here to drop null entries.

Carex_counties = table(Carex_clean$county)

barplot(table(Carex_clean$county), #You can fold the table command into the barplot call.
        horiz = TRUE,
        las = 1,
        cex.names = 0.5)

###Optional - clean this plot up a little.

#We can look for which counties have the most individual species.

county_list = sapply(names(Carex_counties), function(x){
  pull = Carex[Carex$county == x,]
  n = unique(pull$species)
})

county_count = lapply(county_list, length)

county_count = as.matrix(county_count)

#Set plot parameters and make barplot

par(mar = c(5, 8, 4, 2) + 0.1)

barplot(t(county_count),
        horiz = TRUE,
        las = 1,
        cex.names = 0.8,
        col = "darkgreen")

par(mar = c(5, 4, 4, 2) + 0.1)

#With great caution we can use some spatial info...

Carex_clean$LatDecL[Carex_clean$species == "verrucosa"]

#It is reading this as characters and includes "null"

Carex_clean = Carex_clean[Carex_clean$LatDecL != "null" & Carex_clean$LongDecL != "null", ]

#Now we make it numeric data.

Carex_clean$LatDecL = as.numeric(Carex_clean$LatDecL)
Carex_clean$LongDecL = as.numeric(Carex_clean$LongDecL)

#Now we can plot it.

boxplot(Carex_clean$LatDecL[Carex_clean$species == "alata"])

#We can look at ranges

Carex_Lats = sapply(species, function(x){
  Carex_clean$LatDecL[Carex_clean$species == x]
})

#Combine these into one matrix

par(mar = c(5, 8, 4, 2) + 0.1)

boxplot(Carex_Lats, 
        horizontal = TRUE, 
        las = 1, 
        cex.axis = 0.8, 
        ylim = c(25,31),
        col = "forestgreen")

par(mar = c(5, 4, 4, 2) + 0.1)

#Let's look at dates.

Carex_clean = Carex_clean[is.na(Carex_clean$Collection.Date) == FALSE | Carex_clean$Collection.Date == "05/15/1976", ]

Carex_dates = Carex_clean$Collection.Date

coll_dates = as.Date(Carex_clean$Collection.Date, tryFormats = c("%m/%d/%Y", "%d %b %Y"))

coll_dates = coll_dates[is.na(coll_dates) == FALSE]
Carex_clean = Carex_clean[is.na(coll_dates) == FALSE, ]

coll_yr = format(coll_dates, format = "%Y")
coll_mn = format(coll_dates, format = "%m")
coll_dy = format(coll_dates, format = "%d")

plot(coll_yr, coll_mn)

sp_bymon = sapply(species, function(x){
  as.numeric(coll_mn[Carex_clean$species == x])
})

boxplot(sp_bymon,
        horizontal = TRUE, 
        las = 1,
        cex.axis = 0.8)
