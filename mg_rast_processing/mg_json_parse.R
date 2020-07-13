#!/usr/bin/env Rscript

library(jsonlite)
library(tidyverse)

# read in JSON file
neon_mg_json <- read_json("~/NEON_metagenomics/mg_rast_processing/NEON_soil_metagenomes.json")

# make tibble from samples
samples_tib <- as_tibble(neon_mg_json$samples, validate = FALSE)

# convert to data frame, transpose, and turn back to a df
df_samples <- as.data.frame(t(as.data.frame(samples_tib)))

# append ?verbosity=full to the end of the urls for curl looping
df_samples[, 2] <- paste(df_samples[, 2], sep = "", "?verbosity=full")

# turn V1 from list to a character vector
df_samples[, 1] <- as.character(df_samples[, 1])

# samples table for curl bash loop
write.table(df_samples,
    file = "~/NEON_metagenomics/mg_rast_processing/neon_samples.txt",
    row.names = FALSE, col.names = FALSE, sep = "\t", quote = FALSE)
