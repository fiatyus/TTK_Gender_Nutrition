
# REPORT ASSOCIATED RULES

cleandata: code/00_cleaningdata_TYUS.R
	Rscript code/00_cleaningdata_TYUS.R

table1: code/01_table1.R cleandata
	Rscript code/01_table1.R

table2: code/02_table2_TYUS.R cleandata
	Rscript code/02_table2_TYUS.R

graph1: code/03_graph1_TYUS.R cleandata
	Rscript code/03_graph1_TYUS.R

graph2: code/04_graph2_TYUS.R cleandata
	Rscript code/04_graph2_TYUS.R

final_report: RMarkdown_modularized_TYUS.Rmd cleandata table1 table2 graph1 graph2
	Rscript code/05_renderreport_TYUS.R

.PHONY: install
install:
	Rscript -e "renv::restore(prompt=FALSE)"

.PHONY: cleanoutputs
cleanoutputs:
	rm -f tables/*.rds && rm -f RMarkdown_modularized_TYUS.html && rm -f graphs/*.rds && rm -f graphs/*.png && rm -f cleaned_data/Food_Insecurity_cleaned.csv
	
# DOCKER ASSOCIATED RULES

PROJECTFILES = RMarkdown_modularized_TYUS.Rmd code/00_cleaningdata_TYUS.R code/01_table1.R code/02_table2_TYUS.R code/03_graph1_TYUS.R code/04_graph2_TYUS.R code/05_renderreport_TYUS.R
RENVFILES = renv.lock renv/activate.R renv/settings.json


# RULE TO BUILD IMAGE
project_image: Dockerfile $(PROJECTFILES) $(RENVFILES)
	docker build -t fiatyus/project_v1 . 
	touch $@

# RULE TO BUILD THE REPORT AUTOMATICALLY IN THE CONTAINER

final_report/build.html:
	docker run -v "$$(pwd)"/final_report:/home/rstudio/final_project/final_report fiatyus/final_v1



