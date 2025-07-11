/*
Sales.Customer.AccountNumber depends on this function and is a computed expression that uses this function and is also in a unique index.
Remove the index and the computed column before dropping the function.  
*/
DROP INDEX IF EXISTS AK_Customer_AccountNumber ON Sales.Customer
GO

IF EXISTS( SELECT *
            FROM INFORMATION_SCHEMA.COLUMNS
           WHERE TABLE_SCHEMA = 'Sales'
             AND TABLE_NAME = 'Customer'
             AND COLUMN_NAME = 'AccountNumber')
  ALTER TABLE Sales.Customer DROP COLUMN AccountNumber
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER FUNCTION [dbo].[ufnLeadingZeros](
    @Value int
) 
RETURNS varchar(8) 
WITH SCHEMABINDING 
AS 

BEGIN
    DECLARE @ReturnValue varchar(8);

    SET @ReturnValue = CONVERT(varchar(8), @Value);
    SET @ReturnValue = REPLICATE('0', 8 - DATALENGTH(@ReturnValue)) + @ReturnValue;

    RETURN (@ReturnValue);
END;

GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'FUNCTION',N'ufnLeadingZeros', NULL,NULL))
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Scalar function used by the Sales.Customer table to help set the account number.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'ufnLeadingZeros'
ELSE
BEGIN
	EXEC sys.sp_updateextendedproperty @name=N'MS_Description', @value=N'Scalar function used by the Sales.Customer table to help set the account number.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'ufnLeadingZeros'
END

GO