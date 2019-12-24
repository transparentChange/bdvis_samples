'
getCountriesByContinent
This function converts the country codes taken from an online data set of a 
continent specified by the parameter and returns a list of countries for the world map 
@param continent, a character specifying the continent of interest
@return iso.expand(countryCodes), a list of countries named in such a way that they
will be recognized when creating maps
'
getCountriesByContinent <- function(continent) {
  countriesData <- read.csv("https://gist.githubusercontent.com/stevewithington/20a69c0b6d2ff846ea5d35e5fc47f26c/raw/13716ceb2f22b5643ce5e7039643c86a0e0c6da6/country-and-continent-codes-list-csv.csv")
  countriesData[,4] <- sapply(countriesData[,4], as.character)
  countryCodes <- rep(NA, length(countriesData[,1]))
  for (i in (1:length(countriesData[,1]))) {
    if (as.character(countriesData[i, 1]) == continent) {
      countryCodes[i] <- countriesData[i, 4]
    }
  }
  countryCodes[is.na(countryCodes)] <- "ZZ"
  
  iso.expand(countryCodes)
}