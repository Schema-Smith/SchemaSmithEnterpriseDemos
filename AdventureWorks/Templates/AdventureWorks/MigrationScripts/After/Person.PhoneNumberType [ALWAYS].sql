DECLARE @data VARCHAR(MAX) = '{{PersonPhoneNumberTypeData}}'

MERGE INTO Person.PhoneNumberType AS Target
USING (
    SELECT *
    FROM OPENJSON(@data)
    WITH (
        PhoneNumberTypeID int,
        Name nvarchar(50),
        ModifiedDate datetime
    )
) AS Source
ON Target.PhoneNumberTypeID = Source.PhoneNumberTypeID
WHEN MATCHED THEN
    UPDATE SET
        Name = Source.Name,
        ModifiedDate = Source.ModifiedDate
WHEN NOT MATCHED THEN
    INSERT (Name, ModifiedDate)
    VALUES (Source.Name, Source.ModifiedDate);