library(tidyverse)

# make a first draft of a graph

bisley1 <- read_csv('data/QuebradaCuenca1-Bisley.csv')
bisley2 <- read_csv('data/QuebradaCuenca2-Bisley.csv')
bisley3 <- read_csv('data/QuebradaCuenca3-Bisley.csv')
rmp <- read_csv('data/RioMameyesPuenteRoto.csv')

bisley1_yr <- bisley1 |> 
  mutate(Year = year(Sample_Date))

plot1 <- bisley1_yr |> 
  ggplot(
    aes(x = Year, y = K)
  ) +
  geom_line()

plot1

# combine all data tables

comb <- rbind(
  bisley1, bisley2, bisley3, rmp
)

comb <- comb |> 
  mutate(Year = year(Sample_Date))

plot2 <- comb |> 
  ggplot(
    aes(x = Year, y = K, color = Sample_ID)
  ) +
  geom_line()

plot2

# add moving averages

qs_smoothed <- tibble(
  window_start = seq(ymd("1986-05-20"), ymd("2020-12-29"), by = "9 days"),
  k = NA,
  no3 = NA,
  mg = NA,
  ca = NA,
  nh4 = NA,
  site = NA
)

for (i in 1:nrow(qs_smoothed)) {
  w1 <- qs_smoothed$window_start[i]
  w2 <- qs_smoothed$window_start[i] + 9

  for(s in unique(comb$Sample_ID)) {
  
    # makes a vector 
    pot <- comb$K[comb$Sample_Date >= w1 & comb$Sample_Date < w2 & comb$Sample_ID == s]
    no3 <- comb$`NO3-N`[comb$Sample_Date >= w1 & comb$Sample_Date < w2 & comb$Sample_ID == s]
    mg <- comb$Mg[comb$Sample_Date >= w1 & comb$Sample_Date < w2 & comb$Sample_ID == s]
    ca <- comb$Ca[comb$Sample_Date >= w1 & comb$Sample_Date < w2 & comb$Sample_ID == s]
    nh4 <- comb$`NH4-N`[comb$Sample_Date >= w1 & comb$Sample_Date < w2 & comb$Sample_ID == s]

    # mean of vector for that window gets put in the corresponding column
    qs_smoothed$k[i] = mean(pot, na.rm = TRUE)
    qs_smoothed$no3[i] = mean(no3, na.rm = TRUE)
    qs_smoothed$mg[i] = mean(mg, na.rm = TRUE)
    qs_smoothed$ca[i] = mean(ca, na.rm = TRUE)
    qs_smoothed$nh4[i] = mean(nh4, na.rm = TRUE)
    qs_smoothed$site[i] = s
  }
}

# make summary w summarize() and get individual data w $ and []
# 

# issue! it keeps giving me mpg for site s, isn't finding the other ones

qs_long <- qs_smoothed |> 
  pivot_longer(
    cols = c(k, no3, mg, ca, nh4), 
    names_to = 'Ion',
    values_to = 'Concentration'
  )

plot5 <- qs_long |> 
  ggplot(
    aes(x = window_start, y = Concentration)
  ) + geom_line() +
  facet_wrap(vars(Ion))

plot5

# todo: change individual y-axes scale, add site column to qs smoothed and long

# issue: how to get avg per window per site? rn its j per window, assuming across all sites