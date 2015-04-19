# BSB: blackboard-scantron-bridge

# start from scratch
source("lib/R/helpers.R")
try(clean_env(),TRUE)

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

# Finalize grades
finalize(
    scantrons,
    blackboard,
    column_to_replace,
    to_export,
    unique_colnames
)
