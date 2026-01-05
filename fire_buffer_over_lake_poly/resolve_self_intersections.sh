#!/bin/bash

for year in $(seq 2024 -1 1984); do
    echo "Resolving self-intersections for table fire_area_canada_usa$year …"
    
    # Scan and replace {{YEAR}} with $year in corresponding .sql file and execute.
    sed "s/{{YEAR}}/$year/g" resolve_self_intersections.sql | psql -d spatial

    echo "Done."
done