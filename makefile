# REPORT ASSOCIATED RULES

cleandata: Code/00_data_cleaning_AT.Rmd Code/00_01_renderclean.R
	Rscript Code/00_01_renderclean.R

analysis_filtering: Code/01_analysis_filtering.R cleandata
	Rscript Code/01_analysis_filtering.R analysis_filtering

table1: Code/06_table1.R cleandata analysis_filtering
	Rscript Code/06_table1.R

model1: Code/05_modeling.R cleandata analysis_filtering
	Rscript Code/05_modeling.R

graph1: Code/02_graph1_boxplot.R cleandata analysis_filtering
	Rscript Code/02_graph1_boxplot.R

graph2: Code/03_graph2_barplot.R cleandata analysis_filtering
	Rscript Code/03_graph2_barplot.R

graph3: Code/04_graph3_barplot.R cleandata analysis_filtering
	Rscript Code/04_graph3_barplot.R

dashboard: Flexdashboard_TYUS.Rmd cleandata analysis_filtering table1 graph1 graph2 graph3
	Rscript Code/07_renderdashboard.R


.PHONY: cleanoutputs
cleanoutputs:
	rm -f tables/*.rds && rm -f RMarkdown_modularized_TYUS.html && rm -f graphs/*.rds && rm -f graphs/*.png && rm -f cleaned_data/Food_Insecurity_cleaned.csv
	
