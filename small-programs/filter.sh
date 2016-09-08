#!/bin/bash
#
# - author: Jesus Orduna
#
# - important: Produce a list of CADI lines from the CMS publications
#              found on the publicly available page:
#              http://cds.cern.ch/search?cc=CMS+Papers
#

theFile="~/Downloads/results.xls"
theHTMLResults="results.html"
theFilteredHTMLColumns="importantColumns.html"

function checkForFile {
    waitForFile=1
    while [ $waitForFile -gt 0 ] ; do
        echo "Waiting for file to be downloaded..."
        if [ -e "$theFile" ] ; then
            echo "$theFile downloaded."
            let waitForFile=waitForFile-1
        fi
        sleep 5s
    done
    grep tr $theFile >> $theHTMLResults
    rm $theFile
}

rm -f $theHTMLResults

# Get first 100 publications
echo "Getting first 100 publications"
open -g "http://cds.cern.ch/search?cc=CMS+Papers&ln=en&rg=100&of=excel"
checkForFile

# Get publications 101-200
echo "Getting publications 101-200"
open -g "http://cds.cern.ch/search?cc=CMS+Papers&ln=en&rg=100&of=excel&jrec=101"
checkForFile

# Get publications 201-300
echo "Getting publications 201-300"
open -g "http://cds.cern.ch/search?cc=CMS+Papers&ln=en&rg=100&of=excel&jrec=201"
checkForFile

# Get publications 301-400
echo "Getting publications 301-400"
open -g "http://cds.cern.ch/search?cc=CMS+Papers&ln=en&rg=100&of=excel&jrec=301"
checkForFile

# Get publications 401 and after.
# Check if there are more than 500 publications and modify accordingly
echo "Getting last batch of publications"
open -g "http://cds.cern.ch/search?cc=CMS+Papers&ln=en&rg=100&of=excel&jrec=401"
checkForFile

echo "<table>" > $theFilteredHTMLColumns
grep \<tr $theHTMLResults | awk -F "<td>" '{ print $1 "\<td\>" $2 "\<td\>" $3 "\<td\>" $7 "\<td\>" $12}' >> $theFilteredHTMLColumns

grep \<tr $theHTMLResults | awk -F "<td>" '{ print $2}' | awk -F "CMS-" '{ print $2}' | cut -c1-10 | sort -u | sort -g -t '-' -k2,2 > publications.txt
more publications.txt
