DECLARE @data VARCHAR(MAX) = '{{ProductionUnitMeasureData}}'

MERGE INTO Production.UnitMeasure AS Target
USING (
    SELECT *
    FROM OPENJSON(@data)
    WITH (
        UnitMeasureCode nchar(3),
        Name nvarchar(50),
        ModifiedDate datetime
    )
) AS Source
ON Target.UnitMeasureCode = Source.UnitMeasureCode
WHEN MATCHED THEN
    UPDATE SET
        Name = Source.Name,
        ModifiedDate = Source.ModifiedDate
WHEN NOT MATCHED THEN
    INSERT (UnitMeasureCode, Name, ModifiedDate)
    VALUES (Source.UnitMeasureCode, Source.Name, Source.ModifiedDate);
    
    