WITH SplitData AS (
    SELECT
        Postleitzah,
        Bezirk,
        'under_6' AS age_range,
        `unter 6` AS population
    FROM final
    UNION ALL
    SELECT
        Postleitzah,
        Bezirk,
        '6_to_15' AS age_range,
        `6 - 15` AS population
    FROM final
    -- Include similar blocks for other age ranges
    -- ...
    UNION ALL
    SELECT
        Postleitzah,
        Bezirk,
        '65_and_above' AS age_range,
        `65 und
mehr` AS population
    FROM final
),
JoinedData AS (
    SELECT
        sd.Postleitzah,
        sd.Bezirk,
        sd.age_range,
        sd.population,
        f.`Darunter
weiblich`
    FROM SplitData sd
    JOIN final f ON sd.Postleitzah = f.Postleitzah AND sd.Bezirk = f.Bezirk
)
SELECT * FROM JoinedData;

-- Create a CTE to format the Markdown content
WITH ReadmeContent AS (
    SELECT
        '# Postal Code Districts Population Dataset' AS line
    UNION ALL
    SELECT
        '## Overview' AS line
    UNION ALL
    SELECT
        'This dataset provides population statistics for various age ranges within different postal code districts (Postleitzahl) and their corresponding districts (Bezirk). The dataset includes demographic information such as total population and population counts for specific age ranges, along with gender-specific data.' AS line
    -- Add more content sections as needed
)
-- Concatenate the lines and generate Markdown content
SELECT GROUP_CONCAT(line SEPARATOR '\n') AS readme_content
FROM ReadmeContent;



