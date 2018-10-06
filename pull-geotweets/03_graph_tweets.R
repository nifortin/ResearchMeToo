# Pull tweets from various datasets

source("config.R",echo=TRUE)


# Plot-----

metoo_tweets <- readRDS(tweets.rds)

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
ggsave(file.path(resultsdir,"daily-count-full.png"), width = 6, height = 4)

ggplot(metoo_bydate %>% filter(localDate >= as.IDate("2017-10-01"))) + geom_line(mapping = aes(x = localDate, y = N, colour = metoo, group = metoo)) +
  scale_y_continuous(name = "Daily count of geotagged tweets", label = comma) +
  scale_x_date(name = NULL, date_breaks = "1 month", date_labels =  "%b %Y") +
  scale_colour_discrete(name = NULL) +
  theme_tufte()
ggsave(file.path(resultsdir,"daily-count-after-oct2017.png"), width = 6, height = 4)

