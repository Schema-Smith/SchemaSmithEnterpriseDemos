DECLARE @data VARCHAR(MAX) = '{{SalesCountryRegionCurrencyData}}'

MERGE INTO Sales.CountryRegionCurrency AS Target
USING (
    SELECT *
    FROM OPENJSON(@data)
    WITH (
        CountryRegionCode nvarchar(3),
        CurrencyCode nchar(3),
        ModifiedDate datetime
    )
) AS Source
ON Target.CountryRegionCode = Source.CountryRegionCode 
   AND Target.CurrencyCode = Source.CurrencyCode
WHEN MATCHED THEN
    UPDATE SET
        ModifiedDate = Source.ModifiedDate
WHEN NOT MATCHED THEN
    INSERT (CountryRegionCode, CurrencyCode, ModifiedDate)
    VALUES (Source.CountryRegionCode, Source.CurrencyCode, Source.ModifiedDate);
    