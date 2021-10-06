check_code_file <- function(){
  parse_info = getParseData(parse("src/assignment2.R", keep.source = TRUE))

  # top-level lines
  step1 <- parse_info %>% filter(parent == 0)
  step2 <- parse_info %>% filter(parent %in% step1$id)
  step3 <- step2 %>% filter(!terminal) %>% left_join(parse_info, by = c("id" = "parent"))

  original_lines <- step3 %>% semi_join(
    tribble(~token.y, ~text.y,
            "SYMBOL_FUNCTION_CALL", "library",
            "SYMBOL", "get_postal_code_counts",
            "SYMBOL", "get_relative_migration_counts",
            "SYMBOL", "get_household_info"
            )
  )
  lines_to_delete <- step3 %>% anti_join(original_lines, by = "line1.x") %>% pull(line1.x) %>% unique()

  if (length(lines_to_delete) > 0){
    stop(str_c("You have lines of code outside of the given functions. Please put your code within the \"## START jouw code\" and \"## EINDE jouw code\" markers. The offending code is on lines: ", str_c(lines_to_delete, collapse = ", ") , " of your assignment2.R file."))
  }
}

check_question_1 <- function(){
  check_code_file()
  source("src/assignment2.R", local = TRUE)
  data <- readRDS("clean_data/data.Rds")

  postal_codes <- get_postal_code_counts(data)

  if (!"tbl_df" %in% class(postal_codes)){
    stop("The get_postal_code_counts() function does not return a tibble.")
  }

  result <- all_equal(postal_codes, readRDS("clean_data/check_data.Rds")$postal)

  if (!isTRUE(result)){
    print(result)
    stop("Your outcome for get_postal_code_counts() does not match expected results.")
  } else {
    print("Your outcome for get_postal_code_counts() is correct, well done!")
  }
}

check_question_2 <- function(){
  check_code_file()
  source("src/assignment2.R", local = TRUE)
  data <- readRDS("clean_data/data.Rds")

  relative_migration_counts_all <- get_relative_migration_counts(data, non_western_only = FALSE)
  if (!"tbl_df" %in% class(postal_codes)){
    stop("When calling get_relative_migration_counts(data, non_western_only=FALSE), it does not return a tibble.")
  }
  if (!has_name(relative_migration_counts_all, "fraction_migration_background")){
    stop("When calling get_relative_migration_counts(data, non_western_only=FALSE), the resulting tibble should contain a column called \"fraction_migration_background\" but it does not.")
  }
  relative_migration_counts_all$fraction_migration_background <- setNames(relative_migration_counts_all$fraction_migration_background, NULL)
  relative_migration_counts_nw_only <- get_relative_migration_counts(data)
  if (!"tbl_df" %in% class(postal_codes)){
    stop("When calling get_relative_migration_counts(data, non_western_only=TRUE), it does not return a tibble.")
  }
  if (!has_name(relative_migration_counts_nw_only, "fraction_non_western_migration_background")){
    stop("When calling get_relative_migration_counts(data, non_western_only=TRUE), the resulting dataframe should contain a column called \"fraction_non_western_migration_background\" but it does not.")
  }
  relative_migration_counts_nw_only$fraction_non_western_migration_background <- setNames(relative_migration_counts_nw_only$fraction_non_western_migration_background, NULL)



  # remove name attribute in tibble column for both check_data and result
  check_data_1 <- readRDS("clean_data/check_data.Rds")$migration_all
  check_data_1$fraction_migration_background <- setNames(check_data_1$fraction_migration_background, NULL)
  result_1 <- all_equal(relative_migration_counts_all, check_data_1)

  check_data_2 <- readRDS("clean_data/check_data.Rds")$migration_nw_only
  check_data_2$fraction_non_western_migration_background <- setNames(check_data_2$fraction_non_western_migration_background, NULL)
  result_2 <- all_equal(relative_migration_counts_nw_only, check_data_2)

  if (!isTRUE(result_1)){
    print(result_1)
    print("Your outcome for get_relative_migration_counts(data, non_western_only = FALSE) does not match expected results.")
  }

  if (!isTRUE(result_2)){
    print(result_2)
    print("Your outcome for get_relative_migration_counts(data, non_western_only = TRUE) does not match expected results.")
  }
  if (isTRUE(result_1) && isTRUE(result_2)){
    print("The get_relative_migration_counts function passed the test, good job!")
  } else {
    stop("The get_relative_migration_counts function did not pass all of the tests, please check your code.")
  }
}

check_question_3 <- function(){
  check_code_file()
  source("src/assignment2.R", local = TRUE)
  data <- readRDS("clean_data/data.Rds")

  household_info_1 <- get_household_info(data, youth_needed =  50000)
  household_info_2 <- get_household_info(data, youth_needed =  200000)

  if(class(household_info_1) != "character" || typeof(household_info_1) != "character" ||
     class(household_info_2) != "character" || typeof(household_info_2) != "character"){
    stop("The get_household_info() function should return a character vector")
  }

  household_1 <- readRDS("clean_data/check_data.Rds")$household_1
  household_2 <- readRDS("clean_data/check_data.Rds")$household_2

  if (all(str_length(household_info_1) == 4)){
    # only postal code numbers are given, strip the names from the check_data
    household_1 <- str_extract(household_1, "\\d{4}")
    household_2 <- str_extract(household_2, "\\d{4}")
  }

  result_1 <- length(household_info_1) == length(household_1) && all(household_info_1 == household_1)
  result_2 <- length(household_info_2) == length(household_2) && all(household_info_2 == household_2)

  if (!isTRUE(result_1)){
    print("There is a problem with the output of get_household_info(data, youth_needed =  50000)")
    print(str_c("Your values: "))
    print(household_info_1)
    print("Correct values: ")
    print(household_1)
  }
  if (!isTRUE(result_2)){
    print("There is a problem with the output of get_household_info(data, youth_needed =  200000)")
    print(str_c("Your values: "))
    print(household_info_2)
    print("Correct values: ")
    print(household_2)
  }
  if (isTRUE(result_1) && isTRUE(result_2)){
    print("The get_household_info function passed the test, great work!")
  } else {
    stop("Unfortunately, the get_household_info function did not pass the test. Give it another try!")
  }
}



