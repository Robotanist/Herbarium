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

OCR$label

coll_num <- sub(".*No*."," ",OCR$label)
coll_num <- substr(coll_num, 0, 7)

?sub

date <- sub(".*Date*.","\\1",OCR$label)



OCR <- cbind(date,OCR)

OCR <- cbind(coll_num,OCR)

OCR <- cbind(index,OCR)

write.csv(OCR, "clean_OCR.csv")
?write.csv
