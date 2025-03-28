
here::i_am("07_Afia/Table_AfiaTyus.R")
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


# changing labeling
label(data_filtered$interventions) <- "Interventions Participated In"


# Creating the final table
table_Afia_v1 <- table1(~Gendered_HH_Type + Age + Sex + 
                       interventions + KFP_sum + Men_15_29 + Men_30 +
                         Female_15_29 + Female_30 | program, 
                   data = data_filtered,
                   caption = paste(table_title, "<br>", table_subtitle),
                   footnote = table_footnote,
                   topclass="Rtable1-zebra"
)
table_Afia_v1



# Extra stuff

#applying appropriate rounding
my.render.cont <- function(x) {
  with(stats.apply.rounding(stats.default(x), digits=3), c("",
                                                           "Mean (SD)"=sprintf("%s (%0.3s)", MEAN, SD)))
}
my.render.cat <- function(x) {
  c("", sapply(stats.default(x), function(y) with(y,
                                                  sprintf("%d (%0.0f %%)", FREQ, PCT))))
}

{mean_val <- mean(x, na.rm = TRUE)
  median_val <- median(x, na.rm = TRUE)
  sd_val <- sd(x, na.rm = TRUE)
  sprintf("Mean: %.2f (SD: %.2f)\nMedian: %.2f", mean_val, sd_val, median_val)
}