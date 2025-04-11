
here::i_am("07_Afia/Table_AfiaTyus.R")
library(readr)
data_filtered <- read_csv(here::here("07_Afia/data_filtered_AT.csv"))



library(table1)

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


# Set custom background color
browsable(
  tagList(
    tags$style(HTML("
      .Rtable1-zebra table {
        background-color: transparent !important;
      }
    ")),
    table_Afia_v1
  )
)

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

