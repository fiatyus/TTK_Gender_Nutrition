<p align="center">

![](images/RSPH_shield_hz_294.png){width="358"}

</p>

<h1 align="center">

Understanding Food Security Drivers:

</h1>

<h2 align="center">

Household Gender Structure and Child Nutrition Knowledge in the Takunda (Zimbabwe) and Titukulane (Malawi) Programs

</h2>

<p align="center">

Afia Tyus

</p>

<p align="center">

DATA 555: Topics in Data Science

</p>

<p align="center">

Rollins School of Public Health, Department of Epidemiology

</p>

## About the Project

### **Project Research Question**

During FY 24, in both the Takunda and Titukulane programs, is there a relationship between the gendered structure of the household and child feeding and nutrition practice knowledge? What factors confound that relationship?

### Background

Food security remains one of the most pressing issues of our time. This project seeks to analyze the ways program interventions, internal behaviors, and demographics may impact measures of food security.

## Project Status

This project was completed as a part of both the epidemiology and the data science certificate capstone courses (EPI 598C and DATA 555 respectively). Launching of this interactive dashboard and github repository satisfied the requirements for the completion of the Rollins School of Public Health Data Science certificate.

**Updates will not continue** after final submission on April 25th.

## File structure:

**Code -** The folder holds all code that has been written to clean the data, develop the graphs, and launch the flexdashboard.

**Dashboard_Materials** - This folder contains all code written to create the interactive dashboard

**Data -** The folder contains all raw data used for analysis.

**Output -** The folder contains all content created by running code. This includes: cleaned data, graphs, and html widgets.

## Code descriptions:

`Code/00_data_cleaning_AT.Rmd`

-   Generated a cleaned data set that can be used for multiple analyses

`Code/01_analysis_filtering.R`

-   Transforms the data for analysis of the given research question including:

    -   Sub-setting by frame

    -   Labeling for Table1

    -   Filtering out small sample sizes

`Code/02_graph1_boxplot.R`

-   Develops a boxplot:

    -   x = gendered structure of the household

    -   y = number of feeding practices know

    -   Grouped by = Program (country)

-   Colors are modified to the CARE template

`Code/03_graph2_barplot.R`

-   Develops a bar plot:

    -   x = Gendered structure of the household

    -   y = Proportion of participants

    -   Grouped by = Program (country)

    -   Color = Knowing 0 or 1 or more feeding practices

-   Colors are modified to the CARE template

`Code/04_graph3_barplot.R`

-   Develops a bar plot:

    -   x = Gendered structure of the household

    -   y = Proportion of participants

    -   Color = Knowing 0 or 1 or more feeding practices

-   Colors are modified to the CARE template

`Code/05_modeling.R`

-   Runs a logistic regression model examining the relationship below

$$
\log(\text{odds of } KFP = 1) =
\alpha + (\beta_1 \cdot \text{Gendered Household Structure}) + \\(\gamma_1 \cdot \text{Age}) + (\gamma_2 \cdot \text{Intervention Participation}) + (\gamma_3 \cdot \text{Program})
$$

`Code/06_table1.R`

-   Produces a table of demographic characteristics, grouped by program

## 

![](images/clipboard-2352407762.png){width="176"}

![](images/RSPH_shield_vt-01.png){width="159"}
