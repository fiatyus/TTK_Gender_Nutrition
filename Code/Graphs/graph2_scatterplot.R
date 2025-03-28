
here::i_am("07_Afia/graph2_scatterplot.R")

data_filtered <- read_csv(here::here("07_Afia/data_filtered_AT.csv"))


library(ggplot2)


interventions_v_KFP <- ggplot(data = data_filtered, 
                              aes(x = interventions, y = KFP_sum, color = program))+
                            geom_point() +
                            geom_smooth(method="lm")
interventions_v_KFP


interventions_v_KFP <- data_filtered %>% group_by(interventions, KFP_sum) %>%
  mutate(count = n()) %>%
  ggplot(aes(x = interventions, y = KFP_sum, color = program, size = count)) +
  geom_point() +
  geom_smooth(method = "lm", se=FALSE)+
  labs(x = "Interventions Participated In",
       y = "Feeding Practices Known",
       title = "Intervention Participation and Feeding Practice Knowledge")


# what if we exclude 0's

interventions_v_KFP_2 <- ggplot(data = data_filtered %>% filter(KFP_sum != 0), 
                              aes(x = interventions, y = KFP_sum, color = program))+
  geom_point() +
  geom_smooth(method="lm")
interventions_v_KFP_2




# testing chat gpt answer


library(dplyr)
library(ggplot2)

interventions_v_KFP_2 <- data_filtered %>%
  filter(KFP_sum != 0) %>%
  group_by(interventions, KFP_sum) %>%
  mutate(count = n()) %>%
  ggplot(aes(x = interventions, y = KFP_sum, color = program, size = count)) +
  geom_point() +
  geom_smooth(method = "lm")

# Print the plot
print(interventions_v_KFP_2)

