DECLARE @data VARCHAR(MAX) = '{{ProductionCultureData}}'

MERGE INTO Production.Culture AS Target
USING (
    SELECT *
    FROM OPENJSON(@data)
    WITH (
        CultureID nchar(6),
        Name nvarchar(50),
        ModifiedDate datetime
    )
) AS Source
ON Target.CultureID = Source.CultureID
WHEN MATCHED THEN
    UPDATE SET
        Name = Source.Name,
        ModifiedDate = Source.ModifiedDate
WHEN NOT MATCHED THEN
    INSERT (CultureID, Name, ModifiedDate)
    VALUES (Source.CultureID, Source.Name, Source.ModifiedDate);
    