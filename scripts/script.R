# Projet Data
# Groupe Kévin - Jérémie - Rémi
setwd("D:/logiciel/RStudio/save/DataBank/data")
install.packages("lubridate")
csv <- read.csv("banking_credit.csv", T, sep=';')
is.data.frame(csv)
filteredCsv <- csv[csv$Typologie_client != "",]

View(filteredCsv)

# fictive date
date <- as.Date("10/10/1996", format="%d/%m/%Y")
now <- Sys.Date()
age <- as.integer(difftime(now, date, unit="weeks"))/52.25
age

# Update csv data
filteredCsv <- droplevels(filteredCsv)
filteredCsv$Id <- NULL
typeof(filteredCsv$Date_naissance)
filteredCsv$age <- filteredCsv$Date_naissance - Sys.Date()
summary(filteredCsv)
boxplot(filteredCsv$Montant_credit)

# A verifier:
# bon nb de ligne, de collones, var bien typées (numeric, qualitatives)
# bug à la lecture -> verifier si aucunes données se sont glissées en trop

# - supprimer les données corrrompues ou abérentes boxplot
# - créer les models