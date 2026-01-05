#!/bin/bash

# Usage: `sh buffer.sh <buffer_distance>`

# $buffer_distance=10000  #10_000
# $buffer_distance=40000  #40_000
# $buffer_distance=100000 #100_000

echo "Updating fire_area_canada_usa with buffer of distance $1 m …"

sed "s/{{BUFFER_DISTANCE}}/$1/g" buffer_parent.sql | psql -d spatial

for year in $(seq 2024 -1 1984); do
    echo "Updating fire_area_canada_usa$year with buffer of distance $1 m …"

    sed -e "s/{{BUFFER_DISTANCE}}/$1/g" \
        -e "s/{{YEAR}}/$year/g" \
        buffer_children.sql | psql -d spatial
    
    echo "Done."
done