# Pull tweets from various datasets

library(data.table)
library(dplyr)
library(sf)
library(ggplot2)
library(ggthemes)
library(tweetdata) # Patrick Baylis' package for extracting tweets on server.

# Pull tweets for the USA for a limited time frame
cbsas <- st_read("data/tl_2010_us_cbsa10/tl_2010_us_cbsa10.shp")[, "GEOID10"]
metoo_tweets <- pull_tweets_usa(dates = as.IDate(c("2015-01-01", "2018-01-01")),
                                words = "#metoo",
                                poly = cbsas,
                                n_max = 100000)


# Tarano and Murphy (2017) and Manikonda et. al. (2017) use just #metoo (with case variations)
# I add #timesup as well

# Pulling for before and after separately since after kept breaking. Could combine, but no need.

metoo_tweets_before2017 <- pull_tweets_usa(dates = seq(as.IDate("2006-01-01"), as.IDate("2017-01-01"), 1),
                                words = c("#metoo", "#timesup"), 
                                poly = cbsas)

saveRDS(metoo_tweets_before2017, "data/metoo_tweets_before2017.Rds")

metoo_tweets_after2017 <- pull_tweets_usa(dates = seq(as.IDate("2017-01-01"), as.IDate(Sys.Date()), 1),
                                words = c("#metoo", "#timesup"), 
                                poly = cbsas)

saveRDS(metoo_tweets_after2017, "data/metoo_tweets_after2017.Rds")


# Plot-----

metoo_tweets_before2017 <- readRDS("data/metoo_tweets_before2017.Rds")
metoo_tweets_after2017 <- readRDS("data/metoo_tweets_after2017.Rds")

metoo_tweets <- rbind(metoo_tweets_before2017, metoo_tweets_after2017)
metoo_tweets <- metoo_tweets %>% mutate(metoo = as.numeric(grepl("#metoo", tolower(tweet)))) %>% 
  mutate(metoo = factor(metoo, levels = c(0, 1), labels = c("#timesup", "#metoo")))

metoo_bydate <- metoo_tweets %>% group_by(localDate, metoo) %>% summarise(N = n())

metoo_bydate <- merge(metoo_bydate, 
                      expand.grid(localDate = seq(min(metoo_tweets$localDate, na.rm = T), 
                                                  max(metoo_tweets$localDate, na.rm = T), 1),
                                  metoo = c("#metoo", "#timesup")),
      by = c("localDate", "metoo"), all.y = T)

ggplot(metoo_bydate) + geom_line(mapping = aes(x = localDate, y = N, colour = metoo, group = metoo)) +
  scale_y_continuous(name = "Daily count of geotagged tweets", label = comma) +
  labs(x = NULL) + 
  scale_colour_discrete(name = NULL) + 
  theme_tufte()
ggsave("results/daily-count-full.png", width = 6, height = 4)

ggplot(metoo_bydate %>% filter(localDate >= as.IDate("2017-10-01"))) + geom_line(mapping = aes(x = localDate, y = N, colour = metoo, group = metoo)) +
  scale_y_continuous(name = "Daily count of geotagged tweets", label = comma) +
  scale_x_date(name = NULL, date_breaks = "1 month", date_labels =  "%b %Y") +
  scale_colour_discrete(name = NULL) + 
  theme_tufte()
ggsave("results/daily-count-after-oct2017.png", width = 6, height = 4)

write_csv(metoo_tweets, "data/metoo_tweets.csv.gz")

       