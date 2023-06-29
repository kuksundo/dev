unit UnitMacroListClass2;

interface

uses classes, SysUtils, System.Contnrs, Vcl.Dialogs, Vcl.Controls,
  mormot.core.json, mormot.core.base, mormot.core.data, mormot.core.unicode,
  mormot.core.text, mormot.orm.base,
  JHP.BaseConfigCollect, thundax.lib.actions_pjh;//System.Generics.Collections, , Generics.Legacy

const
  MACRO_START = 'MacroStart';
  MACRO_ONE_STEP = 'Macro One-Step';
  MACRO_STOP = 'Macro Stop';
  MACRO_MOUSE_POS = 'Macro Mouse position';

type
  TMacroSignalEventRec = record
    FHandleKind: integer;
    FTimeout_ms: cardinal;
    Fidx: integer;
  end;

  TMacroItem = class(TSynAutoCreateFields)
  private
    FItemName,
    FItemValue: string;
  published
    property ItemName: string read FItemName write FItemName;
    property ItemValue: string read FItemValue write FItemValue;
  end;

type
  TActionItem = class(TSynAutoCreateFields)
  private
    FActionCode,
    FActionDesc,
    FCustomDesc: string;
    FActionType: TActionType;
    FExecMode: TExecuteMode;
    FXPos, FYPos, FWaitSec, FGridIndex, FVKExtendKey: integer;
    FInputText: string;
  public
    class function AddActionItem2List(var AList: TActionList;
      AItem: TActionItem; ADesc: string = ''): IAction;
    procedure Assign(Source: TSynPersistent); override;
    procedure CopyActionList(ADest: TActionList);
  published
    property ActionCode: string read FActionCode write FActionCode;
    property ActionDesc: string read FActionDesc write FActionDesc;
    property CustomDesc: string read FCustomDesc write FCustomDesc;
    property ActionType: TActionType read FActionType write FActionType;
    property ExecMode: TExecuteMode read FExecMode write FExecMode;
    property XPos: integer read FXPos write FXPos;
    property YPos: integer read FYPos write FYPos;
    property WaitSec: integer read FWaitSec write FWaitSec;
    property GridIndex: integer read FGridIndex write FGridIndex; //1부터 시작함
    property VKExtendKey: integer read FVKExtendKey write FVKExtendKey; //Mouse Drag시 누른 확장 KeyCode 저장
    property InputText: string read FInputText write FInputText;
  end;

type
  //CHANGE CLASS TYPE HERE FOR TCollectionItemAutoCreateFields
  TMacros = class(TCollectionItemAutoCreateFields)
  private
    FMacroItem : TMacroItem;
    FMacroItemDescription: String;
  published
    property MacroItem : TMacroItem read FMacroItem;
    property MacroItemDescription : String read FMacroItemDescription;
  end;

//  TMacroCollect<T: TMacros> = class(Generics.Legacy.TCollection<T>);

  //THIS IS NEW CLASS FOR MANAGE COLLECTION AND ACCESS LIKE AN ARRAY
type
  TMacroCollection = class(TInterfacedCollection)
  private
    function GetCollItem(aIndex: Integer): TMacros;
  public
    class function GetClass: TCollectionItemClass; override;
    function Add: TMacros;
    property Item[aIndex: Integer]: TMacros read GetCollItem; default;
  end;

  TActions = class(TCollectionItemAutoCreateFields)
  private
    FActionItem: TActionItem;
  public
    procedure AssignActionItem(ASource: TActions);
    procedure AssignActionItem2(ASource: TActionItem);
  published
    property ActionItem : TActionItem read FActionItem;
  end;

  TActionCollection = class(TInterfacedCollection)
  private
    function GetCollItem(aIndex: Integer): TActions;
  protected
    class function GetClass: TCollectionItemClass; override;
  public
    procedure AssignCollect(ASource: TActionCollection);
    function Add: TActions;
    property Item[aIndex: Integer]: TActions read GetCollItem; default;
  end;

  TMacroArray = array of TMacroCollection;

  TMacroManagement = class(TSynAutoCreateFields)
  private
    FIterateCount : integer;
    FActionDesc: string;
    FCommIniFileName,
    FMacroName,
    FMacroDesc: string;
    FIsExecute: Boolean;

