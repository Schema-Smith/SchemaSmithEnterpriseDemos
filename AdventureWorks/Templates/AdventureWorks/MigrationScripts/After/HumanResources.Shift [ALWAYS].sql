DECLARE @data VARCHAR(MAX) = '{{HumanResourcesShiftData}}'

MERGE INTO HumanResources.Shift AS Target
USING (
    SELECT *
    FROM OPENJSON(@data)
    WITH (
        ShiftID int,
        Name nvarchar(50),
        StartTime time(7),
        EndTime time(7),
        ModifiedDate datetime
    )
) AS Source
ON Target.ShiftID = Source.ShiftID
WHEN MATCHED THEN
    UPDATE SET
        Name = Source.Name,
        StartTime = Source.StartTime,
        EndTime = Source.EndTime,
        ModifiedDate = Source.ModifiedDate
WHEN NOT MATCHED THEN
    INSERT (Name, StartTime, EndTime, ModifiedDate)
    VALUES (Source.Name, Source.StartTime, Source.EndTime, Source.ModifiedDate);

