ALTER TABLE 
    fire_area_canada_usa
ADD IF NOT EXISTS
    buffer_geometry_{{BUFFER_DISTANCE}} geometry(Geometry,3978);