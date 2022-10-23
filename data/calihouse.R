library(tidyverse)
ch <- read_csv("./data/calihouse_raw.csv", show_col_types = FALSE)
ch_tidy <- 
  ch |> 
  transmute(
    house_mdn_value = Median_House_Value,
    house_mdn_age = Median_Age,
    households = Households,
    rooms = Tot_Rooms,
    bedrooms = Tot_Bedrooms,
    population = Population,
    mdn_income = Median_Income,
    longitude = Longitude,
    latitude = Latitude,
    dist_coast = Distance_to_coast,
    dist_la = Distance_to_LA,
    dist_sd = Distance_to_SanDiego,
    dist_sf = Distance_to_SanFrancisco,
    dist_sj = Distance_to_SanJose
  ) |> 
  # Remove censoring
  filter(house_mdn_value != 500001)
write_csv(ch_tidy, "./data/calihouse.csv")