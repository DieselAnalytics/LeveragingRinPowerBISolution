# Leveraging R in Power BI

Contained in this repo are 4 examples of how you can leverage R in Power BI when adding data to the Power BI data model. The code is contained in a Visual Studio solution with 4 projects. A description of the 4 projects are listed below:

* **Distance Calculation**:  Shows how to create a custom function based on the "Haversine" formula to calculate distance between two geographical points. The project also demonstrate how to use the custom function to calculate trip distance in miles of trips from a data set that contains NYC taxi rides.
* **Quad Chart**:  Shows how to put two variables on the same scale using the "normalize" function from the "BBmisc" package. The transformed dataset in this package is the source for a custom R "Quad Chart".
* **Regular Expressions**:  Shows how to find the files in a folder that matches a regex pattern. We will introduce an interm regex concept known as "negative lookahead" to build the regex expression pattern. The project also demonstrates how to combine the files that meets the regex criteria into one dataset. 
* **Score Data**:  Shows how to score data brought into the Power BI data model via a R script using a logistic regression model built in R that is saved on disk. 

When running the code make sure that you set the working directory to the project that contains the R script you are attempting to run. To do that go to the "Solution Explorer" > highlight the project that contains your R script > Right Click > select "Set Working Directory Here" if you are using **RTVS** (R Tools for Visual Studio). If you want to use the code in Power BI you need to explicitly set the file path to your data sources or use the working directory that Power BI has for R.

Here are links to the Power BI desktop file that illustrates some custom R visualization examples in Power BI, the BLS data used in the regular expression example, and PowerPoint slides used in the presentation:

* **Power BI Desktop File**:  https://bit.ly/2s1dBfl
* **BLS Data**:  https://bit.ly/2LgiER5
* **PowerPoint Slides**:  https://bit.ly/2IBLKbS

Five packages are uses in this solution. You can run the following code snippet to make sure you have the required packages installed:

```{r}
required.pkgs < c("tidyverse", "BBmisc", "readxl", "data.table", "tidyverse")
missing.pkgs <- required.pkgs[!(required.pkgs %in% installed.packages()[,"Package"])]
install.packages(missing.pkgs)
```
