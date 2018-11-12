# Load Data

library(rvest)
library(data.table)
library(tidyr)
library(stringr)
year <- 2018

#for(year in 2016:2018){
for(quarter in 1:2){
    url <- paste0("https://baddogagility.com/the-bad-dog-agility-power-60-for-",year,"-through-q",quarter,"/")
    names <- url %>% read_html() %>% html_nodes(".power60 tr td") %>% html_text()
    dataframe <- data.table::data.table(names)
    
    # Allocate rows to different dog heights
    table16 <- dataframe[c(1:99),]
    table20 <- dataframe[c(100:198),]
    table24 <- dataframe[c(199:297),]
    
    # Height 16"
    df16 <- data.frame(matrix(table16, nrow = 9, byrow = TRUE))
    colnames(df16) <- "V1"
    df16new <- data.table(matrix(unlist(df16$V1[1]), ncol = 9, byrow = TRUE))
    
    colnames(df16new) <- as.character(df16new[c(1),])
    colnames(df16new)[1] <- "Placing"
    df16final <- df16new[-c(1),]
    df16final$Height <- c("16")
    
    # Height 20"
    df20 <- data.frame(matrix(table20, nrow = 9, byrow = TRUE))
    colnames(df20) <- "V1"
    df20new <- data.table(matrix(unlist(df20$V1[1]), ncol = 9, byrow = TRUE))
    
    colnames(df20new) <- as.character(df20new[c(1),])
    colnames(df20new)[1] <- "Placing"
    df20final <- df20new[-c(1),]
    df20final$Height <- c("20")
    
    
    # Height 24"
    df24 <- data.frame(matrix(table24, nrow = 9, byrow = TRUE))
    colnames(df24) <- "V1"
    df24new <- data.table(matrix(unlist(df24$V1[1]), ncol = 9, byrow = TRUE))
    
    colnames(df24new) <- as.character(df24new[c(1),])
    colnames(df24new)[1] <- "Placing"
    df24final <- df24new[-c(1),]
    df24final$Height <- c("24")
    
    # Combine heights
    dataDF_int <- rbind(df16final,df20final,df24final)
    dataDF_int$Quarter <- rep(paste0("Q",quarter),nrow(dataDF_int))
    
    save(dataDF_int,file=paste0("Data",year,"q",quarter,".RData"))
    
    assign(paste0("data",year,"q",quarter),dataDF_int)
}

# Combine quarters
dataDF <- rbind(data2018q1,data2018q2)

save(dataDF, file = "AgilityData.RData")
