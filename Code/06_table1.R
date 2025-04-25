
here::i_am("Code/06_table1.R")
library(readr)
library(table1)


data_filtered <- readRDS(here::here("Data/final_data.rds"))


# creating table title and footnotes
table_title = "Study Population Descriptive Statistics by Program"
table_subtitle = "(Population includes all participants asked feeding practice knowledge questions)"
table_footnote = "Population filtered to those in the health and nutrition for children frames (frame 3 for Takunda and 'Health and nutrition' for Titukulane)"


# rendering for continuous variables
my.render.cont <- function(x, name, ...) {
  if (!is.numeric(x)) return(render.categorical.default(x))
  what <- switch(name,
                 Age  = "Median [Min, Max]",
                 interventions = "Median [Min, Max]",
                 KFP_sum = "Median [Min, Max]"
                 )
  parse.abbrev.render.code(c("", what))(x)
}



# Creating the final table
table_Afia_v1 <- table1(~Gendered_HH_Type + Age + Sex + 
                       interventions + KFP_sum + KFP | program, 
                   data = data_filtered,
                   caption = paste(table_title, "<br>", table_subtitle),
                   footnote = table_footnote,
                   topclass="Rtable1-zebra",
                   render = my.render.cont
)
table_Afia_v1



table_Afia_v2 <- table1(~Gendered_HH_Type + Age + Sex + 
                          interventions + KFP | program, 
                        data = data_filtered,
                        caption = paste(table_title, "<br>", table_subtitle),
                        footnote = table_footnote,
                        topclass="Rtable1-zebra",
                        render = my.render.cont
)
table_Afia_v2
