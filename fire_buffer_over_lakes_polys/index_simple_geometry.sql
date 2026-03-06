CREATE INDEX 
    idx_fire_area_canada_usa{{YEAR}}_simple_geometry 
ON 
    fire_area_canada_usa{{YEAR}} 
USING 
    GIST (simple_geometry);