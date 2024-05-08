data_url = "https://raw.githubusercontent.com/andandandand/ImageAnalysisWithAlgorithmicInformation/master/fourByFourCTMs.csv"
ctms_df = read.csv(data_url, header = FALSE, col.names = c("block", "ctm_value"), colClasses = c("character", "numeric"))
ctms_dict = as.list(setNames(ctms_df$ctm_value, ctms_df$block))
usethis::use_data(ctms_dict, internal = TRUE)
