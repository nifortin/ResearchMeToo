# Config for replication
# Will install and configure R
#
# from https://www.r-bloggers.com/loading-andor-installing-packages-programmatically/
is_installed <- function(mypkg) is.element(mypkg, installed.packages()[,1])
load_or_install<-function(package_names)
{
  for(package_name in package_names)
  {
    if(!is_installed(package_name))
    {
      install.packages(package_name,repos="http://lib.stat.cmu.edu/R/CRAN")
    }
    library(package_name,character.only=TRUE,quietly=TRUE,verbose=FALSE)
  }
}

# calling our two functions:
sys <- Sys.info()
if ( sys["nodename"] == "minmax" & sys["user"] == "pbaylis") {
packages=c("data.table","dplyr","sf","ggplot2","ggthemes", "raster", "velox", "readr", "stringr", "zoo", "scales","tweetdata")
} else {
packages=c("data.table","dplyr","ggplot2","ggthemes","scales","zoo")
}

load_or_install(packages)

resultsdir <- "./results"
datadir <- "./data"

# Shapefiles
# Where the shp file will go
shpdir <- file.path(datadir,"tl_2010_us_cbsa10")
if (file.exists(shpdir)){
} else {
	  dir.create(file.path(shpdir))
}

# name of the shpfile
shpfile <- "tl_2010_us_cbsa10.shp"

# Where we get the SHP file
shpsrc <- "https://www2.census.gov/geo/tiger/TIGER2010/CBSA/2010"
shpzipfile <- "tl_2010_us_cbsa10.zip"

# names of the tweet files
filepre2017.rds <- file.path(datadir,"metoo_tweets_before2017.Rds")
filepost2017.rds <- file.path(datadir,"metoo_tweets_after2017.Rds")
tweets.rds <- file.path(datadir,"metoo_tweets.Rds")
tweets.csv <- file.path(datadir,"metoo_tweets.csv.gz")
