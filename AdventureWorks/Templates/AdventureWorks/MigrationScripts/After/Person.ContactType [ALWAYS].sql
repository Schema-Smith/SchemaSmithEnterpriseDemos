DECLARE @data VARCHAR(MAX) = '{{PersonContactTypeData}}'

MERGE INTO Person.ContactType AS Target
USING (
    SELECT *
    FROM OPENJSON(@data)
    WITH (
        ContactTypeID int,
        Name nvarchar(50),
        ModifiedDate datetime
    )
) AS Source
ON Target.ContactTypeID = Source.ContactTypeID
WHEN MATCHED THEN
    UPDATE SET
        Name = Source.Name,
        ModifiedDate = Source.ModifiedDate
WHEN NOT MATCHED THEN
    INSERT (Name, ModifiedDate)
    VALUES (Source.Name, Source.ModifiedDate);