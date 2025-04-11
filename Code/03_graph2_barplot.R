

# Calculate counts per Gendered_HH_Type and KFP
data_with_count <- data_filtered %>%
  count(Gendered_HH_Type, KFP) %>%
  mutate(text = paste("GSoH:", Gendered_HH_Type, "<br>Feeding Practices Known:", KFP, "<br>Count:", n))


KFP_v_GSoH <- ggplot(data = data_with_count, aes(x= Gendered_HH_Type, y=n, fill = KFP)) +
  geom_bar(stat = "identity", position = "fill")+
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20))+
  labs(x = "Gendered Structure of the Household",
       y = "Percentage of Participants",
       title = "Feeding Practice Knowledge by Gendered Structure \nof the Household",
       fill = "Feeding Practice's Known")+
  scale_fill_manual(values = c('#0F2C88', '#F3BB4A'))+
  theme_minimal()+
  theme(legend.position="bottom")
  

KFP_v_GSoH

data_with_count_facet <- data_filtered %>%
  count(Gendered_HH_Type, KFP, program)


KFP_v_GSoH_facet <- ggplot(data = data_with_count_facet, aes(x= Gendered_HH_Type, y=n, fill = KFP)) +
  geom_bar(stat = "identity", position = "fill")+
  facet_wrap(~program)+
  scale_x_discrete(labels = function(x) str_wrap(x, width = 10))+
  labs(x = "Gendered Structure of the Household",
       y = "Percentage of Participants",
       title = "Feeding Practice Knowledge by Gendered Structure \nof the Household and Program",
       fill = "Feeding Practice's Known")+
  scale_fill_manual(values = c('#0F2C88', '#F3BB4A'))+
  theme_minimal()+
  theme(legend.position="bottom")


KFP_v_GSoH_facet




