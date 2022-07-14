# Install/load any packages
install.packages("pacman")

# Installs and library() if package is not available
pacman::p_load(readr, dplyr, purrr) 

# Read in data
plant <- read_csv("data/Plant_height.csv")

# Exclude Herb/Shrub
 plant %>% 
   filter(! growthform == "Herb/Shrub" & 
          !  growthform == "Shrub/Tree" &
          ! growthform == "Fern") -> plant_processed

# Split data as a list
plant_ls <- split(plant_processed, plant_processed$growthform)

# Run model for each growth form and output the coefficients
plant_output <- plant_ls %>% 
  map(~ lm(loght ~ temp, data = .)) %>% 
  map(~ summary(.)) 

# Save the model output
saveRDS(plant_output, "output/growthform_lm_output")

      