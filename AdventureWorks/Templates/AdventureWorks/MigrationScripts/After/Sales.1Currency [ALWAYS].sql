DECLARE @data VARCHAR(MAX) = '{{SalesCurrencyData}}'

MERGE INTO Sales.Currency AS Target
USING (
    SELECT *
    FROM OPENJSON(@data)
    WITH (
        CurrencyCode nchar(3),
        Name nvarchar(50),
        ModifiedDate datetime
    )
) AS Source
ON Target.CurrencyCode = Source.CurrencyCode
WHEN MATCHED THEN
    UPDATE SET
        Name = Source.Name,
        ModifiedDate = Source.ModifiedDate
WHEN NOT MATCHED THEN
    INSERT (CurrencyCode, Name, ModifiedDate)
    VALUES (Source.CurrencyCode, Source.Name, Source.ModifiedDate);
    