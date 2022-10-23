library(tidyverse)
dc <- read_csv("./data/drug_consumption_raw.csv", show_col_types = FALSE)
dc_tidy <- 
  dc |> 
  filter(
    Semer == "CL0"
  ) |> 
  transmute(
    Age,
    Sex = Gender,
    Education,
    Country = fct_collapse(
      Country,
      ANZ = c("Australia", "New Zealand"),
      Canada = "Canada",
      UKI = c("UK", "Republic of Ireland"),
      USA = "USA",
      Other = "Other"
    ),
    Ethnicity = fct_collapse(
      Ethnicity,
      Asian = "Asian",
      Black = "Black",
      Mixed = c("Mixed-Black/Asian", "Mixed-White/Asian", "Mixed-White/Black"),
      Other = "Other",
      White = "White"
    ),
    FFM_Neu = Nscore,
    FFM_Ext = Escore,
    FFM_Opn = Oscore,
    FFM_Agr = AScore,
    FFM_Con = Cscore,
    Impulsive,
    SensSeek = SS,
    across(
      c(Alcohol:VSA, -Semer), 
      recode, 
      CL0 = 0,
      CL1 = 0, 
      CL2 = 1, 
      CL3 = 1, 
      CL4 = 1, 
      CL5 = 1, 
      CL6 = 1
    )
  ) |> 
  relocate(Caff, Choc, Alcohol, Nicotine, .after = SensSeek) |> 
  print()
write_csv(dc_tidy, "data/drug_consumption.csv")
