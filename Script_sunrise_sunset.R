##############################################################################################################
# This script allows to extract the hours of sunset and sunrise for given nights at given sites 
# It returns the table given as an argument with two new columns (sunset and sunrise)
##############################################################################################################

### Argument ###

# tableNightsSites : a table with (minimum):
# -> a column named "Latitude" with the site latitude in WGS84
# -> a column named "Longitude" with the site longitude in WGS84
# -> a column named "Date" with the night date (date when the night began), 
#    it should be either a string written in this format "YYYY-MM-DD" or "POSIXct" "POSIXt" object.

##############################################################################################################

extract_sunrise_sunset <- function(tableNightsSites){

  #load packages
  load <- function(pkg){
    new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
    if (length(new.pkg))
      install.packages(new.pkg, dependencies = TRUE)
    sapply(pkg, require, character.only = TRUE)
  } 
  packages <- c("lubridate","StreamMetabolism")
  load(packages)
  
  #date formatting
    if (all(class(tableNightsSites$Date)!=c("POSIXct","POSIXt"))){
    tableNightsSites$Date <- parse_date_time(as.character(tableNightsSites$Date),"%Y-%m-%d", tz="Europe/Paris")
  }

  #Sunrise and sunset time
  calc_sunrise_set <- function(x,y,z){
    tabsun <- sunrise.set(x,y,z,num.days = 2)
    tabsun[1,1] <- tabsun[2,1]
    tabsun <- tabsun[-2,]
    return(as.vector(tabsun))
  }
  
  tableNightsSites$sunrise <- rep(NA,dim(tableNightsSites)[1])
  tableNightsSites$sunset <- rep(NA,dim(tableNightsSites)[1])
  
  tableNightsSites[,c("sunrise","sunset")] <- as.data.frame(t(mapply(calc_sunrise_set,tableNightsSites$Latitude,tableNightsSites$Longitude,tableNightsSites$Date)))
  tableNightsSites$sunset <- as_datetime(as.numeric(tableNightsSites$sunset),tz="Europe/Paris")
  tableNightsSites$sunrise <- as_datetime(as.numeric(tableNightsSites$sunrise),tz="Europe/Paris")
  
  return(tableNightsSites)
  
}
