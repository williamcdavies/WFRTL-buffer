#!/bin/bash

# Usage: `sh union.sh <buffer_distance>`

for year in $(seq 2024 -1 1984); do
    echo "Computing and inserting union for year $year …"
    
    sed -e "s/{{BUFFER_DISTANCE}}/$1/g" \
        -e "s/{{YEAR}}/$year/g" \
        union.sql | psql -d spatial

    echo "Done."
done