"
[bdvisSamples.R]
This script takes biodiversity data and saves a series of data visualizations created
through the bdvis library to the working directory.
Matthew Sekirin
December 22nd, 2019
"

library(bdvis)
library(rgbif)
library(maps)

# read biodiversity data and output a summary
dat <- occ_search(scientificName = "Panthera leo", limit = 10000, hasCoordinate = TRUE)
dat <- format_bdvis(dat$data, "rgbif")
bdsummary(dat) 

# read country names
countriesData <- read.csv("https://gist.githubusercontent.com/stevewithington/20a69c0b6d2ff846ea5d35e5fc47f26c/raw/13716ceb2f22b5643ce5e7039643c86a0e0c6da6/country-and-continent-codes-list-csv.csv")
countriesData[,4] <- sapply(countriesData[,4], as.character)

# extract african country codes form countriesData
africa <- rep(NA, length(countriesData[,1]))
for (i in (1:length(countriesData[,1]))) {
 if (as.character(countriesData[i, 1]) == "Africa") {
   africa[i] <- countriesData[i, 4]
 }
}
africa[is.na(africa)] <- "ZZ"

# create gridded species density map
png("lion-africa.png")
mapgrid(dat, title = "Distribution of Panthera Leo Sightings in Africa", ptype = "species", 
        bbox = c(-40, 50, -40, 35), region = iso.expand(africa))
dev.off()

# create temporal plots
png("lion-records.png")
tempolar(dat, title = "Panthera Leo Records Temporal Distribution", color = "green", plottype = "r")
dev.off()
png("lion-records-detailed.png")
chronohorogram(dat, title = "Panthera Leo Records Temporal Distribution", 
               colors = c("red", "white"), ptsize = 0.5)
dev.off()

# create distribution graphs
png("lion-records-frequencies.png")
distrigraph(dat, ptype = "species", col = "burlywood")
dev.off()
png("lion-records-over-time.png")
distrigraph(dat, ptype = "effortspecies", col = "firebrick", cumulative = T, type = "l")
dev.off()

# create completeness graph
png("lion-records-completeness.png")
bdcomplete(dat, recs = 5)
dev.off()