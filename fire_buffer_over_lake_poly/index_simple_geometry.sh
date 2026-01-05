#!/bin/bash

for year in $(seq 2024 -1 1984); do
    echo "Creating index idx_fire_canada_usa${year}_simple_geometry …"
    
    # Scan and replace {{YEAR}} with $year in corresponding .sql file and execute.
    sed "s/{{YEAR}}/$year/g" index_simple_geometry.sql | psql -d spatial

    echo "Done."
done