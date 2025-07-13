DECLARE @data VARCHAR(MAX) = '{{ProductionProductSubcategoryData}}'

MERGE INTO Production.ProductSubcategory AS Target
USING (
    SELECT *
    FROM OPENJSON(@data)
    WITH (
        ProductSubcategoryID int,
        ProductCategoryID int,
        Name nvarchar(50),
        rowguid uniqueidentifier,
        ModifiedDate datetime
    )
) AS Source
ON Target.ProductSubcategoryID = Source.ProductSubcategoryID
WHEN MATCHED THEN
    UPDATE SET
        ProductCategoryID = Source.ProductCategoryID,
        Name = Source.Name,
        rowguid = Source.rowguid,
        ModifiedDate = Source.ModifiedDate
WHEN NOT MATCHED THEN
    INSERT (ProductCategoryID, Name, rowguid, ModifiedDate)
    VALUES (Source.ProductCategoryID, Source.Name, Source.rowguid, Source.ModifiedDate);
    