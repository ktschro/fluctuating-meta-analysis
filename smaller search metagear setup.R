## the search
#current search: (fluctuat* temperature AND ectotherm) OR (jensen* inequality AND temperature)
#query link: https://www.webofscience.com/wos/woscc/summary/e6ee96db-8235-4fa3-aed7-9e4554192089-62b02355/relevance/1

#adding daily temperature range and ectotherm increases search results to 469. query link: https://www.webofscience.com/wos/woscc/summary/7795c949-7c90-42a6-aeaa-8a11298e69bb-62b03535/relevance/1

library(metagear) # for GUI and effort distribute and abstract screener
library(tidyverse) # for compiling csvs
library(here) # for path management

jensens_metalist <- list.files(path = "/Users/katieschroeder/Documents/GitHub/fluctuating meta analysis/the papers", full.names = TRUE) %>%
  lapply(read.csv) %>%
  rbind()

jensens_meta <- as.data.frame(do.call(rbind,jensens_metalist))
jensens_meta <- jensens_meta %>% rename("ABSTRACT" = "Abstract",
                                        "TITLE" = "Article.Title")

effort_distribute(jensens_meta, initialize = TRUE, reviewers = "katie", save_split = TRUE)
#to split between multiple screeners: reviewers = c("name 1","name 2"). Can use effort to specify weighting of each
#link to basic vignette to go through these: http://lajeunesse.myweb.usf.edu/metagear/metagear_basic_vignette.html

abstract_screener("effort_katie1.csv",
                  aReviewer = "katie",
                  theButtons = c("YES","maybe","NO","analyze","read later"),
                  keyBindingToButtons = c("y","m","n","v","r"))