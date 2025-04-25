
here::i_am("Code/02_graph1_boxplot.R")

data_filtered <- readRDS(here::here("Data/final_data.rds"))

library(ggplot2)
library(dplyr)
library(stringr)

# Calculate counts per Gendered_HH_Type and KFP
data_with_count <- data_filtered %>%
  count(Gendered_HH_Type, KFP) %>%
  mutate(text = paste("GSoH:", Gendered_HH_Type, "<br>Feeding Practices Known:", KFP, "<br>Count:", n))


KFP_v_GSoH <- ggplot(data = data_with_count, aes(x= Gendered_HH_Type, y=n, fill = KFP)) +
  geom_bar(stat = "identity", position = "fill")+
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20))+
  labs(x = "Gendered Structure of the Household",
       y = "Percentage of Participants",
       title = "Feeding Practice Knowledge by Gendered \nStructure of the Household",
       fill = "Feeding Practice's Known")+
  scale_fill_manual(values = c('#0F2C88', '#F3BB4A'))+
  theme_minimal()+
  theme(legend.position="bottom")
  

KFP_v_GSoH

data_with_count_facet <- data_filtered %>%
  count(Gendered_HH_Type, KFP, program)

data_with_count_facet <- data_with_count_facet %>% mutate(GSoH = 
  case_when(Gendered_HH_Type == "Adult Female no Adult Male (FnM)" ~ "FnM",
            Gendered_HH_Type == "Adult Male and Adult Female (M&F)" ~ "M&F")
)


KFP_v_GSoH_facet <- ggplot(data = data_with_count_facet, aes(x= GSoH, y=n, fill = KFP)) +
  geom_bar(stat = "identity", position = "fill")+
  facet_wrap(~program)+
  scale_x_discrete(labels = function(x) str_wrap(x, width = 15))+
  labs(x = "Gendered Structure of the Household",
       y = "Proportion of Participants",
       title = "Feeding Practice Knowledge by Gendered Structure \nof the Household and Program",
       fill = "Feeding Practice's Known")+
  scale_fill_manual(values = c('#5C2163', '#F67601'))+
  theme(legend.position="bottom",
        plot.background = element_rect(fill = "#FFF8ED", color = NA),  
        panel.background = element_rect(fill = "#FFF8ED", color = NA),
        legend.background = element_rect(fill = "#FFF8ED", color = NA),
        strip.background = element_rect(fill = "#BF7BB5", color = NA),
        strip.text = element_text(color = "white", face = "bold"))


KFP_v_GSoH_facet


ggsave("Output/BarPlot1.png", plot=KFP_v_GSoH_facet)

