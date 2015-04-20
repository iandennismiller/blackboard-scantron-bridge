#!/bin/bash

# BSB: blackboard-scantron-bridge

R --quiet -e 'source("lib/R/helpers.R"); source("R/loading.R"); source("R/students.R"); evaluate(scantrons, blackboard);'

echo Done
