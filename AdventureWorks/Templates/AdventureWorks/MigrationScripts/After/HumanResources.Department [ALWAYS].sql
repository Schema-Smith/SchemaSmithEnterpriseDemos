DECLARE @data VARCHAR(MAX) = '{{HumanResourcesDepartmentData}}'

MERGE INTO HumanResources.Department AS Target
USING (
    SELECT *
    FROM OPENJSON(@data)
    WITH (
        DepartmentID smallint,
        Name nvarchar(50),
        GroupName nvarchar(50),
        ModifiedDate datetime
    )
) AS Source
ON Target.DepartmentID = Source.DepartmentID
WHEN MATCHED THEN
    UPDATE SET
        Name = Source.Name,
        GroupName = Source.GroupName,
        ModifiedDate = Source.ModifiedDate
WHEN NOT MATCHED THEN
    INSERT (Name, GroupName, ModifiedDate)
    VALUES (Source.Name, Source.GroupName, Source.ModifiedDate);