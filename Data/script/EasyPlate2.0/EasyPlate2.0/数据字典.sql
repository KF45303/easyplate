SELECT * FROM vw_SysDataList
--民族
SELECT DataListGUID, SysDataName FROM vw_SysDataList WHERE ParentDataListGUID = '{293DBCA9-2B26-4685-A2CF-DF9FBF351994}' ORDER BY OrderNo
--性别
SELECT DataListGUID, SysDataName FROM vw_SysDataList WHERE ParentDataListGUID = '{00000000-0000-0000-0000-000000000001}' ORDER BY OrderNo
--婚姻状况
SELECT DataListGUID, SysDataName FROM vw_SysDataList WHERE ParentDataListGUID = '{C256574A-4CE2-4193-B950-F163F0D20CF4}' ORDER BY OrderNo
--血型
SELECT DataListGUID, SysDataName FROM vw_SysDataList WHERE ParentDataListGUID = '{00000000-0000-0000-0000-000000000002}' ORDER BY OrderNo
--政治面貌
SELECT DataListGUID, SysDataName FROM vw_SysDataList WHERE ParentDataListGUID = '{9120DFDD-56F4-4EE8-9CAD-9D6BE534ECF5}' ORDER BY OrderNo
{40CB5AD0-41E9-4DAE-998B-FA0A53DC9B59}

--{4A0E4082-18BE-4A80-B6EC-27E99B1DD850}
--学历
SELECT DataListGUID, SysDataName FROM vw_SysDataList WHERE ParentDataListGUID = '{4A0E4082-18BE-4A80-B6EC-27E99B1DD850}' ORDER BY OrderNo

--员工类型
SELECT DataListGUID, SysDataName FROM vw_SysDataList WHERE ParentDataListGUID = '{40CB5AD0-41E9-4DAE-998B-FA0A53DC9B59}' ORDER BY OrderNo

--在职状态
SELECT DataListGUID, SysDataName FROM vw_SysDataList WHERE ParentDataListGUID = '{D15F165A-31D4-4D9C-A441-6C3D71258DF0}' ORDER BY OrderNo

--{7184C59A-75BB-4EB6-A3D7-21D81D5F94DD}
--户口类型
SELECT DataListGUID, SysDataName FROM vw_SysDataList WHERE ParentDataListGUID = '{7184C59A-75BB-4EB6-A3D7-21D81D5F94DD}' ORDER BY OrderNo

--职称
SELECT DataListGUID, SysDataName FROM vw_SysDataList WHERE ParentDataListGUID = '{C5FFE21A-D7BE-4F37-9EA5-35161816AD53}' ORDER BY OrderNo
--计算机水平
SELECT DataListGUID, SysDataName FROM vw_SysDataList WHERE ParentDataListGUID = '{2F9E89C3-1445-4B76-97F6-9B709DF4C3A5}' ORDER BY OrderNo
--外语水平
SELECT DataListGUID, SysDataName FROM vw_SysDataList WHERE ParentDataListGUID = '{729AAB66-16F7-4863-A554-B1ECE891B405}' ORDER BY OrderNo
