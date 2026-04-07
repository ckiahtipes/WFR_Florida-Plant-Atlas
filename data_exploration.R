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

barplot(table(Carex_clean$county), #You can fold the table command into the barplot call.
        horiz = TRUE,
        las = 1,
        cex.names = 0.5)

Carex[Carex$county == "null", ]

###Optional - clean this plot up a little.

#We can look for which counties have the most individual species.















