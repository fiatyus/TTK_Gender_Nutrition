
here::i_am("Code/00_01_renderclean.R")

rmarkdown::render(
  here::here("Code/00_data_cleaning_AT.Rmd"),
  knit_root_dir = here::here()
)
