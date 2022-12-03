$csv = import-csv ./data.csv -Delimiter "," -Encoding utf8


convertto-json $csv
