## the search
#current search: (fluctuat* temperature AND ectotherm) OR (jensen* inequality AND temperature)
#query link: https://www.webofscience.com/wos/woscc/summary/e6ee96db-8235-4fa3-aed7-9e4554192089-62b02355/relevance/1

#adding daily temperature range and ectotherm increases search results to 469. query link: https://www.webofscience.com/wos/woscc/summary/7795c949-7c90-42a6-aeaa-8a11298e69bb-62b03535/relevance/1
#insect AND fluctuat* temperature increases to 1465. query link: https://www.webofscience.com/wos/woscc/summary/c6a5247d-ce31-4c18-9dc2-b766a6b666d1-62f40afa/relevance/1
  # still doesn't include Carrington 2013 paper that I really think it should

library(metagear) # for GUI and effort distribute and abstract screener
library(tidyverse) # for compiling csvs
library(here) # for path management

reading_list <- read.csv("fluct_temp_ectotherm_OR_jensens_temp.csv")
reading_list <- reading_list %>% rename("ABSTRACT" = "Abstract",
                                        "TITLE" = "Article.Title")

effort_distribute(reading_list, initialize = TRUE, reviewers = "katie", save_split = TRUE)
#to split between multiple screeners: reviewers = c("name 1","name 2"). Can use effort to specify weighting of each
#link to basic vignette to go through these: http://lajeunesse.myweb.usf.edu/metagear/metagear_basic_vignette.html

abstract_screener("effort_katie.csv",
                  aReviewer = "katie",
                  theButtons = c("YES","maybe","NO","analyze","read"),
                  keyBindingToButtons = c("y","m","n","t","r"))
