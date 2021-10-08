library(tidyverse)

# Je kan de data set inladen met de volgende regel (niet in dit bestand zetten)
# data <- readRDS("clean_data/data.Rds")

# Bekijk de data in RStudio
# data is een lijst van gemeenten in Nederland
# Elke gemeente bevat een lijst met postcodes die in die gemeente vallen
# elke postcode bevat
#  - "men" : een dataframe met leeftijdsgroepen en hoeveel mannen er in die postcode in die groep vallen
#  - "women" : een dataframe met leeftijdsgroepen en hoeveel vrouwen er in die postcode in die groep vallen
#  - "migration" : een named vector met hoeveel mensen een migratie achtergrond hebben (westers, niet-westers) in deze postcode
#  - "households" : een named vector met de drie soorten huishoudens en hoeveel er daarvan zijn in deze postcode,
#        plus de gemiddelde grootte van een huishouden


# Vraag 1 -----------------------------------------------------------------

# Schrijf een functie die een tibble teruggeeft met de kolommen "municipality" en "postal_code_count"
#   Per gemeente maak je één rij in de tibble met de naam van de gemeente en het aantal postcodes in die gemeente
get_postal_code_counts <- function(data){

  ## START van jouw code


  ## EINDE jouw code

}


# Vraag 2 -----------------------------------------------------------------

# Schrijf een functie die per gemeente uitrekent hoeveel procent van de bevolking een migratie achtergrond heeft
# Houdt rekening met de non_western_only parameter: als deze TRUE is bereken je hoeveel procent van de bevolking een
#   niet-westerse migratie achtergrond heeft; als deze FALSE is neem je beide migratie achtergronden samen in het percentage
# Deze functie moet een tibble teruggeven met een kolom "municipality" met daarin de gemeente namen,
#   en een kolom "fraction_migration_background" met daarin de fractie (getal tussen 0 en 1).
# Als non_western_only TRUE is, maak je van de tweede kolom "fraction_non_western_migration_background" met daarin de fractie.
get_relative_migration_counts <- function(data, non_western_only = TRUE) {

  ## START jouw code





  ## EINDE jouw code

}


# Vraag 3 -----------------------------------------------------------------

# Schrijf een functie die de kleinste set aan postcodes teruggeeft, waarmee minstens X aantal jongeren (0-20 jaar) worden bereikt.
# Het gewenste aantal jongeren (X) is een argument van de functie, genaamd 'youth_needed'.
#
# De functie geeft een character vector terug met de postcodes
#
# Hint: check de map_depth functie om niet in de eerste laag van de lijst te itereren,
#    maar in een diepere laag (de postcodes op laag 2 bijvoorbeeld)
get_household_info <- function(data, youth_needed = 100000){



  ## START jouw code


  ## EINDE jouw code

}

