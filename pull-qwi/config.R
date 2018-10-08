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
packages=c("rmarkdown","knitr","ggplot2","dplyr","tictoc")
load_or_install(packages)

resultsdir <- "./results"
datadir <- "../data/qwi"

# QWI specific parameters
urlbase <- "http://lehd.ces.census.gov/data/qwi"
# this could also be "latest_release"
# qwivintage <- "R2015Q3"
qwistates <- "AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY"
qwistates <- unlist(strsplit(qwistates," "))
# this could be deduced from metadata, here we hard-code it
qwivintage <- "latest_release"

# This is not the year we download, this is the year we capture the data for (time series)
qwiyear    <- 2016
qwiquarter <- 1

