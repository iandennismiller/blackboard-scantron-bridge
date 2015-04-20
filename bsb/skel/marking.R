# BSB: blackboard-scantron-bridge

try(clean_env(),TRUE)
source("lib/R/helpers.R")

# determine spreadsheet dimensions
cmd_spreadsheet()

# troubleshoot issues with student IDs
cmd_students()

# finalize file for upload
cmd_finalize()
