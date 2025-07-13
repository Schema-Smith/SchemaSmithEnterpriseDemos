DECLARE @data VARCHAR(MAX) = '{{PurchasingShipMethodData}}'

MERGE INTO Purchasing.ShipMethod AS Target
USING (
    SELECT *
    FROM OPENJSON(@data)
    WITH (
        ShipMethodID int,
        Name nvarchar(50),
        ShipBase money,
        ShipRate money,
        rowguid uniqueidentifier,
        ModifiedDate datetime
    )
) AS Source
ON Target.ShipMethodID = Source.ShipMethodID
WHEN MATCHED THEN
    UPDATE SET
        Name = Source.Name,
        ShipBase = Source.ShipBase,
        ShipRate = Source.ShipRate,
        rowguid = Source.rowguid,
        ModifiedDate = Source.ModifiedDate
WHEN NOT MATCHED THEN
    INSERT (Name, ShipBase, ShipRate, rowguid, ModifiedDate)
    VALUES (Source.Name, Source.ShipBase, Source.ShipRate, Source.rowguid, Source.ModifiedDate);
    