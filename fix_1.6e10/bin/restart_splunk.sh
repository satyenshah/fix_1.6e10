#!/bin/bash
echo "Just restarting splunk" 2>&1 | logger &
/opt/splunkforwarder/bin/splunk restart 2>&1 | logger &
sleep 10s
echo "Just restarted splunk" 2>&1 | logger &



