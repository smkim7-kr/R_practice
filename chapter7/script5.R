###07-1
#Missing Value
df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5, 4, 3, 4, NA))
df

#is.na()
is.na(df)
table(is.na(df))
table(is.na(df$sex))
table(is.na(df$score))

mean(df$score)
sum(df$score)

library(dplyr)
df %>% filter(is.na(score))
df %>% filter(!is.na(score))

df_nomiss <- df %>% filter(!is.na(score))
mean(df_nomiss$score)
sum(df_nomiss$score)
df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))
df_nomiss

#na.omit()
df_nomiss2 <- na.omit(df)
df_nomiss2

#na.rm parameter
mean(df$score, na.rm = T)
sum(df$score, na.rm = T)

exam <- read.csv("csv_exam.csv")
exam[c(3, 8, 15), "math"] <-  #[row, column]
exam
#summarise()
exam %>% summarise(mean_math = mean(math))
exam %>% summarise(mean_math = mean(math, na.rm = T))
exam %>% summarise(mean_math = mean(math, na.rm = T),
                   median_math = median(math, na.rm = T),
                   sum_math = sum(math, na.rm = T))
#Imputation
mean(exam$math, na.rm=T)
exam$math <- ifelse(is.na(exam$math), 55, exam$math) #impute to average value
table(is.na(exam$math))
exam
mean(exam$math)

mpg <- as.data.frame(ggplot2::mpg)
mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA
#Q1
table(is.na(mpg$drv))
table(is.na(mpg$hwy))
#Q2
mpg %>% 
  filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(meanhwy = mean(hwy))

###07-2
#Handling outlier
outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1),
                      score = c(5, 4, 3, 4, 2, 6))
outlier
table(outlier$sex)
table(outlier$score)
#converting outlier to missing value
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier

outlier %>% 
  filter(!is.na(sex) & !is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score = mean(score))

#boxplots
boxplot(mpg$hwy)
boxplot(mpg$hwy)$stats

mpg <- as.data.frame(ggplot2::mpg)
mpg$hwy <-ifelse(mpg$hwy <12 | mpg$hwy >37, NA, mpg$hwy)
table(is.na(mpg$hwy))

mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = T))

mpg <- as.data.frame(ggplot2::mpg)
mpg[c(10, 14, 58, 93), "drv"] <- "k"
mpg[c(29, 43, 129, 203), "cty"] <- c(3, 4, 39, 42)
#Q1
table(mpg$drv)
mpg$drv <- ifelse(mpg$drv == "k", NA, mpg$drv)
mpg %>% filter(drv %in% c("4", "f", "r"))
#Q2
boxplot(mpg$cty)$stat
mpg$cty <- ifelse(mpg$cty < 9 | mpg$cty > 26, NA, mpg$cty)
boxplot(mpg$cty)
#Q3
mpg %>% 
  filter(!is.na(mpg$drv) & !is.na(mpg$cty)) %>% 
  group_by(drv) %>% 
  summarise(mean_cty = mean(cty))
