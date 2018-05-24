# Projet Data
# Groupe Kévin - Jérémie - Rémi
setwd("D:/logiciel/RStudio/save/DataBank/data")
install.packages("lubridate")
csv <- read.csv("banking_credit.csv", T, sep=';')
is.data.frame(csv)
filteredCsv <- csv[csv$Typologie_client != "",]


# Remove absurd data Montant_credit
filteredCsv <- filteredCsv[!filteredCsv$Montant_credit %in% boxplot(filteredCsv$Montant_credit,range=2)$out,]

# calcul de l'age
filteredCsv$Date_naissance <- as.Date(filteredCsv$Date_naissance, format="%d/%m/%Y")
now <- Sys.Date()
filteredCsv$age <- as.integer(difftime(now, filteredCsv$Date_naissance, unit="weeks")/52.25)

# Convert data quali to quanti
filteredCsv$Nb_credit_existants <- as.integer(filteredCsv$Nb_credit_existants)
filteredCsv$Garants <- as.integer(filteredCsv$Garants)

# Update csv data
filteredCsv <- droplevels(filteredCsv)
filteredCsv$Id <- NULL
filteredCsv$Date_naissance <- NULL
filteredCsv$Sexe <- NULL
filteredCsv$Id <- NULL

View(filteredCsv)
summary(filteredCsv)
boxplot(filteredCsv$Montant_credit)

# Create test and apprentissage vars
set.seed(1) # Pour que l'on ait tous les m�mes �chantillons

n.app=2/3*nrow(filteredCsv)

n.test=1/3*nrow(filteredCsv)

ind.app = sample(1:nrow(filteredCsv),size=n.app,replace=FALSE)

echan.app = filteredCsv[ind.app,]

echan.test = filteredCsv[-ind.app,]

# cr�ation du modele
reg.model3 = step(echan.app,direction="both")

# A verifier:
# bon nb de ligne, de collones, var bien typées (numeric, qualitatives)
# bug à la lecture -> verifier si aucunes données se sont glissées en trop

# - supprimer les données corrrompues ou abérentes boxplot
# - créer les models

