#' Define function to download, then subset the QWI data
#'
#' @param state upper or lower case string with two-letter (FIPS) state abbreviation
#' @param type the sub type (se_f_gm_n4_oslp etc)
#' @references
#' \url{http://lehd.ces.census.gov/data/schema/V4.0.4/}
#' @author Lars Vilhuber \email{lars.vilhuber@@cornell.edu}
download_qwi_old <- function (state,type) {

  qwifile <- paste("qwi",tolower(state),tolower(type),sep = "_")
  print(qwifile)
  # get the pieces of the type
  types <- strsplit(type,split="_")
  con <- gzcon(url(paste(urlbase,"/qwi.",qwivintage,"/",tolower(state),"/",types[[1]][1],"/",types[[1]][2],"/",qwifile,".csv.gz", sep="")))
  txt <- readLines(con)
  dat <- read.csv(textConnection(txt))
  return(dat)
}
