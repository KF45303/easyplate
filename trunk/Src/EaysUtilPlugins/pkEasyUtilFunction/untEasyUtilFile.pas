{-------------------------------------------------------------------------------
//                       EasyComponents For Delphi 7
//                         һ�����е�����������                         
//                         @Copyright 2010 hehf                      
//                   ------------------------------------                       
//                                                                              
//           ���������ǹ�˾�ڲ�ʹ��,��Ϊ��������ʹ���κ�,�κ�����˸��𿪷�,�κ�
//       �˲�����й,�������Ը�.        
//
//            ʹ��Ȩ���Լ���ؽ�������ϵ�κ���  
//                
//                                                               
//            ��վ��ַ��http://www.YiXuan-SoftWare.com                                  
//            �����ʼ���hehaifeng1984@126.com 
//                      YiXuan-SoftWare@hotmail.com    
//            QQ      ��383530895
//            MSN     ��YiXuan-SoftWare@hotmail.com                                   
//------------------------------------------------------------------------------
//��Ԫ˵����
//
//��Ҫʵ�֣�
//-----------------------------------------------------------------------------}
unit untEasyUtilFile;

interface

uses
  Windows, Messages, SysUtils, Classes, ShellAPI, ZLib;

type
  TFileVersionInfomation = record // �ļ��汾��Ϣ
    rCommpanyName: string;
    rFileDescription: string;
    rFileVersion: string;
    rInternalName: string;
    rLegalCopyright: string;
    rLegalTrademarks: string;
    rOriginalFileName: string;
    rProductName: string;
    rProductVersion: string;
    rComments: string;
    rVsFixedFileInfo: VS_FIXEDFILEINFO;
    rDefineValue: string;
  end;

// ��ȡ�ļ��İ汾��Ϣ
//mFileName Ŀ���ļ���
//nFileVersionInfomation �ļ���Ϣ�ṹ
//mDefineName �Զ����ֶ���
//�����Ƿ��ȡ�ɹ�
function GetFileVersionInfomation(mFileName: string;
        var nFileVersionInfomation: TFileVersionInfomation; mDefineName: string = ''): Boolean; 

// ɾ��ָ��Ŀ¼
//mDirName Ŀ¼��
//mPrefix ǰ׺
//mChangeAttrib �Ƿ��޸������Ա�ɾ��
// ����ɾ��ָ��Ŀ¼�Ƿ�ɹ�
function DeletePath(mDirName: string; mPrefix: string; mChangeAttrib: Boolean): Boolean;

// ���ļ�ʱ�䴦��ΪTDateTime
//mFileTime �ļ�ʱ��
// ���ش�����Ľ��
function FileTimeToDateTime(mFileTime: TFileTime): TDateTime; 

implementation

function GetFileVersionInfomation(mFileName: string;
        var nFileVersionInfomation: TFileVersionInfomation; mDefineName: string = ''): Boolean; 
var
  vHandle: Cardinal;
  vInfoSize: Cardinal;
  vVersionInfo: Pointer;
  vTranslation: Pointer;
  vVersionValue: string;
  vInfoPointer: Pointer;
begin
  Result := False;
  vInfoSize := GetFileVersionInfoSize(PChar(mFileName), vHandle); // ȡ���ļ��汾��Ϣ�ռ估��Դ���
  FillChar(nFileVersionInfomation, SizeOf(nFileVersionInfomation), 0); // ��ʼ��������Ϣ
  if vInfoSize <= 0 then Exit; // ��ȫ���

  GetMem(vVersionInfo, vInfoSize); // ������Դ
  with nFileVersionInfomation do try
    if not GetFileVersionInfo(PChar(mFileName),
      vHandle, vInfoSize, vVersionInfo) then Exit;
    CloseHandle(vHandle);
    VerQueryValue(vVersionInfo, '\VarFileInfo\Translation',
      vTranslation, vInfoSize);
    if not Assigned(vTranslation) then Exit;
    vVersionValue := Format('\StringFileInfo\%.4x%.4x\',
      [LOWORD(Longint(vTranslation^)), HIWORD(Longint(vTranslation^))]);
    VerQueryValue(vVersionInfo, PChar(vVersionValue + 'CompanyName'),
      vInfoPointer, vInfoSize);
    rCommpanyName := PChar(vInfoPointer);
    VerQueryValue(vVersionInfo, PChar(vVersionValue + 'FileDescription'),
      vInfoPointer, vInfoSize);
    rFileDescription := PChar(vInfoPointer);
    VerQueryValue(vVersionInfo, PChar(vVersionValue + 'FileVersion'),
      vInfoPointer, vInfoSize);
    rFileVersion := PChar(vInfoPointer);
    VerQueryValue(vVersionInfo, PChar(vVersionValue + 'InternalName'),
      vInfoPointer, vInfoSize);
    rInternalName := PChar(vInfoPointer);
    VerQueryValue(vVersionInfo, PChar(vVersionValue + 'LegalCopyright'),
      vInfoPointer, vInfoSize);
    rLegalCopyright := PChar(vInfoPointer);
    VerQueryValue(vVersionInfo, PChar(vVersionValue + 'LegalTrademarks'),
      vInfoPointer, vInfoSize);
    rLegalTrademarks := PChar(vInfoPointer);
    VerQueryValue(vVersionInfo, PChar(vVersionValue + 'OriginalFileName'),
      vInfoPointer, vInfoSize);
    rOriginalFileName := PChar(vInfoPointer);
    VerQueryValue(vVersionInfo, PChar(vVersionValue + 'ProductName'),
      vInfoPointer, vInfoSize);
    rProductName := PChar(vInfoPointer);
    VerQueryValue(vVersionInfo, PChar(vVersionValue + 'ProductVersion'),
      vInfoPointer, vInfoSize);
    rProductVersion := PChar(vInfoPointer);
    VerQueryValue(vVersionInfo, PChar(vVersionValue + 'Comments'),
      vInfoPointer, vInfoSize);
    rComments := PChar(vInfoPointer);
    VerQueryValue(vVersionInfo, '\', vInfoPointer, vInfoSize);
    rVsFixedFileInfo := TVSFixedFileInfo(vInfoPointer^);
    if mDefineName <> '' then begin
      VerQueryValue(vVersionInfo, PChar(vVersionValue + mDefineName),
        vInfoPointer, vInfoSize);
      rDefineValue := PChar(vInfoPointer);
    end else rDefineValue := '';
  finally
    FreeMem(vVersionInfo, vInfoSize);
  end;
  Result := True;
end; { GetFileVersionInfomation }

function DeletePath(mDirName: string; mPrefix: string; mChangeAttrib: Boolean): Boolean;
var
  vSearchRec: TSearchRec;
  vPathName: string;
  K: Integer;
begin
  Result := True;
  if mDirName = '' then Exit;
  vPathName := mDirName + '\*.*';
  K := FindFirst(vPathName, faAnyFile, vSearchRec);
  while K = 0 do begin
    if (vSearchRec.Attr and faDirectory > 0) and
      (Pos(vSearchRec.Name, '..') = 0) then
    begin
      if mChangeAttrib then
        FileSetAttr(mDirName + '\' + vSearchRec.Name, faDirectory);
      if (mPrefix = '') or (Pos(mPrefix, vSearchRec.Name) = 1) then
        Result := DeletePath(mDirName + '\' + vSearchRec.Name, mPrefix, mChangeAttrib);
    end else if Pos(vSearchRec.Name, '..') = 0 then
    begin
      if mChangeAttrib then
        FileSetAttr(mDirName + '\' + vSearchRec.Name, 0);
      if (mPrefix = '') or (Pos(mPrefix, vSearchRec.Name) = 1) then
        Result := DeleteFile(PChar(mDirName + '\' + vSearchRec.Name));
    end;
    if not Result then Break;
    K := FindNext(vSearchRec);
  end;
  FindClose(vSearchRec);
  Result := RemoveDir(mDirName);
end; { DeletePath }

function FileTimeToDateTime(mFileTime: TFileTime): TDateTime; 
var
  vSystemTime: TSystemTime;
  vLocalFileTime: TFileTime;
begin
  FileTimeToLocalFileTime(mFileTime, vLocalFileTime);
  FileTimeToSystemTime(vLocalFileTime, vSystemTime);
  Result := SystemTimeToDateTime(vSystemTime);
end; { FileTimeToDateTime }

end.