//    FMacroCollection: TMacroCollection;
    FMacroArray: TMacroArray;
    FActionCollection: TActionCollection;

    procedure Clear;
  public
    FActionList: TActionList;

    destructor Destroy; override;
    function MacroArrayAdd: TMacros;
    procedure SetActionColl2ActionList;
  published
    property CommIniFileName: string read FCommIniFileName write FCommIniFileName;
    property MacroName: string read FMacroName write FMacroName;
    property MacroDesc: string read FMacroDesc write FMacroDesc;
    property IterateCount : integer read FIterateCount write FIterateCount;
    property IsExecute : Boolean read FIsExecute write FIsExecute;
    property ActionDesc: string read FActionDesc write FActionDesc;

    property MacroArray: TMacroArray read FMacroArray;
    property ActionCollect: TActionCollection read FActionCollection;
  end;

  TMacroManagements = class(TObjectList)
  public
    function IsExistMacroName(AName: string): boolean;
    function AddMacro2ListWithName(AName: string=''): integer;
    function AddMacro2List(AMacro: TMacroManagement): integer;
    procedure DeleteMacroFromListWithIndex(AIdx: integer);

    procedure ClearObject;
    function LoadFromJSONFile(AFileName: string; APassPhrase: string=''; AIsEncrypt: Boolean=False): integer; virtual;
    function SaveToJSONFile(AFileName: string; APassPhrase: string=''; AIsEncrypt: Boolean=False): integer; virtual;
    function LoadFromStream(AStream: TStream; APassPhrase: string=''; AIsEncrypt: Boolean=False): integer;
    function SaveToStream(AStream: TStream; APassPhrase: string=''; AIsEncrypt: Boolean=False): integer;
  end;

  procedure CopyActionCollect(ASrc, ADest: TActionCollection);
  procedure CopyActionColl2ActionList(ASrcColl: TActionCollection; ADestActionList: TActionList);

implementation

uses UnitEncrypt2, UnitRttiUtil2;

procedure CopyActionCollect(ASrc, ADest: TActionCollection);
var
  i: integer;
begin
  ADest.Clear;

  for i := 0 to ASrc.Count - 1 do
  begin
    ADest.Add.ActionItem.Assign(ASrc.Item[i].ActionItem);
  end;

//  ASrc.AssignTo(ADest);
end;

procedure CopyActionColl2ActionList(ASrcColl: TActionCollection; ADestActionList: TActionList);
var
  i: integer;
begin
  for i := 0 to ASrcColl.Count - 1 do
  begin
    TActionItem.AddActionItem2List(ADestActionList, ASrcColl.Item[i].ActionItem);
  end;
end;

{ TMacroCollection }

function TMacroCollection.Add: TMacros;
begin
  Result := TMacros(inherited Add);
end;

class function TMacroCollection.GetClass: TCollectionItemClass;
begin
  Result := TMacros;
end;

function TMacroCollection.GetCollItem(aIndex: Integer): TMacros;
begin
  Result := TMacros(GetItem(aIndex));
end;

{ TActionCollection }

function TActionCollection.Add: TActions;
begin
  Result := TActions(inherited Add);
end;

procedure TActionCollection.AssignCollect(ASource: TActionCollection);
var
  i: integer;
begin
  for i := 0 to ASource.Count - 1 do
  begin
    Add.AssignActionItem(TActions(ASource.Items[i]));
  end;
end;

class function TActionCollection.GetClass: TCollectionItemClass;
begin
  Result := TActions;
end;

function TActionCollection.GetCollItem(aIndex: Integer): TActions;
begin
  Result := TActions(GetItem(aIndex));
end;

{ TMacroManagements }

function TMacroManagements.AddMacro2List(AMacro: TMacroManagement): integer;
var
  LMacroManagement: TMacroManagement;
  LMacroItem: TMacroItem;
  LActionItem: TActionItem;
begin
  LMacroManagement := TMacroManagement.Create;
  LMacroManagement.CommIniFileName := AMacro.CommIniFileName;
  LMacroManagement.MacroName := AMacro.MacroName;
  LMacroManagement.FIterateCount := AMacro.IterateCount;
  LMacroManagement.FIsExecute := AMacro.IsExecute;
  LMacroManagement.FActionList := TActionList.Create;
  LMacroManagement.FActionCollection.AssignCollect(AMacro.ActionCollect);

  Add(LMacroManagement);
end;

function TMacroManagements.AddMacro2ListWithName(AName: string): integer;
var
  LMacroManagement: TMacroManagement;
  LMacroItem: TMacroItem;
  LActionItem: TActionItem;
begin
  LMacroManagement := TMacroManagement.Create;
  LMacroManagement.CommIniFileName := '';
  LMacroManagement.MacroName := AName;
  LMacroManagement.FIterateCount := 1;
  LMacroManagement.FIsExecute := True;
  LMacroManagement.FActionList := TActionList.Create;

  Result := Add(LMacroManagement);
end;

procedure TMacroManagements.ClearObject;
var
  i: integer;
begin
  for i := Self.Count - 1 downto 0 do
  begin
    TMacroManagement(Self.Items[i]).Clear;

