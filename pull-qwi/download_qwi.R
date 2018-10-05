#' Define function to download, then subset the QWI data
#'
#' @param state upper or lower case string with two-letter (FIPS) state abbreviation
#' @param qyear an integer or vector of years to choose
#' @param qquarter an intenger or vector of quarters to choose
#' @return a dataframe with the selected state's data, as subset
#' @note You need to hard-code the selection criteria at this time
#' @references
#' \url{http://lehd.ces.census.gov/data/schema/V4.0.4/}
#' @author Lars Vilhuber \email{lars.vilhuber@@cornell.edu}
download_qwi <- function (state,qyear=NA,qquarter=NA) {
  
  qwifile <- paste("qwi",tolower(state),"sa_f_gs_ns_oslp_u",sep = "_")
  con <- gzcon(url(paste(urlbase,"/",tolower(state),"/",qwivintage,"/DVD-sa_f/",qwifile,".csv.gz", sep="")))
  txt <- readLines(con)
  dat <- read.csv(textConnection(txt))
  # we only want the a specific set of values
  dat <- subset(dat,geo_level=="S" & 
                  ownercode=="A00" & 
                  sex=="0" & 
                  agegrp =="A00" & 
                  race =="A0" & 
                  ethnicity =="A0" & 
                  education == "E0" & 
                  firmage=="0" & 
                  firmsize=="0" #&
                  #year == qyear & 
                  #quarter == qquarter 
                )
  if ( ! is.na(qyear) ) {
    dat <- subset(dat,year %in% qyear )
  }
  if ( ! is.na(qquarter) ) {
    dat <- subset(dat,quarter %in% qquarter )
  }
  
  # we ignore the flags for now
  dat <- dat[,names(dat)[-grep("^s[A-Z]",names(dat))]]
  # Add state name
  #dat$state <- paste(tolower(state))
  
  return(dat)
}
