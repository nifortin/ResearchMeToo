# Setup. Only needs to be run ONCE

source("config.R",echo=TRUE)

if (file.exists(datadir)){
} else {
  dir.create(file.path(datadir))
}

if (file.exists(resultsdir)){
} else {
  dir.create(file.path(resultsdir))
}