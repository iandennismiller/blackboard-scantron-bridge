#!/bin/bash

# BSB: blackboard-scantron-bridge

R --quiet -e 'source("lib/R/helpers.R"); source("R/loading.R"); dimensions(blackboard, scantrons);'

echo Done
