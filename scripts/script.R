# Projet Data
# Groupe Kévin - Jérémie - Rémi
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
filteredCsv$Garants <- as.factor(filteredCsv$Garants)
filteredCsv$Duree_Residence <- as.integer(filteredCsv$Duree_Residence)

# Update csv data
filteredCsv <- droplevels(filteredCsv)
filteredCsv$Id <- NULL
filteredCsv$Date_naissance <- NULL

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
reg.model <- glm(formula = Typologie_client ~ . , family = binomial, data = echan.app)

reg.model2 = step(reg.model,direction="both")

glm_predictions <- predict(reg.model2, newdata = echan.test, type = "response")

echan.test$pred_good <- as.factor(ifelse(glm_predictions > 0.5,1,0))

matrice <- table(echan.test$Typologie_client, echan.test$pred_good)

#taux d'erreur 

(matrice[2]+matrice[3])/sum(table(echan.test$Typologie_client, echan.test$pred_good))

