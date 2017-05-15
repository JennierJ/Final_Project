install.packages("tidyverse")
install.packages("dplyr")
install.packages("ggplot2")

library(tidyverse)
library(dplyr)
library(ggplot2)

# The data source is from the World Bank. Data science workflow applied in this project is DSEMN. Obtain, scrub, explore, model and interpret. 

# Obtain the data from world bank and upload the data into github. Then load the data into R.

data <- read.csv(url("https://raw.githubusercontent.com/JennierJ/Final_Project/master/Total%20greenhouse%20gas%20emissions.csv"))

#head(data)
#View(data)

# Scrub and explore the data

nrow(data)
ncol(data)

# Delete the NA column and change the column name

data$ï..Series.Name <- NULL
data$Series.Code <- NULL
data$Country.Code <- NULL
data$X2013..YR2013. <- NULL
data$X2014..YR2014. <- NULL
data$X2015..YR2015. <- NULL
data$X2016..YR2016. <- NULL

colnames(data) <- c("Country", "1990", "2000", "2007", "2008", "2009", "2010", "2011", "2012")

# Data Transformation: Tidy the data

data <- data %>%
  gather(key = "year", value = "Emission", -Country)

data <- subset(data, data$Emission != "..")
data <- subset(data, data$Emission != "")

#class(data$Emission)
#colnames(data)

is.numeric(data$Emission)
class(data$Emission)
data$Emission <- as.numeric(data$Emission)

#dim(data)
#head(data)

data$Country <- NULL
table <- summarise(group_by(data, year), mean = mean(Emission), sd = sd(Emission))
table

# From the table, we can clearly see that these is a trend of increasing total emission of greenhouse gas with the year.

# Modeling and Interpret

ggplot(table, aes(year, mean, group = 1, col="red")) + 
  geom_point() + 
  geom_line() +
  labs(x = "Year", y = "Total Greenhouse Gas Emission", title = "Total Greenhouse Gas Emission vs. Year")

# Conclusion: Greenhouse gases from human activities are the most significant driver of observed climate change since the mid-20th century. According to
# the graph, the total emission of greenhouse gas is increasing as the year.


# Reference: The website address is http://databank.worldbank.org/data/reports.aspx?source=2&Topic=6#.
