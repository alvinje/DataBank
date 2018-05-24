# Projet Data
# Groupe Kévin - Jérémie - Rémi
setwd("D:/logiciel/RStudio/save/DataBank/data")
install.packages("lubridate")
csv <- read.csv("banking_credit.csv", T, sep=';')
is.data.frame(csv)
filteredCsv <- csv[csv$Typologie_client != "",]

View(filteredCsv)

# Update csv data
filteredCsv <- droplevels(filteredCsv)
filteredCsv$Id <- NULL

# calcul de l'age
filteredCsv$Date_naissance <- as.Date(filteredCsv$Date_naissance, format="%d/%m/%Y")
now <- Sys.Date()
filteredCsv$age <- as.integer(difftime(now, filteredCsv$Date_naissance, unit="weeks")/52.25)

summary(filteredCsv)
boxplot(filteredCsv$Montant_credit)

# A verifier:
# bon nb de ligne, de collones, var bien typées (numeric, qualitatives)
# bug à la lecture -> verifier si aucunes données se sont glissées en trop

# - supprimer les données corrrompues ou abérentes boxplot
# - créer les models