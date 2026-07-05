###Looking at flowering times for different plants and how to use this to track environmental change.

solidago <- read.csv("data/Solidago_pull.csv", header = TRUE)

#Step one, clean up data - need to be able to work with days, months, and years separately.

coll_dates = as.Date(solidago$Collection.Date, tryFormats = c("%m/%d/%Y", "%d %b %Y"))

coll_dates = coll_dates[is.na(coll_dates) == FALSE]
#Carex_clean = Carex_clean[is.na(coll_dates) == FALSE, ]

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

solidago_select = solidago[solidago$genus == "Solidago" | solidago$species == "fistulosa" | solidago$species == "odora" | solidago$species == "sempervirens" | solidago$species == "stricta" & solidago$RepState1 == "Flower", ]
rep_state = rep_state[solidago$genus == "Solidago" | solidago$species == "fistulosa" | solidago$species == "odora" | solidago$species == "sempervirens" | solidago$species == "stricta" & solidago$RepState1 == "Flower"]

coll_yr = coll_yr[solidago$genus == "Solidago" | solidago$species == "fistulosa" | solidago$species == "odora" | solidago$species == "sempervirens" | solidago$species == "stricta" & solidago$RepState1 == "Flower"]
coll_mn = coll_mn[solidago$genus == "Solidago" | solidago$species == "fistulosa" | solidago$species == "odora" | solidago$species == "sempervirens" | solidago$species == "stricta" & solidago$RepState1 == "Flower"]
coll_dy = coll_dy[solidago$genus == "Solidago" | solidago$species == "fistulosa" | solidago$species == "odora" | solidago$species == "sempervirens" | solidago$species == "stricta" & solidago$RepState1 == "Flower"]

#Re-plot

plot(coll_yr, coll_mn, pch = 21, bg = rep_state)

#Might see more patterns numerically - method below works, but it needs to be made more efficient and needs to be sorted by rep. state.
###Worth thinking about how to make this easier to operate in general such that you can feed it any dataset and get some feedback.

#mean(as.numeric(coll_mn[solidago_select$species == "fistulosa" & coll_yr < 1969]))
#mean(as.numeric(coll_mn[solidago_select$species == "fistulosa" & coll_yr < 1979 & coll_yr > 1970]))
#mean(as.numeric(coll_mn[solidago_select$species == "fistulosa" & coll_yr < 1989 & coll_yr > 1980]))
#mean(as.numeric(coll_mn[solidago_select$species == "fistulosa" & coll_yr < 1999 & coll_yr > 1990]))
#mean(as.numeric(coll_mn[solidago_select$species == "fistulosa" & coll_yr < 2009 & coll_yr > 2000]))
#mean(as.numeric(coll_mn[solidago_select$species == "fistulosa" & coll_yr < 2020 & coll_yr > 2010]))
#
#
#mean(as.numeric(coll_mn[solidago_select$species == "odora"]))
#mean(as.numeric(coll_mn[solidago_select$species == "sempervirens"]))
#mean(as.numeric(coll_mn[solidago_select$species == "stricta"]))

#Make a matrix of decades and months.

sdg_decade = matrix(nrow = 12, ncol = 6)

num_decades = seq(1960, 2010, 10)
decades = c("1960s", "1970s", "1980s", "1990s", "2000s", "2010s")
months = c("JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC")

colnames(sdg_decade) = decades
row.names(sdg_decade) = months

for(i in 1:ncol(sdg_decade)){
  if(i == 6){
    pull = solidago_select[coll_yr > num_decades[i],]
    m_pull = as.numeric(coll_mn[coll_yr > num_decades[i]])
  } else {
    pull = solidago_select[coll_yr > num_decades[i] & coll_yr < num_decades[i+1],]
    m_pull = as.numeric(coll_mn[coll_yr > num_decades[i] & coll_yr < num_decades[i+1]])
  }
  
  mn_count = table(m_pull)
  
  for(j in 1:length(mn_count)){
    sdg_decade[as.numeric(names(mn_count[j])),i] = mn_count[[j]]
  }
  
}

#Calendar het map plot

plot(0, 0, pch = NA, axes = FALSE, ann = FALSE, xlim = c(0,7), ylim = c(0,13))

palette(rev(heat.colors(10)))

for(i in 1:ncol(sdg_decade)){
  points(rep(i, 12), 1:12, pch = 22, bg = sdg_decade[,i], cex = 4)
}

axis(1, c(1:6), decades, tick = FALSE, las = 2)
axis(2, c(1:12), months, las = 1, cex = 0.75, tick = FALSE)

title(main = "Solidago Flowering Months 1960-2020")









