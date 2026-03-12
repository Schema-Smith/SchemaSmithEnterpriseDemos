-- This function references a view that may not exist yet
-- Used to test retry logic for dependent objects
INSERT INTO `SchemaSmith_TestLog` (Msg) VALUES('FunctionThatNeedsView.sql');
