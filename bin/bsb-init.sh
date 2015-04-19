#!/bin/bash

# BSB: blackboard-scantron-bridge

mkdir marking
mrbob -O marking ${VIRTUAL_ENV}/lib/python2.7/site-packages/blackboard_scantron_bridge-0.1-py2.7.egg/bsb/skel
cd marking

echo Done
