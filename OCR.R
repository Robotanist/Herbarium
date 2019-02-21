#library("tesseract")
#library("Taxonstand")
library("tidyr")
library("readr")
library("hunspell")
library("magick")



#eng <- tesseract("eng")
#text <- tesseract::ocr("/Users/solomon.champion/Pictures/Hibiscadelphus/Hibiscadelphus/HAW.png", engine = eng)
#cat(text)

OCR <- read_csv("/Users/solomon.champion/R/rows.csv",col_names = FALSE)
#View(OCR)

# Transpose col to rows if needed
# tOCR <- t(OCR)

# extract HAW catalogue number from each record "HAW******.JPEG"

# HAW_num <- [HAW******.JPEG, to first space]

HAW_num <- substr(OCR$X2, 33, 40)

#HAW_num <- gsub("(HAW[0-9]+).JPG", "\\1", OCR$X2)

HAW_num

# Merges HAW number with OCR CSV

mergecsv <- cbind(HAW_num,OCR)

mergecsv

# Removes blank first row if needed
# mergecsv = mergecsv[-1,]

# Suppress blank column if needed
mergecsv$X1 = NULL

# number of characters in each record
nchar(mergecsv$X2)

# average number characters per record 
# mean(nchar(mergecsv$X2))

# Rename column
colnames(mergecsv)[colnames(mergecsv)=="X2"] <- "Description"



# Remove first 45 characters from each observation (Pathname)

pathname <- substr(mergecsv$Description, 0, 45)

mergecsv$Description <- stri_split(mergecsv$Description, regex = pathname)

mergecsv
