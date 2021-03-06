{-------------------------------------------------------------------------------
//                       EasyComponents For Delphi 7
//                         一轩软研第三方开发包                         
//                         @Copyright 2010 hehf                      
//                   ------------------------------------                       
//                                                                              
//           本开发包是公司内部使用,作为开发工具使用任何,何海锋个人负责开发,任何
//       人不得外泄,否则后果自负.        
//
//            使用权限以及相关解释请联系何海锋  
//                
//                                                               
//            网站地址：http://www.YiXuan-SoftWare.com                                  
//            电子邮件：hehaifeng1984@126.com 
//                      YiXuan-SoftWare@hotmail.com    
//            QQ      ：383530895
//            MSN     ：YiXuan-SoftWare@hotmail.com                                   
//------------------------------------------------------------------------------
//单元说明：
//    插件目录与插件参数类
//主要实现：
//-----------------------------------------------------------------------------}
unit untEasyClassPluginDirectory;

interface

uses
  Classes, DB, DBClient, Variants;

type

  { TEasysysPluginsDirectory }
  
  TEasysysPluginsDirectory = class
  private
  { Private declarations } 
    FPluginGUID: string;
    FPluginCName: string;
    FPluginEName: string;
    FiOrder: Integer;
    FImageIndex: Integer;
    FSelectedImageIndex: Integer;
    FIsDirectory: Boolean;
    FPluginFileName: string;
    FParentPluginGUID: string;
    FIsEnable: Boolean;
    FShowModal: Boolean;
    FRemark: string;
  public
  { Public declarations } 
    property PluginGUID: string read FPluginGUID write FPluginGUID;
    property PluginCName: string read FPluginCName write FPluginCName;
    property PluginEName: string read FPluginEName write FPluginEName;
    property iOrder: Integer read FiOrder write FiOrder;
    property ImageIndex: Integer read FImageIndex write FImageIndex;
    property SelectedImageIndex: Integer read FSelectedImageIndex write FSelectedImageIndex;
    property IsDirectory: Boolean read FIsDirectory write FIsDirectory;
    property PluginFileName: string read FPluginFileName write FPluginFileName;
    property ParentPluginGUID: string read FParentPluginGUID write FParentPluginGUID;
    property IsEnable: Boolean read FIsEnable write FIsEnable;
    property ShowModal: Boolean read FShowModal write FShowModal;
    property Remark: string read FRemark write FRemark;

    class procedure GeneratePluginDirectory(var Data: OleVariant);
    class procedure GeneratePluginDirectoryList(var Data: OleVariant; AResult: TList);
    class procedure AppendClientDataSet(ACds: TClientDataSet; AObj: TEasysysPluginsDirectory; var AObjList: TList);
    class procedure EditClientDataSet(ACds: TClientDataSet; AObj: TEasysysPluginsDirectory);
    class procedure DeleteClientDataSet(ACds: TClientDataSet; AObj: TEasysysPluginsDirectory; var AObjList: TList);
  end;

  { TEasysysPluginParam }
  
  TEasysysPluginParam = class
  private
  { Private declarations } 
    FPluginParamGUID: string;
    FParamName: string;
    FValueType: string;
    FValue: string;
    FPluginGUID: string;
  public
  { Public declarations } 
    property PluginParamGUID: string read FPluginParamGUID write FPluginParamGUID;
    property ParamName: string read FParamName write FParamName;
    property ValueType: string read FValueType write FValueType;
    property Value: string read FValue write FValue;
    property PluginGUID: string read FPluginGUID write FPluginGUID;

    class procedure GeneratePluginParam(var Data: OleVariant);
    class procedure GeneratePluginParamList(var Data: OleVariant; AResult: TList);
    class procedure AppendClientDataSet(ACds: TClientDataSet; AObj: TEasysysPluginParam; var AObjList: TList);
    class procedure EditClientDataSet(ACds: TClientDataSet; AObj: TEasysysPluginParam);
    class procedure DeleteClientDataSet(ACds: TClientDataSet; AObj: TEasysysPluginParam; var AObjList: TList);
  end;

var
  PluginDirectoryList,
  PluginParamsList: TList;

implementation

{ TEasysysPluginsDirectory }

class procedure TEasysysPluginsDirectory.GeneratePluginDirectoryList(
  var Data: OleVariant; AResult: TList);
var
  I: Integer;
  AEasysysPluginsDirectory: TEasysysPluginsDirectory;
  AClientDataSet: TClientDataSet;
begin
  //创建数据源，并获取数据
  AClientDataSet := TClientDataSet.Create(nil);
  AClientDataSet.Data := Data;
   //此句为实例化指定的对象
  AClientDataSet.First;
  try
    for I := 0 to AClientDataSet.RecordCount - 1 do
    begin
      AEasysysPluginsDirectory := TEasysysPluginsDirectory.Create;
      with AEasysysPluginsDirectory do
      begin
        PluginGUID := AClientDataSet.FieldByName('PluginGUID').AsString;
        PluginCName := AClientDataSet.FieldByName('PluginCName').AsString;
        PluginEName := AClientDataSet.FieldByName('PluginEName').AsString;
        iOrder := AClientDataSet.FieldByName('iOrder').AsInteger;
        ImageIndex := AClientDataSet.FieldByName('ImageIndex').AsInteger;
        SelectedImageIndex := AClientDataSet.FieldByName('SelectedImageIndex').AsInteger;
        IsDirectory := AClientDataSet.FieldByName('IsDirectory').AsBoolean;
        PluginFileName := AClientDataSet.FieldByName('PluginFileName').AsString;
        ParentPluginGUID := AClientDataSet.FieldByName('ParentPluginGUID').AsString;
        IsEnable := AClientDataSet.FieldByName('IsEnable').AsBoolean;
        ShowModal := AClientDataSet.FieldByName('ShowModal').AsBoolean;
        Remark := AClientDataSet.FieldByName('Remark').AsString;
      end;
     //在此添加将对象存放到指定容器的代码
      AResult.Add(AEasysysPluginsDirectory);
     //如果要关联树也在此添加相应代码
      AClientDataSet.Next;
    end;
  finally
    AClientDataSet.Free;
  end;
end;

class procedure TEasysysPluginsDirectory.GeneratePluginDirectory(var Data: OleVariant);
var
  I: Integer;
  AEasysysPluginsDirectory: TEasysysPluginsDirectory;
  AClientDataSet: TClientDataSet;
begin
  while (PluginDirectoryList.Count > 0) do
  begin
    TEasysysPluginsDirectory(PluginDirectoryList[0]).Free;
    PluginDirectoryList.Delete(0);
  end;

  //创建数据源，并获取数据
  AClientDataSet := TClientDataSet.Create(nil);
  AClientDataSet.Data := Data;
   //此句为实例化指定的对象
  AClientDataSet.First;
  try
    for I := 0 to AClientDataSet.RecordCount - 1 do
    begin
      AEasysysPluginsDirectory := TEasysysPluginsDirectory.Create;
      with AEasysysPluginsDirectory do
      begin
        PluginGUID := AClientDataSet.FieldByName('PluginGUID').AsString;
        PluginCName := AClientDataSet.FieldByName('PluginCName').AsString;
        PluginEName := AClientDataSet.FieldByName('PluginEName').AsString;
        iOrder := AClientDataSet.FieldByName('iOrder').AsInteger;
        ImageIndex := AClientDataSet.FieldByName('ImageIndex').AsInteger;
        SelectedImageIndex := AClientDataSet.FieldByName('SelectedImageIndex').AsInteger;
        IsDirectory := AClientDataSet.FieldByName('IsDirectory').AsBoolean;
        PluginFileName := AClientDataSet.FieldByName('PluginFileName').AsString;
        ParentPluginGUID := AClientDataSet.FieldByName('ParentPluginGUID').AsString;
        IsEnable := AClientDataSet.FieldByName('IsEnable').AsBoolean;
        ShowModal := AClientDataSet.FieldByName('ShowModal').AsBoolean;
        Remark := AClientDataSet.FieldByName('Remark').AsString;
      end;
     //在此添加将对象存放到指定容器的代码
      PluginDirectoryList.Add(AEasysysPluginsDirectory);
     //如果要关联树也在此添加相应代码
      AClientDataSet.Next;
    end;
  finally
    AClientDataSet.Free;
  end;
end;

class procedure TEasysysPluginsDirectory.AppendClientDataSet(
   ACds: TClientDataSet; AObj: TEasysysPluginsDirectory; var AObjList: TList);
begin
  with ACds do
  begin
    Append;
    FieldByName('PluginGUID').AsString := AObj.PluginGUID;
    FieldByName('PluginCName').AsString := AObj.PluginCName;
    FieldByName('PluginEName').AsString := AObj.PluginEName;
    FieldByName('iOrder').AsInteger := AObj.iOrder;
    FieldByName('ImageIndex').AsInteger := AObj.ImageIndex;
    FieldByName('SelectedImageIndex').AsInteger := AObj.SelectedImageIndex;
    FieldByName('IsDirectory').AsBoolean := AObj.IsDirectory;
    FieldByName('PluginFileName').AsString := AObj.PluginFileName;
    FieldByName('ParentPluginGUID').AsString := AObj.ParentPluginGUID;
    FieldByName('IsEnable').AsBoolean := AObj.IsEnable;
    FieldByName('ShowModal').AsBoolean := AObj.ShowModal;
    FieldByName('Remark').AsString := AObj.Remark;
    Post;
  end;
  AObjList.Add(AObj)
end;

class procedure TEasysysPluginsDirectory.EditClientDataSet(
  ACds: TClientDataSet; AObj: TEasysysPluginsDirectory);
begin
  if ACds.Locate('PluginGUID', VarArrayOf([AObj.PluginGUID]), [loCaseInsensitive]) then
  begin
    with ACds do
    begin
      Edit;
      FieldByName('PluginCName').AsString := AObj.PluginCName;
      FieldByName('PluginEName').AsString := AObj.PluginEName;
      FieldByName('iOrder').AsInteger := AObj.iOrder;
      FieldByName('ImageIndex').AsInteger := AObj.ImageIndex;
      FieldByName('SelectedImageIndex').AsInteger := AObj.SelectedImageIndex;
      FieldByName('IsDirectory').AsBoolean := AObj.IsDirectory;
      FieldByName('PluginFileName').AsString := AObj.PluginFileName;
      FieldByName('ParentPluginGUID').AsString := AObj.ParentPluginGUID;
      FieldByName('IsEnable').AsBoolean := AObj.IsEnable;
      FieldByName('ShowModal').AsBoolean := AObj.ShowModal;
      FieldByName('Remark').AsString := AObj.Remark;
      Post;
    end;
  end;
end;

class procedure TEasysysPluginsDirectory.DeleteClientDataSet(
  ACds: TClientDataSet; AObj: TEasysysPluginsDirectory; var AObjList: TList);
var
  I,
  DelIndex: Integer;
begin
  DelIndex := -1;
  if ACds.Locate('PluginGUID', VarArrayOf([AObj.PluginGUID]), [loCaseInsensitive]) then
    ACds.Delete;
  for I := 0 to AObjList.Count - 1 do
  begin
    if TEasysysPluginParam(AObjList[I]).PluginParamGUID = TEasysysPluginParam(AObj).PluginParamGUID then
    begin
      DelIndex := I;
      Break;
    end;
  end;
  if DelIndex <> -1 then
  begin
    TEasysysPluginParam(AObjList[DelIndex]).Free;
    AObjList.Delete(DelIndex);
  end;  
end;

{ TEasysysPluginParam }

class procedure TEasysysPluginParam.AppendClientDataSet(
  ACds: TClientDataSet; AObj: TEasysysPluginParam; var AObjList: TList);
begin
  with ACds do
  begin
    Append;
    FieldByName('PluginParamGUID').AsString := AObj.PluginParamGUID;
    FieldByName('ParamName').AsString := AObj.ParamName;
    FieldByName('ValueType').AsString := AObj.ValueType;
    FieldByName('Value').AsString := AObj.Value;
    FieldByName('PluginGUID').AsString := AObj.PluginGUID;
    Post;
  end;
  AObjList.Add(AObj);
end;

class procedure TEasysysPluginParam.DeleteClientDataSet(
  ACds: TClientDataSet; AObj: TEasysysPluginParam; var AObjList: TList);
var
  I,
  DelIndex: Integer;
begin
  DelIndex := -1;
  if ACds.Locate('PluginParamGUID', VarArrayOf([AObj.PluginParamGUID]), [loCaseInsensitive]) then
    ACds.Delete;
  for I := 0 to AObjList.Count - 1 do
  begin
    if TEasysysPluginParam(AObjList[I]).PluginParamGUID = TEasysysPluginParam(AObj).PluginParamGUID then
    begin
      DelIndex := I;
      Break;
    end;
  end;
  if DelIndex <> -1 then
  begin
    TEasysysPluginParam(AObjList[DelIndex]).Free;
    AObjList.Delete(DelIndex);
  end;  
end;

class procedure TEasysysPluginParam.EditClientDataSet(ACds: TClientDataSet;
  AObj: TEasysysPluginParam);
begin
  if ACds.Locate('PluginParamGUID', VarArrayOf([AObj.PluginParamGUID]), [loCaseInsensitive]) then
  begin
    with ACds do
    begin
      Edit;
      FieldByName('PluginParamGUID').AsString := AObj.PluginParamGUID;
      FieldByName('ParamName').AsString := AObj.ParamName;
      FieldByName('ValueType').AsString := AObj.ValueType;
      FieldByName('Value').AsString := AObj.Value;
      FieldByName('PluginGUID').AsString := AObj.PluginGUID;
      Post;
    end;
  end;  
end;

class procedure TEasysysPluginParam.GeneratePluginParam(var Data: OleVariant);
var
  I: Integer;
  AEasysysPluginParam: TEasysysPluginParam;
  AClientDataSet: TClientDataSet;
begin
  if Assigned(PluginParamsList) then
    if PluginParamsList.Count > 0 then
      Exit;

  //创建数据源，并获取数据
  AClientDataSet := TClientDataSet.Create(nil);
  AClientDataSet.Data := Data;

   //此句为实例化指定的对象
  AClientDataSet.First;
  for I := 0 to AClientDataSet.RecordCount - 1 do
  begin
    AEasysysPluginParam := TEasysysPluginParam.Create;
    with AEasysysPluginParam do
    begin
      PluginParamGUID := AClientDataSet.FieldByName('PluginParamGUID').AsString;
      ParamName := AClientDataSet.FieldByName('ParamName').AsString;
      ValueType := AClientDataSet.FieldByName('ValueType').AsString;
      Value := AClientDataSet.FieldByName('Value').AsString;
      PluginGUID := AClientDataSet.FieldByName('PluginGUID').AsString;
    end;
    //在此添加将对象存放到指定容器的代码
    PluginParamsList.Add(AEasysysPluginParam);
    //如果要关联树也在此添加相应代码
    AClientDataSet.Next;
  end;
end;

class procedure TEasysysPluginParam.GeneratePluginParamList(
  var Data: OleVariant; AResult: TList);
var
  I: Integer;
  AEasysysPluginParam: TEasysysPluginParam;
  AClientDataSet: TClientDataSet;
begin
  //创建数据源，并获取数据
  AClientDataSet := TClientDataSet.Create(nil);
  AClientDataSet.Data := Data;

   //此句为实例化指定的对象
  AClientDataSet.First;
  for I := 0 to AClientDataSet.RecordCount - 1 do
  begin
    AEasysysPluginParam := TEasysysPluginParam.Create;
    with AEasysysPluginParam do
    begin
      PluginParamGUID := AClientDataSet.FieldByName('PluginParamGUID').AsString;
      ParamName := AClientDataSet.FieldByName('ParamName').AsString;
      ValueType := AClientDataSet.FieldByName('ValueType').AsString;
      Value := AClientDataSet.FieldByName('Value').AsString;
      PluginGUID := AClientDataSet.FieldByName('PluginGUID').AsString;
    end;
    //在此添加将对象存放到指定容器的代码
    AResult.Add(AEasysysPluginParam);
    //如果要关联树也在此添加相应代码
    AClientDataSet.Next;
  end;
end;

initialization
  PluginDirectoryList := TList.Create;

finalization
  while (PluginDirectoryList.Count > 0) do
  begin
    TObject(PluginDirectoryList.Items[0]).Free;
    PluginDirectoryList.Delete(0);
  end;
  PluginDirectoryList.Free;

  if Assigned(PluginParamsList) then
  begin
    while (PluginParamsList.Count > 0) do
    begin
      TObject(PluginParamsList.Items[0]).Free;
      PluginParamsList.Delete(0);
    end;
    PluginParamsList.Free;
  end;

end.
