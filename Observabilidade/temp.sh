#!/bin/bash

FILE="cloudwatch.md"

SEARCH_STRING="images/"
REPLACE_STRING="cloudwatch-images/"

if [ -f "$FILE" ]; then
    echo "Processing file: $FILE"
    
    sed -i "s|$SEARCH_STRING|$REPLACE_STRING|g" "$FILE"

    if [ $? -eq 0 ]; then
        echo "Replacement successful."
        echo "All occurrences of \"$SEARCH_STRING\" have been replaced with \"$REPLACE_STRING\" in $FILE."
    else
        echo "An error occurred during the 'sed' operation."
    fi
else
    echo "Error: File '$FILE' not found."
    echo "Please ensure the file exists in the current directory."
fi
