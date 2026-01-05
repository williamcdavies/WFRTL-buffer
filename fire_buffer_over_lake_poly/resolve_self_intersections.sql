UPDATE 
    fire_area_canada_usa{{YEAR}}
SET 
    simple_geometry = ST_MakeValid(simple_geometry)
WHERE NOT 
    ST_IsValid(simple_geometry);