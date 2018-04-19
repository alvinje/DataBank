# Projet Data
# Groupe Kévin - Jérémie - Rémi
setwd("D:/logiciel/RStudio/save/DataBank/data")
csv <- read.csv("banking_credit.csv", T, sep=';')
is.data.frame(csv)
filteredCsv <- csv[csv$Typologie_client != "",]

View(filteredCsv)

# Update csv data
filteredCsv <- droplevels(filteredCsv)
summary(filteredCsv)
boxplot(filteredCsv$Montant_credit)

# Remove absurd data Montant_credit
filteredCsv = filteredCsv[!filteredCsv$Montant_credit %in% boxplot(filteredCsv$Montant_credit,range=2)$out,]




# A verifier:
# bon nb de ligne, de collones, var bien typées (numeric, qualitatives)
# bug à la lecture -> verifier si aucunes données se sont glissées en trop

# - supprimer les données corrrompues ou abérentes boxplot
# - créer les models

