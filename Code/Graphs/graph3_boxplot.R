


interventions_v_KFP_new <- ggplot(data = data_filtered, 
                                  aes(x = KFP, y = interventions, fill = program)) +
  geom_boxplot()+
  scale_fill_manual(values = c('#0F2C88', '#D57636', '#F3BB4A'))





# colors = #0F2C88, #D57636, #F3BB4A


interventions_v_KFP_new <- ggplot(data = data_filtered, 
                                  aes(x = KFP, y = interventions, fill = program)) +
  geom_boxplot() +
  scale_fill_manual(values = c('#D57636', '#F3BB4A'))+
  labs(title = "Feeding Practices Known and Intervention Participation",
       x = "Feeding Practices Known",
       y = "Interventions")

interventions_v_KFP_new
