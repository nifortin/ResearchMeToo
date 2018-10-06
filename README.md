# ResearchMeToo
Research on Impact of #MeToo Movement

## Software requirements
- R
- Rstudio
- Git
- Git-lfs (https://github.com/git-lfs/git-lfs#getting-started)

## Notes

### Git-lfs
Git-lfs is needed for tracking of data files. You need to do
```
git lfs install
```
the first time you clone the repository onto your machine.

### QWI
QWI files are quite substantial, if you re-run the data acquistion, it will take a while.

### Tweets
Tweet acquistion for this project depends on 
- R package `tweetdata`
- a custom server having collected tweets since 2014
Access to both is private. The subset of tweets is also private, as per Twitter ToU. The Tweet IDs are available for 're-hydration'.

