##### Extract and save #metoo and related tweets
source("config.R",echo=TRUE)

# Extract tweets from larger set of tweets on Patrick's server ----
sys <- Sys.info()
if (sys["nodename"] == "minmax" & sys["user"] == "pbaylis") {
	if (file.exists(filepre2017.rds)) {
		print(paste("File",filepre2017.rds,"already there. Delete if you want to redownload",sep=" "))
	} else {
	# Pull tweets for the USA for a limited time frame
	cbsas <- st_read("data/tl_2010_us_cbsa10/tl_2010_us_cbsa10.shp")[, "GEOID10"]

	# Tarano and Murphy (2017) and Manikonda et. al. (2017) use just #metoo (with case variations)
	# I add #timesup as well

	# Pulling for before and after separately since after kept breaking. Could combine, but no need.
	metoo_tweets_before2017 <- pull_tweets_usa(dates = seq(as.IDate("2006-01-01"), as.IDate("2017-01-01"), 1),
	                                words = c("#metoo", "#timesup"),
	                                poly = cbsas)

	saveRDS(metoo_tweets_before2017, filepre2017.rds)
	}

	if (file.exists(filepost2017.rds)) {
		print(paste("File",filepost2017.rds,"already there. Delete if you want to redownload",sep=" "))
	} else {
	cbsas <- st_read(file.path(shpdir, shpfile))[, "GEOID10"]

	metoo_tweets_after2017 <- pull_tweets_usa(dates = seq(as.IDate("2017-01-01"), as.IDate(Sys.Date()), 1),
	                                words = c("#metoo", "#timesup"),
	                                poly = cbsas)

	saveRDS(metoo_tweets_after2017, filepost2017.rds)
	}
} else {
  warning("Tweet extraction skipped; can only be run from Patrick Baylis' server.")
}

# Combine tweets from before and after 2017 -----
if (file.exists(tweets.rds)) {
	print(paste("File",tweets.rds,"already there. Delete if you want to redownload",sep=" "))
} else {
  metoo_tweets <- rbind(metoo_tweets_before2017, metoo_tweets_after2017)
  metoo_tweets <- metoo_tweets %>% mutate(metoo = as.numeric(grepl("#metoo", tolower(tweet)))) %>%
    mutate(metoo = factor(metoo, levels = c(0, 1), labels = c("#timesup", "#metoo")))
  saveRDS(metoo_tweets, tweets.rds)
}

if (file.exists(tweets.csv)) {
	print(paste("File",tweets.csv,"already there. Delete if you want to redownload",sep=" "))
} else {
  metoo_tweets <- readRDS(tweets.rds)
  write_csv(metoo_tweets, tweets.csv)
}

