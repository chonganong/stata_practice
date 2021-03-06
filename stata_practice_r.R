rm(list=ls())
install.packages('reader')
install.packages('dplyr')
library(reader)
library(dplyr)
library(stargazer)
setwd("~/GitHub/stata_practice/data")

clean <- lapply(list.files(,pattern="*.csv"), read.csv) %>%              # reads a list of .csv files into a list of data-frames
  bind_rows %>%                                                # appends them into a single data-frame
  select(Competition_Month, Competition_Year, 
         Home_City, Home_Section, Home_State, Points, Rank)    # drops unwanted variables

setwd("~/stata-practice-test-chongan")

clean <- clean %>% mutate(Home_State = replace(Home_State, Home_City=="Guam","GU"))
clean <- clean %>% mutate(Home_State = replace(Home_State, Home_State=="Fl","FL"))
clean <- clean %>% mutate(Home_State = replace(Home_State, nchar(Home_State)!=2, "Foreign"))
clean <- clean %>% mutate(Home_State = replace(Home_State, Home_State== "AB" | Home_State== "BC" |
                                                 Home_State== "CZ" | Home_State== "ON" |
                                                 Home_State== "PQ" | Home_State== "QC" |
                                                 Home_State== "ZH", "Foreign" ))
clean <- clean %>% mutate(Home_State = replace(Home_State, Home_State== "AS" | Home_State== "GU" |
                                                 Home_State== "MP" | Home_State== "PR" |
                                                 Home_State== "UM" | Home_State== "VI", "Territory"))
clean$Home_State <- factor(clean$Home_State)                          
clean <- clean %>% mutate(Hill_Indicator = 0)
clean <- clean %>% mutate(Hill_Indicator = replace(Hill_Indicator, 
                                                   grepl("Hill", Home_City, ignore.case=F), 
                                                   1))
clean <- clean %>%
  group_by(Home_State) %>%
  mutate(Home_State_Mean = mean(Points))
clean$Home_Section <- factor(clean$Home_Section)
clean <- clean %>%
  group_by(Home_Section, Competition_Year) %>%
  mutate(Home_Section_Count = n())

t.test(Points~Hill_Indicator, clean)
stargazer(summary(clean$Home_State), flip=T, type = "text")
reg1<-lm(Rank~Points, data=clean)
reg2<-lm(Rank~Points+Home_State, data=clean)
reg3<-lm(Rank~Points+Home_State+as.factor(Competition_Year), data=clean)
stargazer(reg1,reg2,reg3, type="text")
