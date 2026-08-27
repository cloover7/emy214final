# The input to this function should be a data frame containing stream chemistry data
moving_average <- function(df) {
  # Initialize a tibble to contain the results
  result <- tibble(
    window_start = seq(ymd("1986-05-20"), ymd("1995-1-1"), by = '9 weeks'),
    k_mgl = NA,
    mg_mgl = NA,
    no3 = NA,
    ca = NA,
    nh4 = NA,
    site = df$Sample_ID[1]
    # Fill in the rest of the ions
  )

  # Fill in the iterator and sequence
  for (i in 1:nrow(result)) {
    # Create variables for the start and end of the current window
    w1 <- result$window_start[i]
    w2 <- result$window_start[i] + 63 #days

    # Create a logical vector, called "in_window", that says which samples are inside the window
    # Hint: you'll compare sample dates to the start and end of the window
    in_window <- c(df$Sample_Date >= w1 & df$Sample_Date < w2)

    # Use indexing to pull out the ion concentrations that fall inside the window
    k_window <- df$K[in_window]
    mg_window <- df$Mg[in_window]
    no3_window <- df$`NO3-N`[in_window]
    ca_window <- df$Ca[in_window]
    nh4_window <- df$`NH4-N`[in_window]
    # The line above gets potassium in the window. Get the rest of the ions too

    # Calculate the mean of each ion concentration and fill in the result
    result$k_mgl[i] <- mean(k_window, na.rm = TRUE)
    result$mg_mgl[i] <- mean(mg_window, na.rm = TRUE)
    result$no3[i] <- mean(no3_window, na.rm = TRUE)
    result$ca[i] <- mean(ca_window, na.rm = TRUE)
    result$nh4[i] <- mean(nh4_window, na.rm = TRUE)
  }

  # Return the result
  return(result)
}

erins_func <- function(df) {
  qs_smoothed <- tibble(
    window_start = rep(
      seq(ymd("1986-05-20"), ymd("2020-12-29"), by = "9 weeks"),
      each = 4
    ), # repeats each window 4 times for each site
    k = NA,
    no3 = NA,
    mg = NA,
    ca = NA,
    nh4 = NA,
    site = NA
  )

  for (i in 1:nrow(qs_smoothed)) {
    w1 <- qs_smoothed$window_start[i]
    w2 <- qs_smoothed$window_start[i] + 63

    for (s in unique(comb$Sample_ID)) {
      # for each site
      # s = Q2
      # makes a vector
      pot <- comb$K[
        comb$Sample_Date >= w1 & comb$Sample_Date < w2 & comb$Sample_ID == s
      ]
      no3 <- comb$`NO3-N`[
        comb$Sample_Date >= w1 & comb$Sample_Date < w2 & comb$Sample_ID == s
      ]
      mg <- comb$Mg[
        comb$Sample_Date >= w1 & comb$Sample_Date < w2 & comb$Sample_ID == s
      ]
      ca <- comb$Ca[
        comb$Sample_Date >= w1 & comb$Sample_Date < w2 & comb$Sample_ID == s
      ]
      nh4 <- comb$`NH4-N`[
        comb$Sample_Date >= w1 & comb$Sample_Date < w2 & comb$Sample_ID == s
      ]

      # mean of vector for that window gets put in the corresponding column
      qs_smoothed$k[i] <- mean(pot, na.rm = TRUE)
      qs_smoothed$no3[i] <- mean(no3, na.rm = TRUE)
      qs_smoothed$mg[i] <- mean(mg, na.rm = TRUE)
      qs_smoothed$ca[i] <- mean(ca, na.rm = TRUE)
      qs_smoothed$nh4[i] <- mean(nh4, na.rm = TRUE)
      qs_smoothed$site[i] <- s
    }
  }
  qs_smoothed <- qs_smoothed |>
    mutate(
      site = rep(c('Q1', 'Q2', 'Q3', 'RMP'), times = nrow(qs_smoothed) / 4)
    )
  return(qs_smoothed)
}
