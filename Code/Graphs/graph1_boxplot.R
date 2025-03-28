
here::i_am("07_Afia/graph1_boxplot.R")

data_filtered <- read_csv(here::here("07_Afia/data_filtered_AT.csv"))


library(ggplot2)


feeding_HH <- ggplot(data = data_filtered, aes(x= Gendered_HH_Type, y = KFP_sum)) +
  geom_boxplot() +
  labs(x = "Gendered Houshold Type",
       y = "Total Feeding Practices Known",
       title = "Comparing Gendered Household Type and Feeding Practices Known",
       caption = "This graph includes those knowing zero (0) feeding practices")

feeding_HH


# what if we remove 0's

data_filtered %>% filter(KFP_sum != 0)

feeding_HH_2 <- ggplot(data = data_filtered %>% filter(KFP_sum != 0), aes(x= Gendered_HH_Type, y = KFP_sum)) +
  geom_boxplot() +
  labs(x = "Gendered Houshold Type",
       y = "Total Feeding Practices Known",
       title = "Gendered Household Type and Feeding Practices Known",
       subtitle = str_wrap("This graph excludes those knowing zero (0) feeding practices to provide a clearer picture of knowledge distribution"))

feeding_HH_2



# adding a facet wrap by country
feeding_HH_facet <- ggplot(data = data_filtered, aes(x= Gendered_HH_Type, y = KFP_sum)) +
  geom_boxplot() +
  facet_wrap(~program) +
  labs(x = "Gendered Houshold Type",
       y = "Total Feeding Practices Known",
       title = str_wrap("Comparing Gendered Household Type and Feeding Practices Known by Program")) +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 15))  # Adjust 'width' as needed


feeding_HH_facet


feeding_HH_2_facet <- ggplot(data = data_filtered %>% filter(KFP_sum != 0), aes(x= Gendered_HH_Type, y = KFP_sum)) +
  geom_boxplot() +
  facet_wrap(~program)+
  labs(x = "Gendered Houshold Type",
       y = "Total Feeding Practices Known",
       title = "Gendered Household Type and Feeding Practices Known",
       subtitle = str_wrap("This graph excludes those knowing zero (0) feeding practices to provide a clearer picture of knowledge distribution"))+
  scale_x_discrete(labels = function(x) str_wrap(x, width = 15))  # Adjust 'width' as needed


feeding_HH_2_facet
