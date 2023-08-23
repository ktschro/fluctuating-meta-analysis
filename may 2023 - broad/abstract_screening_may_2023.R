setwd("/Users/katieschroeder/Documents/GitHub/fluctuating-meta-analysis/may 2023 - broad")

#broadest query option: https://www.webofscience.com/wos/woscc/summary/47bed85c-4d2b-4523-ab6a-2089c2193aa6-8b250fbd/relevance/1 

#10,000 plus results

#refine by some journals - https://www.webofscience.com/wos/woscc/summary/a90c17bb-387d-4575-b2ee-f2e8d92f241a-8b254d09/relevance/1

#6786 results

#((thermal fluct*) OR (temperature fluct*) OR (variable temperature) OR (varying temperature) OR (variable thermal)) AND (growth rate OR develop* rate) AND (ectotherm OR insect OR mosquito* OR algae OR plant OR zooplankt* OR phytoplankt* OR bacteri* OR fung*)

library(metagear) # for GUI and effort distribute and abstract screener
library(tidyverse) # for compiling csvs

##do once: combine all csvs from web of science search 
library(readxl)
files <- list.files(pattern = '\\.xls')
tables <- lapply(files,read_excel)
all_refs <- do.call(rbind,tables)
write.csv(all_refs,"broad_search_combined_refs.csv")

#do once: initialize reading list
reading_list <- read.csv("broad_search_combined_refs.csv")
reading_list <- reading_list %>% rename("ABSTRACT" = "Abstract",
                                        "TITLE" = "Article.Title")

effort_distribute(reading_list, initialize = TRUE, reviewers = "katie", save_split = TRUE)
#to split between multiple screeners: reviewers = c("name 1","name 2"). Can use effort to specify weighting of each

#link to basic vignette to go through these: http://lajeunesse.myweb.usf.edu/metagear/metagear_basic_vignette.html

#do every time:
abstract_screener("effort_katie.csv",
                  aReviewer = "katie",
                  theButtons = c("YES","maybe","NO","analyze","read"),
                  keyBindingToButtons = c("y","m","n","t","r"),
                  highlightColor = "powderblue",
                  highlightKeywords = c("fluctuate","fluctuating","fluctuation","temperature","constant","vary","variable","varying"),
                  fontSize=11,
                  windowHeight = 18,
                  windowWidth = 100)

#-------------------------------------------------------- ----------- ---------------- ####### 
###Try to extract figures####
#subset to just the yeses
library(tidyverse)
library(metagear)
effort<-read.csv("may 2023 - broad/effort_katie.csv")
table(effort$INCLUDE) #177 yes
yeses <- read.csv("potential_8_17_2023.csv")

collectionOutcomes <- PDFs_collect(yeses,DOIcolumn="DOI.Link",FileNamecolumn = "STUDY_ID",quiet=TRUE)
table(collectionOutcomes$downloadOutcomes)

collectionOutcomes <- PDFs_collect(theRefs,DOIcolumn="DOI",FileNamecolumn = "STUDY_ID",quiet=TRUE)

#--------- get list of DOIS ------------
effort<-read.csv("effort_katie.csv")
potential<- effort %>% filter(INCLUDE=="YES"|INCLUDE=="maybe"|INCLUDE=="read") 
potential %<>% select(STUDY_ID,INCLUDE,Authors,TITLE,DOI,DOI.Link)
write.csv(potential,"potential_8_17_2023.csv")
