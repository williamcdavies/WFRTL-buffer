CREATE INDEX IF NOT EXISTS
    idx_fire_area_canada_usa{{YEAR}}_buffer_geometry_{{BUFFER_DISTANCE}}
ON
    fire_area_canada_usa{{YEAR}}
USING 
    GIST ("buffer_geometry_{{BUFFER_DISTANCE}}");

UPDATE 
    fire_area_canada_usa{{YEAR}}
SET 
    buffer_geometry_{{BUFFER_DISTANCE}} = ST_Buffer(simple_geometry, {{BUFFER_DISTANCE}});