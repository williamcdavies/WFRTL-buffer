#!/bin/bash

# Usage: `sh q.sh <buffer_distance_in_meters>`

for year in $(seq 2024 -1 1984); do
    echo "Processing year $year on buffer distance $1 …"

    # Script 1: compute lakes with overlap
    sed -e "s/{{YEAR}}/$year/g" \
        -e "s/{{BUFFER_DISTANCE}}/$1/g" \
        trueq.sql | psql -d spatial -o "fire_buffer_over_lake_poly${year}_${1}_overlap_true.csv"

    # Script 2: compute lakes without overlap
    sed -e "s/{{YEAR}}/$year/g" \
        -e "s/{{BUFFER_DISTANCE}}/$1/g" \
        falseq.sql | psql -d spatial -o "fire_buffer_over_lake_poly${year}_${1}_overlap_false.csv"

    # Concatenate with TRUE rows first
    cat "fire_buffer_over_lake_poly${year}_${1}_overlap_true.csv" \
        <(tail -n +2 "fire_buffer_over_lake_poly${year}_${1}_overlap_false.csv") \
        > "fire_buffer_over_lake_poly${year}_${1}.csv"

    echo "Completed year $year on buffer distance $1."
done