
here::i_am("07_Afia/graphs_exploration.R")

data_filtered <- read_csv(here::here("07_Afia/data_filtered_AT.csv"))

library(ggplot2)

# Model v4
model_v4 <- lm(KFP_sum ~ Gendered_HH_Type + Age + Sex + program +
                 Female_15_29 + Female_30 + Men_15_29 + Men_30 + Participate_WASH +
                 Participate_CareGroup + Participate_CashTransfer + Participate_Disaster + 
                 Participate_VillageSavings + Participate_SAADialoguesGender +
                 Participate_Natural + Participate_Disaster,
               data = data_filtered_2)

tbl_regression(model_v4,
               show_single_row = c(Participate_WASH,Participate_CareGroup,Participate_CashTransfer,
                                   Participate_Disaster,Participate_VillageSavings,
                                   Participate_SAADialoguesGender,Participate_Natural,Participate_Disaster)) |>
  add_global_p()

summary(model_v4)

# looking for multicollinearity
vif_values <- car::vif(model_v4)
print(vif_values)


data_filtered %>% select(.,starts_with("Participate")) %>% sapply(table)

data_filtered_2 <- data_filtered %>%
  mutate(across(starts_with("Participate"), as.factor))

