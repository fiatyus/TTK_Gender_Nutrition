
here::i_am("07_Afia/graph1_boxplot.R")

# full cleaned data set
data <- read_csv(here::here("Output/transform_data_AT.csv"))

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

data_filtered$interventions <- as.factor(data_filtered$interventions)

table(data_filtered$KFP)



# exporting new data set

write_csv(data_filtered, file = here::here("Output/data_filtered_AT.csv"))

