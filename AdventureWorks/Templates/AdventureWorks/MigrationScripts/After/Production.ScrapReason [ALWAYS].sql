DECLARE @data VARCHAR(MAX) = '{{ProductionScrapReasonData}}'

MERGE INTO Production.ScrapReason AS Target
USING (
    SELECT *
    FROM OPENJSON(@data)
    WITH (
        ScrapReasonID smallint,
        Name nvarchar(50),
        ModifiedDate datetime
    )
) AS Source
ON Target.ScrapReasonID = Source.ScrapReasonID
WHEN MATCHED THEN
    UPDATE SET
        Name = Source.Name,
        ModifiedDate = Source.ModifiedDate
WHEN NOT MATCHED THEN
    INSERT (Name, ModifiedDate)
    VALUES (Source.Name, Source.ModifiedDate);
    