#!/bin/bash

# BSB: blackboard-scantron-bridge

R --quiet -e 'source("lib/R/helpers.R"); cmd_spreadsheet()'

echo Done
