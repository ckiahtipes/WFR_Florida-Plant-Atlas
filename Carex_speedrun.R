###N FL Carex stuff

#Libraries

library(spData)
library(sf)
data("us_states")

carex_cnty = read.csv("data/Carex_spsearch.csv", header = TRUE)

#Fast takes on how many have photos in the database and where we might find them wetland-wise.

photos = table(carex_cnty$Photo.s.)

barplot(photos)

wetland = table(carex_cnty$DEP)

barplot(wetland)

#Endangered/Listed

listed = carex_cnty[carex_cnty$Status.State == "Threatened-State", ]

listed

#Photos plus nativity.

#Step one, we break the first table down by native and introduced plants. Just subsetting using the binary "Y" or "N" in that column.

native = carex_cnty[carex_cnty$Native == "Y",]

introd = carex_cnty[carex_cnty$Native == "N",]

#Now that they're grouped, we use table() to give us a quick count of photo status in each category.

nat_ph = table(native$Photo.s.)
int_ph = table(introd$Photo.s.)

#These are tables with the same columns, so they can be glued together again.

photo_table = rbind(nat_ph, int_ph)

#We can do this for categories we already have.

OBLw = carex_cnty[carex_cnty$DEP == "OBL",]
FACw = carex_cnty[carex_cnty$DEP == "FACW",]

#Now we table them.

o_ph = table(OBLw$Photo.s.)
f_ph = table(FACw$Photo.s.)

#Now we bind them into one table

wtph_table = rbind(o_ph, f_ph)

#Now barplots

barplot(wtph_table, horiz = TRUE, main = "N Carex Species by DEP Status and Photo Status", col = c("goldenrod", "forestgreen"))
legend("bottomright", c("OBL", "FACW"), pch = 22, pt.bg = c("goldenrod", "forestgreen"))

#We insert a t() function around wtph_table here to transpose it.

barplot(t(wtph_table), horiz = TRUE, main = "N Carex Species by DEP Status and Photo Status", col = c("goldenrod", "forestgreen"))
legend("bottomright", c("No Photo", "Photo"), pch = 22, pt.bg = c("goldenrod", "forestgreen"))

#Mapping Chapmanii

chap = read.csv("data/C_chapmanii.csv", header = TRUE)

#Clean up data by removing NA values.


plottable = chap[chap$LatDecL != "null" & chap$LongDecL != "null",]

#Counties

counties = read_sf("mapping/cb_2024_us_county_500k/cb_2024_us_county_500k.shp")

#Subset county polygons by state

FL = counties$STATE_NAME == "Florida"
FL_counties = counties[FL, ]

#plot it

plot(FL_counties$geometry) #This plots just the shape of the counties
points(as.numeric(plottable$LongDecL), as.numeric(plottable$LatDecL), pch = 21, bg = "goldenrod") #This adds points from C. chapmanii table, note that we are forcing it to read the data as numbers.

#Look for last collections in Leon and Gadsden counties

chap$county == "Leon Co."
chap$county == "Gadsden Co."

#Looking at collecting/photo priorities - no photos/no specimens

colls = carex_cnty[carex_cnty$Photo.s. == "N" | carex_cnty$Specimens == "N", ]

coll_print = colls[, c(4,2,8,3,6,7)]

write.csv(coll_print, "carex_list.csv")





