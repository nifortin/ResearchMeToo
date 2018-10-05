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
packages=c("data.table","dplyr","sf","ggplot2","ggthemes")
load_or_install(packages)