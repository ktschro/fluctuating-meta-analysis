##to install metagear:
# install.packages("BiocManager");
# BiocManager::install("EBImage"))

## the search
#current search: (((daily temperature range) OR (fluctuat* AND temperature) OR (diurnal temperature range)) AND experiment*) NOT human
#excluded a bunch of engineering fields (screenshot of included fields in github folder)
#query link: https://www.webofscience.com/wos/woscc/summary/9daf3f02-249f-43a9-84d0-341597d64eab-5ef478b7/relevance/1

library(metagear) # for GUI and effort distribute and abstract screener
library(tidyverse) # for compiling csvs
library(data.table) # for something?
library(here) # for path management

jensens_metalist <- list.files(here("the papers")) %>%
  lapply(read_csv) %>%
  rbind()

jensens_meta <- as.data.frame(do.call(rbind,jensens_metalist))

effort_distribute(jensens_meta, initialize = TRUE, reviewers = "katie", save_split = TRUE)
#to split between multiple screeners: reviewers = c("name 1","name 2"). Can use effort to specify weighting of each
#link to basic vignette to go through these: http://lajeunesse.myweb.usf.edu/metagear/metagear_basic_vignette.html

abstract_screener("effort_katie1.csv",
                  aReviewer = "katie",
                  theButtons = c("YES","maybe","NO","analyze"),
                  keyBindingToButtons = c("y","m","n","r"))
