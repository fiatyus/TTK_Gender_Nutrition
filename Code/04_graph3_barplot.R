
here::i_am("Code/04_graph3_barplot.R")

data_filtered <- readRDS(here::here("Data/final_data.rds"))

library(ggplot2)
library(dplyr)

# Calculate counts per Gendered_HH_Type and KFP
data_with_count <- data_filtered %>%
  count(Gendered_HH_Type, KFP) %>%
  mutate(text = paste("GSoH:", Gendered_HH_Type, "<br>Feeding Practices Known:", KFP, "<br>Count:", n))

data_with_count <- data_with_count %>% 
  mutate(GSoH = case_when(Gendered_HH_Type == "Adult Female no Adult Male (FnM)" ~ "FnM",
                          Gendered_HH_Type == "Adult Male and Adult Female (M&F)" ~ "M&F")
)


data_with_count_facet <- data_filtered %>%
  count(Gendered_HH_Type, KFP, program)

data_with_count_facet <- data_with_count_facet %>% 
  mutate(GSoH = 
           case_when(Gendered_HH_Type == "Adult Female no Adult Male (FnM)" ~ "FnM",
                     Gendered_HH_Type == "Adult Male and Adult Female (M&F)" ~ "M&F")
)

KFP_v_GSoH <- ggplot(data = data_with_count, aes(x= GSoH, y=n, fill = KFP)) +
  geom_bar(stat = "identity", position = "fill")+
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20))+
  labs(x = "Gendered Structure of the Household",
       y = "Proportion of Participants",
       title = "Feeding Practice Knowledge \nby GSoH",
       fill = "Knowledge")+
  theme_minimal()+
  scale_fill_manual(values = c('#5C2163', '#F67601'))+
  theme(legend.position="bottom",
        plot.background = element_rect(fill = "#FFF8ED", color = NA),  
        panel.background = element_rect(fill = "#FFF8ED", color = NA),
        legend.background = element_rect(fill = "#FFF8ED", color = NA),
        strip.background = element_rect(fill = "#BF7BB5", color = NA),
        strip.text = element_text(color = "white", face = "bold"))+
  theme(legend.position="bottom")


KFP_v_GSoH

ggsave("Output/BarPlot2.png", plot=KFP_v_GSoH_facet)
