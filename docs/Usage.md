# BSB: Usage

The **Usage Guide** walks through a complete grading process.  It assumes you have already [installed the system]() and you have already [setup a project]().

### Create destination column for grades in Blackboard

In Blackboard Grade Center, create a column for the exam.

- Choose name ("Midterm")
- Choose and Points Possible (50)
- Set "show this column to students" to "No."  This should be changed later.

### Gather Blackboard grade center data

Import the blackboard grade center "offline work" spreadsheet. Copy that file into the blackboard path.

    cp ~/Download/*.xls blackboard/download.xls

### Prepare the scantron grade CSV files

correct any errors in the exam (such as refunding points for bad questions). this must be applied on a per-version basis, because the questions will be different

### Determine spreadsheet parameters

evaluate the scantron input and set "column_to_replace" and "unique_colnames" below

    bsb-dimensions.sh

which column number on blackboard needs to be replaced with scantron results? this corresponds to the newly-created column in blackboard

    column_to_replace = 12

what are the names of the blackboard columns that need to be saved?

    head blackboard/download.xls

copy the column names

### Correct student ID entry errors

    bsb-students.sh

### Manually add any students who completed makeup exams or whatever

Edit the file R/students.R

### Finalize

- Merge the scantron results
- replace the proper column
- export to a new spreadsheet

    bsb-finalize.sh

### Upload new spreadsheet
