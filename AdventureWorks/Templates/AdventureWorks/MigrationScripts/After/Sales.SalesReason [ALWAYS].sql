DECLARE @data VARCHAR(MAX) = '{{SalesSalesReasonData}}'

MERGE INTO Sales.SalesReason AS Target
USING (
    SELECT *
    FROM OPENJSON(@data)
    WITH (
        SalesReasonID int,
        Name nvarchar(50),
        ReasonType nvarchar(50),
        ModifiedDate datetime
    )
) AS Source
ON Target.SalesReasonID = Source.SalesReasonID
WHEN MATCHED THEN
    UPDATE SET
        Name = Source.Name,
        ReasonType = Source.ReasonType,
        ModifiedDate = Source.ModifiedDate
WHEN NOT MATCHED THEN
    INSERT (Name, ReasonType, ModifiedDate)
    VALUES (Source.Name, Source.ReasonType, Source.ModifiedDate);
    