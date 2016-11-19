#!/bin/bash

curl -s http://$2:8090/druid/indexer/v1/completeTasks \
| python -c "import sys, json
data = \"\"
try:
  data = json.load(sys.stdin)
except ValueError, e:
  print \"OVERLORD Down!  Investigate.\"
  sys.exit(2)
resultArray = []
for entry in data:
  if entry['statusCode'] != \"SUCCESS\":
    resultArray.append(entry)
if len(resultArray) > 0:
  print \"INGESTION ERRORS - \" + len(resultArray) + \"!\"
  sys.exit(2)
else:
  print \"ALL INGESTION TASKS GOOD! 'http://$2:8090/druid/indexer/v1/completeTasks'\"
  sys.exit(0)"
