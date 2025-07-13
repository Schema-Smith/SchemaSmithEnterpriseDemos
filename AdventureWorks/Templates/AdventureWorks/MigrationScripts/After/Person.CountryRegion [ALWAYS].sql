DECLARE @data VARCHAR(MAX) = '{{PersonCountryRegionData}}'

MERGE INTO Person.CountryRegion AS Target
USING (
    SELECT *
    FROM OPENJSON(@data)
    WITH (
        CountryRegionCode nvarchar(3),
        Name nvarchar(50),
        ModifiedDate datetime
    )
) AS Source
ON Target.CountryRegionCode = Source.CountryRegionCode
WHEN MATCHED THEN
    UPDATE SET
        Name = Source.Name,
        ModifiedDate = Source.ModifiedDate
WHEN NOT MATCHED THEN
    INSERT (CountryRegionCode, Name, ModifiedDate)
    VALUES (Source.CountryRegionCode, Source.Name, Source.ModifiedDate);