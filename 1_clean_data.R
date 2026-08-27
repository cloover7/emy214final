library(tidyverse)
source('R/movingaverage.R')

bisley1 <- read_csv('data/QuebradaCuenca1-Bisley.csv')
bisley2 <- read_csv('data/QuebradaCuenca2-Bisley.csv')
bisley3 <- read_csv('data/QuebradaCuenca3-Bisley.csv')
rmp <- read_csv('data/RioMameyesPuenteRoto.csv')

b1 <- moving_average(bisley1)
b2 <- moving_average(bisley2)
b3 <- moving_average(bisley3)
rmp_ind <- moving_average(rmp)

new_comb <- rbind(b1, b2, b3, rmp_ind)

write_csv(new_comb, 'output/cleaned_data.csv')
