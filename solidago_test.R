###Looking at flowering times for different plants and how to use this to track environmental change.

solidago <- read.csv("data/Solidago_pull.csv", header = TRUE)

#Step one, clean up data - need to be able to work with days, months, and years separately.

coll_dates = as.Date(solidago$Collection.Date, tryFormats = c("%m/%d/%Y", "%d %b %Y"))

coll_dates = coll_dates[is.na(coll_dates) == FALSE]
Carex_clean = Carex_clean[is.na(coll_dates) == FALSE, ]

coll_yr = format(coll_dates, format = "%Y")
coll_mn = format(coll_dates, format = "%m")
coll_dy = format(coll_dates, format = "%d")

#Can make a vector coding colors for reproductive state.

rep_types = unique(solidago$RepState1)
rep_color = c("goldenrod", "tan", "darkorange", "darkgreen", "tan", NA)
rep_state = vector("numeric", length = length(coll_dates))

for(i in 1:length(rep_types)){
  rep_state[solidago$RepState1 == rep_types[i]] = rep_color[i]
}

#Plot it

plot(coll_yr, coll_mn, pch = 21, bg = rep_state)

#Plot is a bit inconclusive, maybe we only go for the common species - S. fistulosa, S. odora, S. sempervirens, and S. stricta.

solidago_select = solidago[solidago$genus == "Solidago" | solidago$species == "fistulosa" | solidago$species == "odora" | solidago$species == "sempervirens" | solidago$species == "stricta", ]
rep_state = rep_state[solidago$genus == "Solidago" | solidago$species == "fistulosa" | solidago$species == "odora" | solidago$species == "sempervirens" | solidago$species == "stricta"]

coll_yr = coll_yr[solidago$genus == "Solidago" | solidago$species == "fistulosa" | solidago$species == "odora" | solidago$species == "sempervirens" | solidago$species == "stricta"]
coll_mn = coll_mn[solidago$genus == "Solidago" | solidago$species == "fistulosa" | solidago$species == "odora" | solidago$species == "sempervirens" | solidago$species == "stricta"]
coll_dy = coll_dy[solidago$genus == "Solidago" | solidago$species == "fistulosa" | solidago$species == "odora" | solidago$species == "sempervirens" | solidago$species == "stricta"]

#Re-plot

plot(coll_yr, coll_mn, pch = 21, bg = rep_state)

#Might see more patterns numerically - method below works, but it needs to be made more efficient and needs to be sorted by rep. state.
###Worth thinking about how to make this easier to operate in general such that you can feed it any dataset and get some feedback.

mean(as.numeric(coll_mn[solidago_select$species == "fistulosa" & coll_yr < 1969]))
mean(as.numeric(coll_mn[solidago_select$species == "fistulosa" & coll_yr < 1979 & coll_yr > 1970]))
mean(as.numeric(coll_mn[solidago_select$species == "fistulosa" & coll_yr < 1989 & coll_yr > 1980]))
mean(as.numeric(coll_mn[solidago_select$species == "fistulosa" & coll_yr < 1999 & coll_yr > 1990]))
mean(as.numeric(coll_mn[solidago_select$species == "fistulosa" & coll_yr < 2009 & coll_yr > 2000]))
mean(as.numeric(coll_mn[solidago_select$species == "fistulosa" & coll_yr < 2020 & coll_yr > 2010]))


mean(as.numeric(coll_mn[solidago_select$species == "odora"]))
mean(as.numeric(coll_mn[solidago_select$species == "sempervirens"]))
mean(as.numeric(coll_mn[solidago_select$species == "stricta"]))

#Should bin by decade to start.

