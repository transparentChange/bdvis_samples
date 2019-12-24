'
[bdvisSamples.R]
This script takes biodiversity data and saves a series of data visualizations created
through the bdvis library to folders created in the working directory.
Matthew Sekirin
December 22nd, 2019
'

library(bdvis)
library(rgbif)
library(maps)

source("functionGetCountries.R")
source("FilePaths.R")

# read biodiversity data and output a summary
dat <- occ_search(scientificName = "Panthera leo", limit = 10000, hasCoordinate = TRUE)
dat <- format_bdvis(dat$data, "rgbif")
bdsummary(dat) 

# create and save images specific to species
speciesFiles <- new_FilePaths(c("density-map.png", "yearly-accumulation.png"), 
                              "./species/")
dir.create(dirname(speciesFiles[1]))

png(speciesFiles[1])
mapgrid(dat, title = "Distribution of Panthera Leo Sightings in Africa", ptype = "species", 
        bbox = c(-40, 50, -40, 35), region = getCountriesByContinent("Africa"))
dev.off()
png(speciesFiles[2])
distrigraph(dat, ptype = "effortspecies", col = "firebrick", cumulative = T, type = "l")
dev.off()

# create and save temporal plots specific to records
tempolarFiles <- new_FilePaths(c("daily.png", "weekly.png", "monthly.png", 
                                 "monthlyDetailed.png", "calendar.png", 
                                 "yearly-efforts.png"),
                               "./records_tempolar/")
dir.create(dirname(tempolarFiles[1]))

png(tempolarFiles[1])
tempolar(dat, title = "Daily Temporal Distribution of Records", color = "green", 
         plottype = "r", timescale = "d")
dev.off()
png(tempolarFiles[2])
tempolar(dat, title = "Weekly Temporal Distribution of Records", color = "green", 
         plottype = "r", timescale = "w")
dev.off()
png(tempolarFiles[3])
tempolar(dat, title = "Monthly Temporal Distribution of Records", color = "green", 
         plottype = "p", timescale = "m")
dev.off()
png(tempolarFiles[4])
chronohorogram(dat, title = "Panthera Leo Records Temporal Distribution", 
               colors = c("red", "white"), ptsize = 0.5)
dev.off()
png(tempolarFiles[5])
bdcalendarheat(dat)
dev.off()
png(tempolarFiles[6])
distrigraph(dat, ptype = "efforts")
dev.off()

# create and save other record distribution visualizations
otherFiles <- new_FilePaths(c("species-freq-over-records.png", "species-freq-over-cells.png", 
                              "density-map.png"), "./records_other/")
dir.create(dirname(otherFiles[1]))

png(otherFiles[1])
distrigraph(dat, ptype = "species", col = "burlywood")
dev.off()
png(otherFiles[2])
distrigraph(dat, ptype = "cell", col = "firebrick", cumulative = T, type = "l")
dev.off()
png(otherFiles[3])
mapgrid(dat, ptype = "records", title = "Density of Records on Panthera Leo")
dev.off()

# create and save completeness graph and map
completenessFiles <- new_FilePaths(c("completeness-vs-number-of-species.png", "comleteness-map.png"),
                                   "./records_completeness/")
dir.create(dirname(completenessFiles[1]))

png(completenessFiles[1])
comp = bdcomplete(dat, recs = 5)
dev.off()
png(completenessFiles[2])
mapgrid(comp, title = "Completeness of Records on Panthera Leo", ptype = "complete")
dev.off()