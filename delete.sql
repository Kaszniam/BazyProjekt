DECLARE @Sql NVARCHAR(500) DECLARE @Cursor CURSOR

SET @Cursor = CURSOR FAST_FORWARD FOR
SELECT DISTINCT sql = 'ALTER TABLE [' + tc2.TABLE_NAME + '] DROP [' + rc1.CONSTRAINT_NAME + ']'
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS rc1
LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc2 ON tc2.CONSTRAINT_NAME =rc1.CONSTRAINT_NAME

OPEN @Cursor FETCH NEXT FROM @Cursor INTO @Sql

WHILE (@@FETCH_STATUS = 0)
BEGIN
Exec SP_EXECUTESQL @Sql
FETCH NEXT FROM @Cursor INTO @Sql
END

CLOSE @Cursor DEALLOCATE @Cursor
GO

--Procedures

EXEC sp_MSForEachTable 'DROP TABLE ?'
GO

declare @procName varchar(500)
declare cur cursor 

for select [name] from sys.objects where type = 'p'
open cur
fetch next from cur into @procName
while @@fetch_status = 0
begin
    exec('drop procedure [' + @procName + ']')
    fetch next from cur into @procName
end
close cur
deallocate cur

--Triggers

DECLARE @SQLCmd nvarchar(1000) 
DECLARE @Trig varchar(500)
DECLARE @sch varchar(500)

DECLARE TGCursor CURSOR FOR

SELECT ISNULL(tbl.name, vue.name) AS [schemaName]
     , trg.name AS triggerName
FROM sys.triggers trg
LEFT OUTER JOIN (SELECT tparent.object_id, ts.name 
                 FROM sys.tables tparent 
                 INNER JOIN sys.schemas ts ON TS.schema_id = tparent.SCHEMA_ID) 
                 AS tbl ON tbl.OBJECT_ID = trg.parent_id
LEFT OUTER JOIN (SELECT vparent.object_id, vs.name 
                 FROM sys.views vparent 
                 INNER JOIN sys.schemas vs ON vs.schema_id = vparent.SCHEMA_ID) 
                 AS vue ON vue.OBJECT_ID = trg.parent_id
 
OPEN TGCursor
FETCH NEXT FROM TGCursor INTO @sch,@Trig
WHILE @@FETCH_STATUS = 0
BEGIN

SET @SQLCmd = N'DROP TRIGGER [' + @sch + '].[' + @Trig + ']'
EXEC sp_executesql @SQLCmd
PRINT @SQLCmd

FETCH next FROM TGCursor INTO @sch,@Trig
END

CLOSE TGCursor
DEALLOCATE TGCursor

--Views

DECLARE @sql VARCHAR(MAX) = ''
        , @crlf VARCHAR(2) = CHAR(13) + CHAR(10) ;

SELECT @sql = @sql + 'DROP VIEW ' + QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(v.name) +';' + @crlf
FROM   sys.views v

PRINT @sql;
EXEC(@sql);