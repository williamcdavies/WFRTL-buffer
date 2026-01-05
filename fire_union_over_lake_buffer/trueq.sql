COPY (
WITH lp_filtered AS (
    SELECT
        lp."Hylak_id",
        l."Lake_name",
        l."Country",
        l."Pour_long",
        l."Pour_lat",
        lp.buffer_geometry,
        fu.geometry,
        ST_Intersection(lp.buffer_geometry, fu.geometry) AS intersection_geometry,
        ST_Area(lp.buffer_geometry) AS buffer_area
    FROM lakes_polys_3978 AS lp
    JOIN public.lakes AS l USING ("Hylak_id")
    JOIN public.fire_area_canada_usa_unions AS fu ON fu.year = {{YEAR}}
    WHERE ST_Intersects(lp.buffer_geometry, fu.geometry)
)
SELECT
    "Hylak_id",
    "Lake_name",
    "Country",
    "Pour_long",
    "Pour_lat",
    ST_Area(intersection_geometry) / NULLIF(buffer_area, 0) AS buffer_overlap_percentage,
    (ST_Area(intersection_geometry) / NULLIF(buffer_area, 0) > 0) AS buffer_overlap
FROM lp_filtered
ORDER BY buffer_overlap_percentage DESC
) TO STDOUT WITH CSV HEADER;