#!/bin/bash

# BSB: blackboard-scantron-bridge

R --quiet -e 'source("lib/R/helpers.R"); source("R/loading.R"); source("R/students.R"); missing_exams(scantrons, blackboard); find_entry_errors(scantrons, blackboard);'

echo Done
