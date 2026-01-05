COPY (
WITH lp_filtered AS (
    SELECT
        lp."Hylak_id",
        l."Lake_name",
        l."Country",
        l."Pour_long",
        l."Pour_lat",
        u.geometry,
        lp."3978_geometry"
    FROM public.lakes_polys AS lp
    JOIN public.lakes AS l USING ("Hylak_id")
    JOIN public.fire_area_canada_usa_unions_{{BUFFER_DISTANCE}} AS u ON u.year = {{YEAR}}
    WHERE NOT ST_Intersects(lp."3978_geometry", u.geometry)
)
SELECT
    "Hylak_id",
    "Lake_name",
    "Country",
    "Pour_long",
    "Pour_lat",
    0 AS buffer_overlap_percentage,
    FALSE AS buffer_overlap
FROM lp_filtered
ORDER BY "Hylak_id"
) TO STDOUT WITH CSV HEADER;