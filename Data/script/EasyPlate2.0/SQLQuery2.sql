SELECT * FROM sysUser

SELECT * FROM infCompany WHERE CompanyGUID = ''
SELECT * FROM infCompanyDept WHERE DeptGUID = ''
SELECT * FROM infDeptPostion WHERE PostGUID = ''

SELECT * FROM hrEmployee WHERE EmployeeGUID = '{00000000-0000-0000-0000-000000000002}'
SELECT * FROM infCompanyDept WHERE DeptGUID = '{00000000-0000-0000-0000-000000000000}'

SELECT * FROM sysPluginsDirectory
SELECT * FROM sysUser_Resource

SELECT * FROM sysResource

SELECT * FROM infDeptPostion

{39B9F54B-00C5-4DD3-B4B6-8FEAE774619A}

SELECT * FROM sysUser

SELECT * FROM hrEmployee

UPDATE hrEmployee SET PositionGUID = '{39B9F54B-00C5-4DD3-B4B6-8FEAE774619A}'
UPDATE hrEmployee SET DepartmentGUID = '{75CCB79B-C666-4D81-9A79-0510666B79EB}'
SELECT * FROM vw_inituser
 SELECT * FROM sysUser WHERE UserGUID = '{00000000-0000-0000-0000-000000000000}'
  SELECT * FROM hrEmployee WHERE EmployeeGUID = '{00000000-0000-0000-0000-000000000002}'
  SELECT * FROM infCompany WHERE CompanyGUID = '{00000000-0000-0000-0000-000000000000}'
  SELECT * FROM infCompanyDept WHERE DeptGUID = '{00000000-0000-0000-0000-000000000000}'
  
  SELECT DISTINCT FormID, ControlID, FileName FROM 
  (
 SELECT A.*, B.FormID, B.ControlID, C.FileName FROM vwSysUser_Resource A 
 LEFT JOIN sysResource B ON A.ResourceGUID = B.ResourceGUID 
 LEFT JOIN sysFormInfo C ON B.FormID = C.FormGUID
 WHERE UserGUID = '{00000000-0000-0000-0000-000000000000}'
 UNION ALL 	
 SELECT A.*, B.FormID, B.ControlID, C.FileName FROM vwSysRole_Resource A 
 LEFT JOIN sysResource B ON A.ResourceGUID = B.ResourceGUID 
 LEFT JOIN sysFormInfo C ON B.FormID = C.FormGUID
 WHERE RoleGUID IN ('{00000000-0000-0000-0000-000000000002}')
 ) AA WHERE UserGUID = '{00000000-0000-0000-0000-000000000002}'
 
 SELECT * FROM sysRole
 {150634CA-B5B7-48B9-A420-CD1196B64103}
 
 SELECT * FROM sysUser
 
 UPDATE sysUser SET RoleGUID = '{150634CA-B5B7-48B9-A420-CD1196B64103}'
 
 SELECT * FROM sysRole
 
 SELECT DISTINCT FormID, ControlID FROM  (  SELECT A.*, B.FormID, B.ControlID FROM vwSysUser_Resource A  LEFT JOIN sysResource B ON A.ResourceGUID = B.ResourceGUID WHERE UserGUID = '{00000000-0000-0000-0000-000000000000}' UNION ALL  SELECT A.*, B.FormID, B.ControlID FROM vwSysRole_Resource A  LEFT JOIN sysResource B ON A.ResourceGUID = B.ResourceGUID  WHERE RoleGUID IN ('{150634CA-B5B7-48B9-A420-CD1196B64103}','{00000000-0000-0000-0000-000000000002}')  ) AA WHERE UserGUID = '{00000000-0000-0000-0000-000000000000}'
 SELECT * FROM sysForm
 
 select ParentPluginGUID, * from sysPluginsDirectory WHERE PluginCName LIKE '%Test%'
 
 {A85773FF-D9B1-46D3-9BB2-469B5D3D0074}
 
 SELECT *, IsDirectory FROM sysPluginsDirectory where ParentPluginGUID = '{A85773FF-D9B1-46D3-9BB2-469B5D3D0074}'
 SELECT * FROM sysPluginsDirectory where ParentPluginGUID = '{233C3D9C-E7E1-4146-8645-7226BA0B817C}'
 
 SELECT * FROM sysPluginsDirectory where ParentPluginGUID = '{00000000-0000-0000-0000-000000000000}'
 
 UPDATE 
 
 SELECT * FROM sysUser
 
 UPDATE sysUser SET PassWord = WHERE UserGUID = ''
 