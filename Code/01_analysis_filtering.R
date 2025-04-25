
library(here)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(table1)

here::i_am("Code/01_analysis_filtering.R")

# full cleaned data set
data <- readRDS(here::here("Data/transform_data_AT.rds"))



# changing the 0 to NA for feeding practices known

    # actually this is no longer needed
# data <- data %>%
#  mutate(`Feeding Practices Known` = case_when(
#    KFP_sum == 0 ~ NA_real_,  # Convert 0 to NA (use NA_real_ for numeric columns)
#    TRUE ~ KFP_sum            # Keep other values unchanged
#  ))

# lets treat KFP_sum as a categorical variable
#data$`Feeding Practices Known` <- as.factor(data$`Feeding Practices Known`)

# filtering the data to what I need for my research question
data_filtered <- data %>% filter(frame==1)

# analyzing household type
table(data_filtered$Gendered_HH_Type)
  # too few MnF and CNAF to include in analytics

# removing MnF and CNAF
data_filtered <- data_filtered %>% filter(Gendered_HH_Type!="Female Child no Adults (CNAF)") %>% 
  filter(Gendered_HH_Type!="Adult Male no Adult Female (MnF)")


data_filtered <- data_filtered %>% mutate(
  KFP = case_when(KFP_sum == 0 ~ 0,
                  KFP_sum > 0 ~ 1)
)

data_filtered$KFP <- as.factor(data_filtered$KFP)
data_filtered$KFP <- factor(data_filtered$KFP,
                            levels = c(0,1),
                            labels = c("Zero (0)", 
                                       "One or more (1+)")
)

table(data_filtered$KFP)

# changing labeling
label(data_filtered$interventions) <- "Interventions Participated In"
label(data_filtered$KFP_sum) <- "Feeding Practices Known"
label(data_filtered$KFP) <- "Feeding Practices Known (binary)"
label(data_filtered$Gendered_HH_Type) <- "Gendered Structure of the Household"

# exporting new data set

saveRDS(data_filtered, file = here::here("Data/final_data.rds"))
