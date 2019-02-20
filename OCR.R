library("tidyr")
library("readr")


OCR <- read_csv("/Users/solomon.champion/R/rows.csv",col_names = FALSE)
View(OCR)

# Transpose col to rows
# tdt <- t(OCR)

# number of characters in each record
# nchar(OCR)

# average number characters per record 
# mean(nchar(OCR[1:100]))

# extracts HAW catalogue number from first 8 characters of record in CSV
# named <- substr(tdt, 0, 8)

# extract HAW catalogue number from each record "HAW******.JPEG"

# HAW_num <- [HAW******.JPEG, to first space]

HAW_num <- substr(OCR$X2, 33, 44)

HAW_num

# Merges HAW number with OCR CSV

mergecsv <- cbind(HAW_num,OCR)

mergecsv