//    TMacroManagement(Self.Items[i]).Free;  ==> 이거살리면 Self.Clear할떄 에러남
  end;
end;

procedure TMacroManagements.DeleteMacroFromListWithIndex(AIdx: integer);
var
  LMacroManagement: TMacroManagement;
begin
  if MessageDlg('Are you sure to delete selected Macro?', mtConfirmation, mbOKCancel, 0) = mrOK then
  begin
    LMacroManagement := Items[AIdx] as TMacroManagement;
//    LMacroManagement.MacroCollect.Free;
    LMacroManagement.Clear;
    LMacroManagement.Free;
    Delete(AIdx);
  end;
end;

function TMacroManagements.IsExistMacroName(AName: string): boolean;
var
  i: integer;
  LMacroManagement: TMacroManagement;
begin
  Result := False;

  if AName = '' then
    exit;

  for i := 0 to Count - 1 do
  begin
    LMacroManagement := Items[i] as TMacroManagement;

    if LMacroManagement.MacroName = AName then
    begin
      Result := True;
      break;
    end;
  end;
end;

function TMacroManagements.LoadFromJSONFile(AFileName, APassPhrase: string;
  AIsEncrypt: Boolean): integer;
var
  LStrList: TStringList;
  LValid: Boolean;
  LString: RawUTF8;
  Fs: TFileStream;
  LMemStream: TMemoryStream;
begin
  LStrList := TStringList.Create;
  try
    if AIsEncrypt then
    begin
      LMemStream := TMemoryStream.Create;
      Fs := TFileStream.Create(AFileName, fmOpenRead);
      try
        DecryptStream(Fs, LMemStream, APassphrase);
        LMemStream.Position := 0;
        LStrList.LoadFromStream(LMemStream);
      finally
        LMemStream.Free;
        Fs.Free;
      end;

    end
    else
    begin
      LStrList.LoadFromFile(AFileName);
    end;

    SetLength(LString, Length(LStrList.Text));
    LString := StringToUTF8(LStrList.Text);
    JSONToObject(Self, PUTF8Char(LString), LValid, TMacroManagement, [j2oIgnoreUnknownProperty]);
  finally
    LStrList.Free;
  end;
end;

function TMacroManagements.LoadFromStream(AStream: TStream; APassPhrase: string;
  AIsEncrypt: Boolean): integer;
begin

end;

function TMacroManagements.SaveToJSONFile(AFileName, APassPhrase: string;
  AIsEncrypt: Boolean): integer;
var
  LStrList: TStringList;
  LMemStream: TMemoryStream;
  Fs: TFileStream;
  LStr: RawUTF8;
begin
  LStrList := TStringList.Create;
  try
    LStr := ObjectToJSON(Self,[woHumanReadable,woStoreClassName]);
    LStrList.Add(UTF8ToString(LStr));

    if AIsEncrypt then
    begin
      LMemStream := TMemoryStream.Create;
      Fs := TFileStream.Create(AFileName, fmCreate);
      try
        LStrList.SaveToStream(LMemStream);
        LMemStream.Position := 0;
        EncryptStream(LMemStream, Fs, APassphrase);
      finally
        Fs.Free;
        LMemStream.Free;
      end;
   end
    else
      LStrList.SaveToFile(AFileName);
  finally
    LStrList.Free;
  end;
end;

function TMacroManagements.SaveToStream(AStream: TStream; APassPhrase: string;
  AIsEncrypt: Boolean): integer;
begin

end;

{ TActionItem }

class function TActionItem.AddActionItem2List(var AList: TActionList;
  AItem: TActionItem; ADesc: string): IAction;
var
  action: IAction;
//  actionType: TActionType;
  x, y: Integer;
