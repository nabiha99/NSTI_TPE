library(sqldf)
db <- dbConnect(SQLite(), dbname="NSTI_TPE.sqlite")
#Read tab delimited date into database
dbWriteTable(conn = db, name = "TDx", value ="Saifee_Nabiha_Dx.txt", row.names = FALSE, header = TRUE, sep='\t')
dbWriteTable(conn = db, name = "TLabs", value ="Saifee_Nabiha_Lab.txt", row.names = FALSE, header = TRUE, sep='\t')
dbWriteTable(conn = db, name = "TPhysLoc", value ="Saifee_Nabiha_PhysLoc.txt", row.names = FALSE, header = TRUE, sep='\t')
dbWriteTable(conn = db, name = "Tdemog", value ="Saifee_Nabiha_demog.txt", row.names = FALSE, header = TRUE, sep='\t', eol = "\r\n")
dbWriteTable(conn = db, name = "TPr", value ="Saifee_Nabiha_Pr.txt", row.names = FALSE, header = TRUE, sep='\t')
dbWriteTable(conn = db, name = "Tservice", value ="Saifee_Nabiha_service.txt", row.names = FALSE, header = TRUE, sep='\t')
#Error when loading visit.txt file from Sally: line 8 did not have 16 elements but loaded fine into Excel and resaved as tab delimited data and then read into database
dbWriteTable(conn = db, name = "Tvisit", value ="Saifee_Nabiha_visit.txt", row.names = FALSE, header = TRUE, sep='\t')
dbWriteTable(conn = db, name = "Tvisit", value ="visitxls.txt", row.names = FALSE, header = TRUE, sep='\t')
#Save tables as dataframes in R
TDx<-dbGetQuery(db, "select * from TDx")
TLabs<-dbGetQuery(db, "select * from TLabs")
TPhysLoc<-dbGetQuery(db, "select * from TPhysLoc")
Tdemog<-dbGetQuery(db, "select * from Tdemog")
TPr<-dbGetQuery(db, "select * from TPr")
Tservice<-dbGetQuery(db, "select * from Tservice")
Tvisit<-dbGetQuery(db, "select * from Tvisit")
summary(Tdemog)

dbGetQuery(db, "drop table Tdemog")
rm(Tdemog)

#Clean gender data
table(Tdemog$Sex)
Tdemog$Sex[Tdemog$Sex %in% c("Male","M")] <- "Male"
Tdemog$Sex[Tdemog$Sex %in% c("Female","F")] <- "Female"

#Clean race description data
Tdemog$RaceDescr[Tdemog$RaceDescr %in% c("Other,Not Reported or Unknown")] <- "Other, Not Reported or Unknown"




