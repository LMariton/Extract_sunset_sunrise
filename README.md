# Extract_sunset_sunrise

This script extracts the hours of sunset and sunrise for given nights at given sites.

A table with the night dates (dates of the beginning of the nights) and the sites latitude and longitude in WGS84 is needed.

### Warning 1 : 
This script might not work for countries outside the Europe/Paris time zone (CEST in summer, CET in winter).

### Warning 2:  
**This script is a « function »**, to use it you have to download it and keep the R. file somewhere on your computer.  

In theory, you don’t even need to open it with R, however I strongly advise you to do so to read the first lines presenting what the function does and how to use it (in particular what the arguments of the function are and how your dataset should be structured). 

In your script, simply add the following command:  
`source(“pathToTheRFile”)`  
Then you can use the function!  

Here is an example of what your script should look like: 

`nightsSurveyed <- read.csv(“C:/Users/Name/Document/sampledNights.csv”)`  
`source("C:/Users/Name/Document/Script_sunrise_sunset.R")`  
`nightsSurveyedUpdated <- Calc_min_distance(nightsSurveyed,”Code_site”,pathToLayer)`
