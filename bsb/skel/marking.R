# BSB: blackboard-scantron-bridge

# start from scratch
try(clean_env(),TRUE)
source("lib/R/helpers.R")

# Load scantrons and blackboard grades
source("R/loading.R")

# Determine dimensions of spreadsheets
dimensions(
    blackboard,
    scantrons
)

# Spreadsheet setup
source("R/spreadsheet.R")

# Fix student data
source("R/students.R")
missing_exams(scantrons, blackboard)
find_entry_errors(scantrons, blackboard)

# Finalize grades
finalize(
    scantrons,
    blackboard,
    column_to_replace,
    to_export,
    unique_colnames
)
