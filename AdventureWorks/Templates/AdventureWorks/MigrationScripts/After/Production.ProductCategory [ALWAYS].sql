DECLARE @data VARCHAR(MAX) = '{{ProductionProductCategoryData}}'

MERGE INTO Production.ProductCategory AS Target
USING (
    SELECT *
    FROM OPENJSON(@data)
    WITH (
        ProductCategoryID int,
        Name nvarchar(50),
        rowguid uniqueidentifier,
        ModifiedDate datetime
    )
) AS Source
ON Target.ProductCategoryID = Source.ProductCategoryID
WHEN MATCHED THEN
    UPDATE SET
        Name = Source.Name,
        rowguid = Source.rowguid,
        ModifiedDate = Source.ModifiedDate
WHEN NOT MATCHED THEN
    INSERT (Name, rowguid, ModifiedDate)
    VALUES (Source.Name, Source.rowguid, Source.ModifiedDate);
    