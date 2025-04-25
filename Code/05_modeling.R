library(pacman)
p_load(tidyverse, dplyr, here, ggplot2, table1,
       haven, multcomp, nnet, MASS, brant, VGAM, gtsummary)


here::i_am("Code/05_modeling.R")

data_filtered <- readRDS(here::here("Data/final_data.rds"))

# formula is roughly --> KFP ~ Gendered_HH_Type + Age + interventions + program


# fitting the logistic regression model
model_vNew <- glm(KFP ~ Gendered_HH_Type + Age + interventions + program,
                  family= "binomial" (link = 'logit'),
                  data = data_filtered)
# had to remove Sex because it was a perfect predictor
tbl_regression(model_vNew) |>
  add_global_p()

crude <- glm(KFP ~ Gendered_HH_Type,
             family= "binomial" (link = 'logit'),
             data = data_filtered)
tbl_regression(crude) |>
  add_global_p()




# finding the 95% confidence intervals
contrasts_int_crude <- glht(crude, linfct = K_int)

cbind(exp(coef(contrasts_int_crude)), exp(confint.default(contrasts_int)))



coef(model_vNew)



# interactions

# fitting the logistic regression model
model_interact <- glm(KFP ~ Gendered_HH_Type + Age + interventions + program +
                        Gendered_HH_Type*program + Gendered_HH_Type*interventions,
                  family= "binomial" (link = 'logit'),
                  data = data_filtered)

# had to remove Sex because it was a perfect predictor
tbl_regression(model_interact) |>
  add_global_p()



