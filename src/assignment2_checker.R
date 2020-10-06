check_question_1 <- function(){
  source("src/assignment2.R", local = TRUE)

  postal_codes <- get_postal_code_counts(data)
  result <- all_equal(postal_codes, readRDS("clean_data/check_data.Rds")$postal)

  if (!result){
    print(result)
    print("Your outcome for get_postal_code_counts() does not match expected results.")
  }
}

check_question_2 <- function(){
  source("src/assignment2.R", local = TRUE)

  relative_migration_counts_all <- get_relative_migration_counts(data, non_western_only = FALSE)
  relative_migration_counts_nw_only <- get_relative_migration_counts(data)

  result_1 <- all_equal(relative_migration_counts_all, readRDS("clean_data/check_data.Rds")$migration_all)
  if (!result_1){
    print(result_1)
    print("Your outcome for get_relative_migration_counts(data, non_western_only = FALSE) does not match expected results.")
  }
  result_2 <- all_equal(relative_migration_counts_nw_only, readRDS("clean_data/check_data.Rds")$migration_nw_only)
  if (!result_2){
    print(result_2)
    print("Your outcome for get_relative_migration_counts(data, non_western_only = TRUE) does not match expected results.")
  }
  if (result_1 && result_2){
    print("The get_relative_migration_counts passed the test.")
  }
}

check_question_3_get_youth <- function(){
  source("src/assignment2.R", local = TRUE)
  if ("get_youth" %in% ls()){
    test <- starwars %>% count(homeworld, sort = TRUE) %>% rename(count = n) %>% get_youth()
    result <- test == c(11,10,10,3)
    if (any(!result)){
      print("The get_youth function does not work properly, please check.")
    } else {
      print("The get_youth function passed the test.")
    }
  } else {
    print("The get_youth function does not exist.")
  }
}

check_question_3 <- function(){
  source("src/assignment2.R", local = TRUE)

  household_info_1 <- get_household_info(data, youth_needed =  50000)
  household_info_2 <- get_household_info(data, youth_needed =  200000)

  household_1 <- readRDS("clean_data/check_data.Rds")$household_1
  household_2 <- readRDS("clean_data/check_data.Rds")$household_2
  result_1 <- household_info_1 == household_1
  result_2 <- household_info_2 == household_2

  if (any(!result_1)){
    print(str_c("Your values: "))
    print(household_info_1)
    print("Correct values: ")
    print(household_1)
  }
  if (any(!result_2)){
    print(str_c("Your values: "))
    print(household_info_2)
    print("Correct values: ")
    print(household_2)
  }
  if (all(result_1) && all(result_2)){
    print("The get_household_info function passed the test.")
  }
}



