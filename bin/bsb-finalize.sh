#!/bin/bash

# BSB: blackboard-scantron-bridge

R --quiet -e 'source("lib/R/helpers.R"); source("R/loading.R"); source("R/spreadsheet.R"); source("R/students.R"); finalize(scantrons, blackboard, column_to_replace, to_export, unique_colnames);'

echo Done
