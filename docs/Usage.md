# BSB: Usage

The **Usage Guide** walks through a complete grading process.  It assumes you have already [installed the system](Install.md) and you have already [setup a project](Setup.md).

### Create destination column for grades in Blackboard

See the [Blackboard Guide](Blackboard.md) for a detailed walkthrough of the Blackboard Process.

In Blackboard Grade Center, create a column for the exam.

- Choose name
- Choose and Points Possible
- Set "show this column to students" to "No."  This should be changed later.

### Download Blackboard grades for "offline work"

Import the blackboard grade center "offline work" spreadsheet. Copy that file into the blackboard path: `data/blackboard/download.xls`.  The [Blackboard Guide](Blackboard.md) also describes this process.

### Prepare the scantron grade CSV files

Correct any errors in the exam (such as refunding points for bad questions). This must be applied on a per-version basis, because the questions will be different

### Determine spreadsheet parameters

Evaluate the scantron and blackboard spreadsheet files.

    bsb-spreadsheet.sh

In the file `R/spreadsheet.R`, edit and set "column_to_replace" and "unique_colnames".

#### column_to_replace

Which column number on blackboard needs to be replaced with scantron results? This corresponds to the newly-created column in blackboard.

#### unique_colnames

What are the names of the blackboard columns that need to be saved?  Copy the column names.

### Correct student ID entry errors

One of the most common data entry problems is when students bubble in their own student IDs incorrectly.  This step makes it easier to find which IDs have exams but aren't listed in blackboard.  This also helps find out which students did not take the exam.

    bsb-students.sh

### Manually add any students who completed makeup exams

Edit the file `R/students.R` and figure out which student IDs must be fixed.  Also, if there are student scores to manually add, this is a good time to do it.

Repeatedly run `bsb-students.sh` while updating `R/students.R` in order to fix all student ID problems.

### Export the final spreadsheet

Create the file `data/blackboard/upload.csv` that can be sent directly to Blackboard.

    bsb-finalize.sh

### Upload new spreadsheet

Refer to the [Blackboard Guide](Blackboard.md) for a screenshot of the upload link.

## Next Steps

You're done!  The grades are online and you can rest easy.
