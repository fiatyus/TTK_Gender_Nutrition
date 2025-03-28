
here::i_am("07_Afia/Modeling.R")

data_filtered <- read_csv(here::here("07_Afia/data_filtered_AT.csv"))

# formula is roughly --> KFP ~ Gendered_HH_Type + Age + interventions + program

class(data_filtered$Gendered_HH_Type)

data_filtered$Gendered_HH_Type <-  as.factor(data_filtered$Gendered_HH_Type)
data_filtered$program <-  as.factor(data_filtered$program)
data_filtered$Sex <-  as.factor(data_filtered$Sex)
data_filtered$interventions <- as.numeric(data_filtered$interventions)
data_filtered$KFP <- as.numeric(data_filtered$KFP)

class(data_filtered$Sex)

data_filtered <- data_filtered %>% mutate(
  Sex_2 = case_when(Sex == "Female" ~ 0,
                  Sex == "Male" ~ 1)
)

data_filtered <- data_filtered %>% mutate(
  Gendered_HH_Type_2 = case_when(Gendered_HH_Type == "Adult Female no Adult Male (FnM)" ~ 0,
                                 Gendered_HH_Type == "Adult Male and Adult Female (M&F)" ~ 1)
)

data_filtered <- data_filtered %>% mutate(
    program_2 = case_when(program == "TAKUNDA" ~ 0,
                          program == "TITUKULANE" ~ 1)
)


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

K_int <- rbind(
  "Effect GSoH== M&F on knowledge" = c(1,1,0,0,0),
  "Effect GSoH== FnM on knowledge" = c(0,1,0,0,0),
  "Effect GSoH== M&F and Takunda on knowledge" = c(1,1,0,0,0),
  "Effect GSoH== M&F and Titukulane on knowledge" = c(1,1,0,0,1)
  )

library(pacman)
p_load(tidyverse, dplyr,
       haven, multcomp, nnet, MASS, brant, VGAM)

# finding the 95% confidence intervals
contrasts_int <- glht(model_vNew, linfct = K_int)

cbind(exp(coef(contrasts_int)), exp(confint.default(contrasts_int)))

summary(model_vNew)






table(data_filtered$KFP, data_filtered$Gendered_HH_Type)
table(data_filtered$KFP, data_filtered$Age)
table(data_filtered$KFP, data_filtered$interventions)
table(data_filtered$KFP, data_filtered$program)


# interactions

# fitting the logistic regression model
model_interact <- glm(KFP ~ Gendered_HH_Type + Age + interventions + program +
                        Gendered_HH_Type*program + Gendered_HH_Type*interventions,
                  family= "binomial" (link = 'logit'),
                  data = data_filtered)

# had to remove Sex because it was a perfect predictor
tbl_regression(model_interact) |>
  add_global_p()



