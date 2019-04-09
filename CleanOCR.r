# Use Find a replace to add commas between labels
# Then remove path to each image leaving just file name

OCR <- read_csv("Desktop/OCR.txt", col_names = FALSE)
OCR <- t(OCR)
OCR
OCR <- cbind(index,OCR)
index <- substr(OCR, 0, 8)


colnames(OCR)<-c("HAW_Code","Description")
OCR <- as.data.frame(OCR)

OCR$Description

coll_num <- sub(".*No*."," ",OCR$Description)
coll_num <- substr(coll_num, 0, 7)

?sub

date <- sub(".*Date*.","\\1",OCR$Description)



OCR <- cbind(date,OCR)

OCR <- cbind(coll_num,OCR)

OCR <- cbind(index,OCR)

write.csv(OCR, "clean_OCR.csv")
?write.csv
