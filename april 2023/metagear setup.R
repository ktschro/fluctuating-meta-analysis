## the search
#((thermal fluct*) OR (temperature fluct*)) AND (growth rate) AND (ectotherm OR insect OR algae OR plant OR zooplankt* OR phytoplankt* OR bacteri* OR fung*)
# link: https://www.webofscience.com/wos/woscc/summary/c0e3427a-6729-4765-b22e-cade8427385c-83c3561b/relevance/1

#another option: ((thermal fluct*) OR (temperature fluct*)) AND (growth rate OR develop* rate) AND (ectotherm OR insect OR mosquito* OR algae OR plant OR zooplankt* OR phytoplankt* OR bacteri* OR fung*)
#gets you to 1820+
# link: https://www.webofscience.com/wos/woscc/summary/3f7a503f-dab6-4c64-93aa-fecc5b82a5d9-85d34eff/relevance/1 

library(metagear) # for GUI and effort distribute and abstract screener
library(tidyverse) # for compiling csvs

reading_list <- read.csv("fluctuating_temp_growth_rate_papers.csv")
reading_list <- reading_list %>% rename("ABSTRACT" = "Abstract",
                                        "TITLE" = "Article.Title")

effort_distribute(reading_list, initialize = TRUE, reviewers = "katie", save_split = TRUE)
#to split between multiple screeners: reviewers = c("name 1","name 2"). Can use effort to specify weighting of each
#link to basic vignette to go through these: http://lajeunesse.myweb.usf.edu/metagear/metagear_basic_vignette.html

#future init:

abstract_screener("effort_katie3.csv",
                  aReviewer = "katie",
                  theButtons = c("YES","maybe","NO","analyze","read"),
                  keyBindingToButtons = c("y","m","n","t","r"))
