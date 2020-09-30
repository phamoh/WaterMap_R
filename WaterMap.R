# ----------------------------------------------------------------------------------------------------------------------------- 
# Converting the python Watermap script into R
# R version 3.6.3 (2020-02-29) "Holding the Windsock"
# Author: Olivia Pham
# ---------------------------------------------------------------------------------------------------------------------------- 
# Code purpose:
# Convert an script writting in python that was used to filter rows for based on the values and the date
# About:
# Dataset pulled: 2017
# More information and latest data can be pulled from:
# https://www.waterboards.ca.gov/drinking_water/certlic/drinkingwater/leadsamplinginschools.html
# ---------------------------------------------------------------------------------------------------------------------------- 

# Libraries ------------------------------------------------------------------------------------------------------------------
library(tidyverse)  # tidyverse_1.3.0
library(lubridate)  # lubridate_1.7.8

# Load data ------------------------------------------------------------------------------------------------------------------
lead_filename <- "lead.csv"
lead_data <- read.csv(lead_filename, stringsAsFactors = FALSE, na.strings=c(""," ","NA"))

# Filter data ----------------------------------------------------------------------------------------------------------------
names(lead_data)

lead_filtered <- lead_data %>%
  mutate(SAMPLE_DATE = lubridate::dmy(lead_data$SAMPLE_DATE)) %>%
  group_by(SchoolName) %>%
  filter(SAMPLE_DATE == max(SAMPLE_DATE)) %>%
  filter(RESULT == max(RESULT))  %>%
  slice(n()) %>%
  ungroup()

# Export data ----------------------------------------------------------------------------------------------------------------

write.table(lead_filtered, "lead_filtered_Rconverted.csv", row.names=FALSE, quote = FALSE, sep = ",")

  
