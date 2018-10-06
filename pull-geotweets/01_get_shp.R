# Get the SHP files from the Census Bureau

source("config.R",echo=TRUE)

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

# If it's there, we do nothing, otherwise we download it.
if (file.exists(file.path(shpdir,shpfile))){
	print(paste("File",file.path(shpdir,shpfile),"already there. Delete if you want to redownload",sep=" "))
} else {
	if ( file.exists(file.path(datadir,shpzipfile))) {
	} else {
          download.file(paste(shpsrc,shpzipfile,sep="/"),file.path(datadir,shpzipfile))
	}
	unzip(file.path(datadir,shpzipfile),exdir=shpdir)
	print(paste("You may want to remove",file.path(datadir,shpzipfile),sep=" "))
}
	

	
