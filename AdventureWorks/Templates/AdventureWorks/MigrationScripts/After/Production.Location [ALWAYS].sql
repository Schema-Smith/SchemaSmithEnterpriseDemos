DECLARE @data VARCHAR(MAX) = '{{ProductionLocationData}}'

MERGE INTO Production.Location AS Target
USING (
    SELECT *
    FROM OPENJSON(@data)
    WITH (
        LocationID smallint,
        Name nvarchar(50),
        CostRate decimal(10,2),
        Availability decimal(8,2),
        ModifiedDate datetime
    )
) AS Source
ON Target.LocationID = Source.LocationID
WHEN MATCHED THEN
    UPDATE SET
        Name = Source.Name,
        CostRate = Source.CostRate,
        Availability = Source.Availability,
        ModifiedDate = Source.ModifiedDate
WHEN NOT MATCHED THEN
    INSERT (Name, CostRate, Availability, ModifiedDate)
    VALUES (Source.Name, Source.CostRate, Source.Availability, Source.ModifiedDate);