begin
//  actionType := TActionTypeHelper.GetActionTypeFromDesc(AItem.ActionCode);

  case AItem.ActionType of
    atNull: exit;
    atMousePos:
      begin
        if (AItem.XPos < 0) or (AItem.YPos < 0) then
          raise Exception.Create('Fields must contain valid coordinates');

        action := TAction<Integer>.Create(AItem.ActionType, TParameters<Integer>.Create(AItem.XPos, AItem.YPos), AItem.CustomDesc);
      end;
    atMouseLClick, atMouseLDClick, atMouseRClick, atMouseRDClick,
    atMouseLDown, atMouseLUp, atMouseRDown, atMouseRUp, atMouseMDown, atMouseMUp:
      action := TAction<String>.Create(AItem.ActionType, TParameters<String>.Create('', ''), AItem.CustomDesc);
    atKey:
      begin
        if (AItem.InputText = '') then
          raise Exception.Create('Fields must contain valid key');
        action := TAction<String>.Create(AItem.ActionType, TParameters<String>.Create(AItem.InputText, ''), AItem.CustomDesc);
      end;
    atMessage:
      begin
        if (AItem.InputText = '') then
          raise Exception.Create('Fields must contain valid message');
        action := TAction<String>.Create(AItem.ActionType, TParameters<String>.Create(AItem.InputText, ''), AItem.CustomDesc);
      end;
    atWait:
      begin
        if (AItem.WaitSec = 0) then
          raise Exception.Create('Field must contain time greater than zero');
        action := TAction<Integer>.Create(AItem.ActionType, TParameters<Integer>.Create(AItem.WaitSec, 0), AItem.CustomDesc);
      end;
    atMessage_Dyn:
      begin
        if (AItem.GridIndex <= 0) then
          raise Exception.Create('Fields must contain valid Grid Index');
        action := TAction<Integer>.Create(AItem.ActionType, TParameters<Integer>.Create(AItem.GridIndex, 0), AItem.CustomDesc);
      end;
    atExecuteFunc:
      begin
        if (AItem.InputText = '') then
          raise Exception.Create('Fields must contain valid function name');
        action := TAction<String>.Create(AItem.ActionType, TParameters<String>.Create(AItem.InputText, ''), AItem.CustomDesc);
      end;
    atMouseDrag:
      begin
        if (AItem.XPos < 0) or (AItem.YPos < 0) then
          raise Exception.Create('Fields must contain valid coordinates');
        action := TAction<Integer>.Create(AItem.ActionType, TParameters<Integer>.Create(AItem.XPos, AItem.YPos), IntToStr(AItem.VKExtendKey));
      end;
    atDragBegin:
      begin
        action := TAction<Integer>.Create(AItem.ActionType, TParameters<Integer>.Create(AItem.XPos, AItem.YPos), IntToStr(AItem.VKExtendKey));
      end;
    atDragEnd:
      begin
        action := TAction<Integer>.Create(AItem.ActionType, TParameters<Integer>.Create(AItem.XPos, AItem.YPos), IntToStr(AItem.VKExtendKey));
      end;
  end;

  action.SetExecMode(AItem.ExecMode);

  if not Assigned(AList) then
    AList := TActionList.Create;

  AList.Add(action);

  Result := action;
end;

procedure TActionItem.Assign(Source: TSynPersistent);
begin
//  inherited;

  ActionCode := TActionItem(Source).FActionCode;
  ActionDesc := TActionItem(Source).FActionDesc;
  ActionType := TActionItem(Source).FActionType;
  ExecMode := TActionItem(Source).FExecMode;
  XPos := TActionItem(Source).FXPos;
  YPos := TActionItem(Source).FYPos;
  WaitSec := TActionItem(Source).FWaitSec;
  InputText := TActionItem(Source).FInputText;
  GridIndex := TActionItem(Source).FGridIndex;
  VKExtendKey := TActionItem(Source).FVKExtendKey;
end;

procedure TActionItem.CopyActionList(ADest: TActionList);
begin

end;

{ TMacroManagement }

procedure TMacroManagement.Clear;
var
  i: integer;
begin
  if Assigned(FActionList) then
    FActionList.Free;

  if Assigned(FActionCollection) then
    FActionCollection.Free;

  for i := Low(MacroArray) to High(MacroArray) do
    MacroArray[i].Free;

  SetLength(FMacroArray, 0);
end;

destructor TMacroManagement.Destroy;
begin
  Clear;
//  inherited;
end;

function TMacroManagement.MacroArrayAdd: TMacros;
var
  i: integer;
begin
  Result := nil;
  i := High(FMacroArray) + 1;

  if i = 0 then
    i := 1;

  SetLength(FMacroArray, i);

  FMacroArray[i-1] := TMacroCollection.Create;
  Result := TMacroCollection(FMacroArray[i-1]).Add;
end;

procedure TMacroManagement.SetActionColl2ActionList;
var
  i: integer;
begin
  for i := 0 to FActionCollection.Count - 1 do
  begin
    TActionItem.AddActionItem2List(FActionList, FActionCollection.Item[i].ActionItem);
  end;
end;

{ TActions }

procedure TActions.AssignActionItem(ASource: TActions);
begin
  if ASource is TActions then
  begin
    PersistentCopy(TPersistent(ASource.ActionItem), TPersistent(Self.FActionItem));
  end
  else
    inherited;
end;

procedure TActions.AssignActionItem2(ASource: TActionItem);
begin
  PersistentCopy(TPersistent(ASource), TPersistent(Self.FActionItem));
end;

initialization
  TJSONSerializer.RegisterObjArrayForJSON([TypeInfo(TMacroArray), TMacroCollection]);

end.
