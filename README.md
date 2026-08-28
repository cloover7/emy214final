# Post-Hurricane Water Quality Trends

[![Hurricane Maria](https://www.nesdis.noaa.gov/s3/styles/webp/s3/migrated/2109v1_20170920-HURMaria.png.webp?itok=ENHuGCbh)](https://play.typeracer.com/)

This project examines post-hurricane water quality in terms of concentrations of ions such as Nitrogen, Magnesium, and Ammonium. We aim to replicate graphs produced by Schaefer et al. (2000), specifically figure 3.

## Contents

This repository contains:

- data folder - contains raw data files in CSV format
- 1_clean_data.R - script to clean data
- output folder - contains the cleaned data produced by 1_clean_data.R. This data is ready for analysis.
- paper folder - contains quarto document explaining the project and process
- docs folder - contains html output of quarto document
- R folder - contains custom functions relevant to data cleaning and analysis
- scratch folder - contains miscellaneous scratch scripts

## Data Accessibility
Data was acesssed via McDowell and International Institute Of Tropical Forestry (IITF) (2024)

All relevant data for this analysis is in the data folder.

## Authors & Contributors

Erin Yang

Calvin Fu

Ashwin Chockkalingam

## References

McDowell, William H., and USDA Forest Service. International Institute Of Tropical Forestry (IITF). 2024. “Chemistry of Stream Water from the Luquillo Mountains.” Environmental Data Initiative. [https://doi.org/10.6073/PASTA/F31349BEBDC304F758718F4798D25458](https://doi.org/10.6073/PASTA/F31349BEBDC304F758718F4798D25458).

Schaefer, Douglas. A., William H. McDowell, Fredrick N. Scatena, and Clyde E. Asbury. 2000. “Effects of Hurricane Disturbance on Stream Water Concentrations and Fluxes in Eight Tropical Forest Watersheds of the Luquillo Experimental Forest, Puerto Rico.” Journal of Tropical Ecology 16 (2): 189–207. [https://doi.org/10.1017/s0266467400001358](https://doi.org/10.1017/s0266467400001358).