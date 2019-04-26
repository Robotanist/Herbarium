# use find and replace equal signs with commas between labels with some text editor (e.g.; Atom)
# using terminal in directory run shell command to remove new lines "tr -d "\n\r" < HAW_DDP_OCR.txt > HAW_DDP_OCR.csv"
library(readr)
OCR <- read_csv("/Users/solomon.champion/Documents/Joseph_F_Rock_Herbarium_(HAW)/OCR/HAW_DDP_JPEG/HAW_DDP_OCR.csv", col_names = FALSE)

# transform column to rows 
OCR <- t(OCR)

# extracts HAW code
HAW <- substr(OCR, 46, 53)

# binds HAW code in column
OCR <- cbind(HAW,OCR)

# label column header
colnames(OCR) <-c("HAW","label")

# extract collector number
OCRdf <- as.data.frame(OCR)

#OCRdf$label

coll_num <- sub(".*No*."," ",OCRdf$label)
coll_num <- substr(coll_num, 0, 7)

#?sub

#date <- sub(".*Date*.","\\1",OCRdf$label)
#date <- substr(date, 0, 20)

OCRdf <- cbind(coll_num,OCR)

write.csv(OCRdf, "clean_OCR.csv")
#?write.csv
