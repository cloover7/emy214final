# The input to this function should be a data frame containing stream chemistry data
moving_average <- function(df) {
  result <- tibble(
    window_start = seq(ymd("1986-05-20"), ymd("1995-1-1"), by = '9 weeks'),
    k_mgl = NA,
    mg_mgl = NA,
    no3 = NA,
    ca = NA,
    nh4 = NA,
    site = df$Sample_ID[1]
    
  )

  
  for (i in 1:nrow(result)) {
    # Create variables for the start and end of the current window
    w1 <- result$window_start[i]
    w2 <- result$window_start[i] + 63 # days

    # 9 week windows
    in_window <- c(df$Sample_Date >= w1 & df$Sample_Date < w2)

    # Use indexing to pull out the ion concentrations that fall inside the window
    k_window <- df$K[in_window]
    mg_window <- df$Mg[in_window]
    no3_window <- df$`NO3-N`[in_window]
    ca_window <- df$Ca[in_window]
    nh4_window <- df$`NH4-N`[in_window]

    # Calculate the mean of each ion concentration for moving average
    result$k_mgl[i] <- mean(k_window, na.rm = TRUE)
    result$mg_mgl[i] <- mean(mg_window, na.rm = TRUE)
    result$no3[i] <- mean(no3_window, na.rm = TRUE)
    result$ca[i] <- mean(ca_window, na.rm = TRUE)
    result$nh4[i] <- mean(nh4_window, na.rm = TRUE)
  }

  return(result)
}

