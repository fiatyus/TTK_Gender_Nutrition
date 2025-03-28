
here::i_am("07_Afia/table1_v2.R")

library(readr)
data_filtered <- read_csv(here::here("07_Afia/data_filtered_AT.csv"))



library(table1)

# creating table title and footnotes
table_title = "Study Population Descriptive Statistics"
table_subtitle = "Combined data from the Takunda and Titikulane programs"
table_footnote = "*Values may not sum to the total due to missing data"



names(data_filtered)

label(data_filtered$interventions) <- "Interventions Participated In"
label(data_filtered$KFP_sum) <- "Feeding Practices Known"


# lets treat KFP_sum as a categorical variable
data_filtered$KFP_sum <- as.factor(data_filtered$KFP_sum)
data_filtered$Participate_CareGroup <- as.factor(data_filtered$Participate_CareGroup)
data_filtered$Participate_VillageSavings <- as.factor(data_filtered$Participate_VillageSavings)
data_filtered$Participate_SAADialoguesGender <- as.factor(data_filtered$Participate_SAADialoguesGender)


# specific rendering by variable
rndr <- function(x, name, ...) {
  if (!is.numeric(x)) return(render.categorical.default(x))
  what <- switch(name,
                 Age = "Median [Min, Max]",
                 Men_15_29  = "Median [Min, Max]",
                 Men_30 = "Median [Min, Max]",
                 Female_15_29 = "Median [Min, Max]",
                 Female_30 = "Median [Min, Max]",
                 interventions = "Median [Min, Max]",
                 interventions = "Mean (SD)"
                 )
  parse.abbrev.render.code(c("", what))(x)
}



# Creating the final table
table_Afia_v1 <- table1(~Gendered_HH_Type + Age + Sex + 
                       interventions + KFP + Men_15_29 + Men_30 +
                         Female_15_29 + Female_30 | program, 
                   data = data_filtered,
                   caption = paste(table_title, "<br>", table_subtitle),
                   footnote = table_footnote,
                   topclass="Rtable1-zebra"
)
table_Afia_v1



table_Afia_v2 <- table1(~Gendered_HH_Type + Age + Sex + 
                          interventions + KFP + Men_15_29 + Men_30 +
                          Female_15_29 + Female_30 + Participate_CareGroup + 
                          Participate_VillageSavings + 
                          Participate_SAADialoguesGender | program,
                        data = data_filtered,
                        caption = paste(table_title, "<br>", table_subtitle),
                        footnote = table_footnote,
                        topclass="Rtable1-zebra"
)

table_Afia_v2
