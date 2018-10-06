# Get the SHP files from the Census Bureau

source("config.R",echo=TRUE)



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
