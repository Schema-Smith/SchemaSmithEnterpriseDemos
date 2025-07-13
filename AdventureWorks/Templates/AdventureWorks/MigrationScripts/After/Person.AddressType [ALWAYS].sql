DECLARE @data VARCHAR(MAX) = '{{PersonAddressTypeData}}'

MERGE INTO Person.AddressType AS Target
USING (
    SELECT *
    FROM OPENJSON(@data)
    WITH (
        AddressTypeID int,
        Name nvarchar(50),
        rowguid uniqueidentifier,
        ModifiedDate datetime
    )
) AS Source
ON Target.AddressTypeID = Source.AddressTypeID
WHEN MATCHED THEN
    UPDATE SET
        Name = Source.Name,
        rowguid = Source.rowguid,
        ModifiedDate = Source.ModifiedDate
WHEN NOT MATCHED THEN
    INSERT (Name, rowguid, ModifiedDate)
    VALUES (Source.Name, Source.rowguid, Source.ModifiedDate);
