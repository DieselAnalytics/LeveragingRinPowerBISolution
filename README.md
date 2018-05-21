# Leveraging R in Power BI Solution

Contained in this repo are 4 examples of how you can leverage R in Power BI when adding data to the Power BI data model. The code is contained in a Visual Studio solution with 4 projects. A description of the 4 projects are listed below:

* Distance Calculation:  Shows how to create a custom function based on the "Haversine" formula to calculate distance between two geographical points
* Quad Chart:  Shows how to put two variables on the same scale using the "normalize" function from the "BBmisc" package
* Regular Expression:  Shows how to find what files in a folder you want to combine based on a "negative lookahead" regular expression 
* ScoreData:  Shows how to score data that you are bringing into the Power BI data model using a saved model

When running the code make sure that you set the working directory to the project that contains the R script you are attempting to run. To do that go to the "Solution Explorer" > highlight the project that contains your R script > Right Click > select "Set Working Directory Here". If you want to use the code in Power BI you need to explicitly set the file path to your data sources or use the Power BI's working directory.

Here are links to the Power BI desktop file, BLS Data, and PowerPoint slides:

* Power BI Desktop File:  https://bit.ly/2s1dBfl
* BLS Data:  https://bit.ly/2LgiER5
* PowerPoint Slides:  https://bit.ly/2IBLKbS

Four packages are uses in this solution. You can run the following code snippet to make sure you have the packages installed:

```{r}
required.pkgs < c("tidyverse", "BBmisc", "readxl", "data.table", "tidyverse")
missing.pkgs <- required.pkgs[!(required.pkgs %in% installed.packages()[,"Package"])]
install.packages(missing.pkgs)
```
