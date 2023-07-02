unit UnitMacroRecorderMain2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Registry,
  Vcl.ComCtrls, JvExComCtrls, JvHotKey, Vcl.Menus, System.Contnrs,//System.Generics.Collections,//
  Vcl.ExtCtrls, Vcl.StdCtrls, NxScrollControl, NxCustomGridControl,
  NxCustomGrid, NxGrid, NxColumns, NxColumnClasses, Vcl.ImgList,
  OtlTask,
  OtlTaskControl,
  OtlCollections,
  OtlParallel,
  OtlSync,
  OtlComm,
  OtlCommon, TimerPool,
  mormot.core.base, mormot.orm.base, mormot.core.variants, mormot.core.json,
  thundax.lib.actions_pjh, CPort, HotKeyManager, SendInputHelper,
  UnitMacroListClass2, UnitNextGridFrame, Vcl.Buttons, Vcl.ToolWin, UnitAction2,
  ralarm, GpCommandLineParser, UnitMacroConfigClass, UnitSerialCommThread,
  Winapi.Hooks, FrmEventCaptureConfig;

const
  WM_Notify_Mouse_Event = WM_USER + 101;
  WM_Notify_KeyBd_Event = WM_USER + 102;

type
  TMsgKind = (mkUnKnown, mkMouse, mkKeyBd, mkHWinput);
  TMsgBuff = array[0..20000] of TInput;

  TMacroManageF = class(TForm)
    HotKeyManager1: THotKeyManager;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Macro1: TMenuItem;
    Add1: TMenuItem;
    Delete1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    PopupMenu1: TPopupMenu;
    AddRow1: TMenuItem;
    ImageList1: TImageList;
    Execute1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Panel4: TPanel;
    Button3: TButton;
    Splitter2: TSplitter;
    Button1: TButton;
    Label1: TLabel;
    MacroNameEdit: TEdit;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Panel5: TPanel;
    ActionLB: TListBox;
    Panel6: TPanel;
    Button6: TButton;
    btnSequence: TSpeedButton;
    btnStop: TSpeedButton;
    Panel7: TPanel;
    MacroGrid: TNextGrid;
    seq: TNxTextColumn;
    Macroname: TNxTextColumn;
    IsExecute: TNxCheckBoxColumn;
    RepeatCount: TNxTextColumn;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Panel8: TPanel;
    Panel9: TPanel;
    ListBox1: TListBox;
    Edit1: TEdit;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    BeginTimeCheck: TCheckBox;
    BeginTimePicker: TDateTimePicker;
    Label10: TLabel;
    Edit2: TEdit;
    AlarmFromTo1: TAlarmFromTo;
    NoScreenSaverCheck: TCheckBox;
    Timer1: TTimer;
    Panel10: TPanel;
    NGFrame: TFrame1;
    CommportConfig1: TMenuItem;
    btnRecorder: TSpeedButton;
    LoadFromFile1: TMenuItem;
    N3: TMenuItem;
    PlayInputMacro1: TMenuItem;
    SendInputTest1: TMenuItem;
    MacroListPopup: TPopupMenu;
    LoadActionFromFile1: TMenuItem;
    AddActionFromSIHelperFile1: TMenuItem;
    Label2: TLabel;
    N4: TMenuItem;
    Config1: TMenuItem;
    LoadEventCaptureConfigFromFile1: TMenuItem;
    ChangeMacroName1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure HotKeyManager1HotKeyPressed(HotKey: Cardinal; Index: Word);
    procedure Button1Click(Sender: TObject);
    procedure NGFrameToolButton21Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure NGFramebtnAddRowClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnSequenceClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure MacroGridSelectCell(Sender: TObject; ACol, ARow: Integer);
    procedure ActionLBDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure IsExecuteSetCell(Sender: TObject; ACol, ARow: Integer;
      CellRect: TRect; CellState: TCellState);
    procedure RepeatCountSetCell(Sender: TObject; ACol, ARow: Integer;
      CellRect: TRect; CellState: TCellState);
    procedure MacroGridAfterEdit(Sender: TObject; ACol, ARow: Integer;
      Value: WideString);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure BeginTimeCheckClick(Sender: TObject);
    procedure BeginTimePickerChange(Sender: TObject);
    procedure AlarmFromTo1AlarmBegin(Sender: TObject);
    procedure NoScreenSaverCheckClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CommportConfig1Click(Sender: TObject);
    procedure btnRecorderClick(Sender: TObject);
    procedure PlayInputMacro1Click(Sender: TObject);
    procedure SendInputTest1Click(Sender: TObject);
    procedure LoadActionFromFile1Click(Sender: TObject);
    procedure AddActionFromSIHelperFile1Click(Sender: TObject);
    procedure LoadFromFile1Click(Sender: TObject);
    procedure Config1Click(Sender: TObject);
    procedure LoadEventCaptureConfigFromFile1Click(Sender: TObject);
    procedure ChangeMacroName1Click(Sender: TObject);
  private
    FMacroCancelToken: IOmniCancellationToken;
    FMacroStepQueue    : TOmniMessageQueue;
    FActionStepQueue    : TOmniMessageQueue;
    FMacroStepHandles: array of THandle;
    FMacroStepWaiter : TWaitFor;
    FActionStepHandles: array of THandle;
    FActionStepWaiter : TWaitFor;
    FActionStepEnable,
    FMacroStepEnable: boolean;
    FBreak : Boolean;
    FLBpos: Integer;

    FCommandLine: TMacroCommandLineOption;
    FPJHTimerPool: TPJHTimerPool;
    FSerialCommThread: TSerialCommThread;

    FCommBufStr,
    FCommConfigFileName,
    FEventCaptureConfigFileName: string;

    FEventCaptureConfig: TEventCaptureConfig;

    //EnableLUA 값이 0이면 True
    //StopMacro시에 값을 0으로 Reset활 필요 없음
    FNeedResetRegistry4EnableLUA: Boolean;

    FKeyBdHook: THook;
    FMouseHook: THook;
    FMousePt: TPoint;
    FHookStarted: Boolean;
    PMsgBuff: ^TMsgBuff;
    FMsgCount: integer;
    FFirstEvent: Boolean;
    FStartTime: Cardinal;
    FSendInputHelper: TSendInputHelper;

    procedure InitHotKey;
    procedure CreateCommThread(AIsReset: Boolean=false);
    procedure DestroyCommThread;
    procedure CreateEvents(manualReset: boolean; ANoOfEvent: integer);
    procedure DestroyEvents;

    function CheckNSetRegistryForEnableLUA: boolean;//Win10에서는 Journal Hook 비활성화가 기본값임
    function CheckNReSetRegistryForEnableLUA: boolean;
    function CommandLineParse: string;
    procedure ApplyCommandLineOption;

    procedure WMReceiveString( var Message: TMessage ); message WM_RECEIVESTRINGFROMCOMM;
    procedure WMNotifyMouseEvent( var Message: TMessage ); message WM_Notify_Mouse_Event;
    procedure WMNotifyKeyBdEvent( var Message: TMessage ); message WM_Notify_KeyBd_Event;

    procedure OnAutoExecuteMacro(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);

    procedure WaitForAll(AStepWait: TWaitFor; timeout_ms: cardinal; expectedResult: TWaitFor.TWaitForResult;
      const msg: string);
    procedure WaitForAny(AStepWait: TWaitFor; timeout_ms: cardinal; expectedResult: TWaitFor.TWaitForResult;
      const msg: string; checkHandle: integer = -1);

    procedure AddActionFromForm;

    procedure AddMacroTest1;
    procedure AddMacroTest2;
    procedure AddEvent2Buf(Message: TMessage);
    procedure AddMouseEvent2Buf(Message: TMessage);
    procedure AddKeyBdEvent2Buf(Message: TMessage);
    procedure AddMouseEvent2SIHelper(Message: TMessage);
    procedure AddKeyBdEvent2SIHelper(Message: TMessage);
    procedure AddInput2MsgBuff(var AInput: TInput);
    procedure SaveInput2File(AFileName: string);
    function LoadInputFromFile(AFileName: string): Boolean;
    procedure SaveSIHelperList2File(AFileName: string);
    function LoadSIHelperListFromFile(AFileName: string): Boolean;
    function GetMsgKindFromMsg(AMsg: Cardinal): TMsgKind;
    procedure AssignInputTo(var AInputs: array of TInput);
    procedure CopySIHelperNInsertDelay(var ADestSIHelper: TSendInputHelper; ADelay: Cardinal);
    procedure AssignSIHelper2ActionColl(AIndex: integer);
    procedure AssignInput2ActionList(AInput: TInput; AMacroManage: TMacroManagement);
    procedure ConvertInput2ActionItem(AInput: TInput; AActionItem: TActionItem);

    procedure StepEnque(AHandleKind: integer);
  public
    FWorker  : IOmniParallelLoop<integer>;
    FWorker2  : IOmniParallelLoop<pointer>;
    FfrmActions: TfrmActions;
    FMacroManageList: TMacroManagements;

    procedure ShowMacroManageListCount;
    procedure AssignActionData2Form(ASrcActColl, ADestActColl: TActionCollection;
      var ADestActList: TActionList);
    procedure AssignDynMsg2Grid(AMacroArray: TMacroArray);

    procedure PlayMacro;
    procedure PlayMacroFromRecord;
    procedure _PlaySequence(AIdx: integer);
    procedure PlaySequence(AActionList: TActionList; ATimes: integer);
    procedure StopMacro;
    procedure SignalEvent(const task: IOmniTask); //asynch
    procedure SignalEventAsync(AHandleKind: integer; timeout_ms: cardinal; idx: integer);

    procedure LoadSIHFromFile();
    procedure PlayInputMacro;
    procedure Action2HW(Action: IAction);
    procedure MouseClickAction4HW();

    procedure CreateMsgBuf;
    procedure DestroyMsgBuf;
    procedure CreateKeyBdHook;
    procedure CreateMouseHook;
    procedure DestroyHook;
    procedure CreateSendInputHelper;
    procedure DestroySendInputHelper;

    procedure ToggleRecording;
    procedure StopRecording;
    procedure PlayMacroRecordFromFile(AFileName: string='');
    procedure SaveMacroRecord(AFileName: string='');

    procedure CreateNewMacro;
    procedure ClearMacro;
    procedure ClearMacroFromGrid;
    procedure AddMacroName(AName: string='');
    procedure DeleteMacroname(AIdx: integer);
    procedure SaveMacroToFile(AFileName: string);
    procedure LoadMacroFromFile(AFileName: string; AIsAppend: Boolean=False);
    procedure DisplayMacroToGrid(AName: string = '');

    procedure AddMacroItemName(AName: string);
    procedure DeleteMacroItemName(AIdx: integer = -1);
    procedure SelectMacroItem(AIdx: integer);
    procedure SelectMacroCollect(AIdx: integer);
    procedure SelectActionCollect(AIdx: integer=-1);
    procedure GetMsgFromGrid(AIndex: integer; var AMsg: string);

    procedure SetEventCaptureConfig;
    procedure LoadEventCaptureConfigFromFile(AFileName: string='');
  end;

var
  MacroManageF: TMacroManageF;

implementation

uses UnitNameEdit, SystemCriticalU, sndkey32, FrmSerialCommConfig, UnitKeyBdUtil,
  FrmInputEdit;

{$R *.dfm}

procedure TMacroManageF.Action2HW(Action: IAction);
var
  LActionType: TActionType;
begin
  LActionType := Action.GetActionType;

  case LActionType of
    atMousePos: ;
    atMouseLClick,
    atMouseLDClick,
    atMouseRClick,
    atMouseRDClick: MouseClickAction4HW();
    atKey: ;
  end;
end;

procedure TMacroManageF.ActionLBDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  with (Control as TListBox).Canvas do
  begin
    if FLBpos = Index then
    begin
      Brush.Color := cllime;
      DrawFocusRect(Rect);
    end;

    FillRect(Rect);
    TextOut(Rect.Left, Rect.Top, (Control as TListBox).Items[Index]);
  end;

end;

procedure TMacroManageF.AddActionFromForm;
var
  LMacroManagement: TMacroManagement;
  LMacroItem: TMacroItem;
  LActionItem: TActionItem;
  i: integer;
begin
  FfrmActions := TfrmActions.Create(nil);
  try
    with FfrmActions do
    begin
      i := MacroGrid.SelectedRow;
      
      if i < 0 then
        exit;
        
      LMacroManagement := FMacroManageList.Items[i] as TMacroManagement;
      AssignActionData2Form(LMacroManagement.ActionCollect,FActionCollection,
        FActionList);
      ActionEditLB.Items.Assign(ActionLB.Items);

      if ShowModal = mrOK then
      begin
        AssignActionData2Form(FActionCollection,LMacroManagement.ActionCollect,
          LMacroManagement.FActionList);
//  CopyActionCollect(FActionCollection, LMacroManagement.ActionCollect);
//
//  for i := 0 to FActionCollection.Count - 1 do
//  begin
//    if not Assigned(LMacroManagement.FActionList) then
//      LMacroManagement.FActionList := TActionList.Create;
//            
//    AddAction2List(LMacroManagement.FActionList, FActionCollection.Item[i].ActionItem);
//  end;

//        CopyActionList(LMacroManagement.FActionList);

        ActionLB.Clear;
        ActionLB.Items.Assign(ListBox1.Items);
      end;
    end;
  finally
    FreeAndNil(FfrmActions);
  end;
end;

procedure TMacroManageF.AddActionFromSIHelperFile1Click(Sender: TObject);
begin
  if MacroGrid.SelectedRow = -1 then
  begin
    ShowMessage('Please select macro!');
    exit;
  end;

  //FSendInputHelper에 Input List Load 함
  LoadSIHFromFile();

  //FSendInputHelper를 FMacromanagent.ActionList로 Convert 함
  AssignSIHelper2ActionColl(MacroGrid.SelectedRow);
  SelectActionCollect();
end;

procedure TMacroManageF.AddEvent2Buf(Message: TMessage);
begin
  case GetMsgKindFromMsg(Message.WParam) of
    mkMouse: AddMouseEvent2SIHelper(Message);//AddMouseEvent2Buf(Message);
    mkKeyBd: AddKeyBdEvent2SIHelper(Message);//AddKeyBdEvent2Buf(Message);
  end;
end;

procedure TMacroManageF.AddInput2MsgBuff(var AInput: TInput);
begin
  PMsgBuff^[FMsgCount] := AInput;

  Inc(FMsgCount);
end;

procedure TMacroManageF.AddKeyBdEvent2Buf(Message: TMessage);
var
  LEvnt: TInput;
  LMsgType: Cardinal;
  LKeyBdHookStruct: KBDLLHOOKSTRUCT;
begin
  LKeyBdHookStruct := pKBDLLHOOKSTRUCT(Message.wParam)^;
  LEvnt.Itype := INPUT_KEYBOARD;
  LMsgType := Message.lParam;

  if (LMsgType = WM_KEYDOWN) or (LMsgType = WM_KEYUP) then
  begin
    LEvnt.ki.wVk := LKeyBdHookStruct.vkCode;
    LEvnt.ki.dwFlags := LKeyBdHookStruct.flags;
    LEvnt.ki.wScan := LKeyBdHookStruct.ScanCode;
    LEvnt.ki.time := LKeyBdHookStruct.time;
    LEvnt.ki.dwExtraInfo := LKeyBdHookStruct.dwExtraInfo;
  end;

  AddInput2MsgBuff(LEvnt);
end;

procedure TMacroManageF.AddKeyBdEvent2SIHelper(Message: TMessage);
var
  LKeyBdHookStruct: KBDLLHOOKSTRUCT;
  LLKeyBoardHook: TLowLevelKeyboardHook;
begin
  LLKeyBoardHook := PLowLevelKeyboardHook(Message.LParam)^;
  LKeyBdHookStruct := LLKeyBoardHook.HookStruct;

  with LKeyBdHookStruct do
  begin
    FSendInputHelper.AddKeyboardInput(vkCode, ScanCode, flags, time);
//  Caption := '[' + IntToStr(LKeyBdHookStruct.vkCode) + ']';
//    LVirtualKey := vkCode;
//    LScanCode := ScanCode;
//    LFlags := flags;
//    LTime := time;
  end;

//  FSendInputHelper.AddKeyboardInput(LVirtualKey, LScanCode, LFlags, LTime);
//  FSendInputHelper.AddKeyboardInput(vkCode, ScanCode, flags, time);
end;

procedure TMacroManageF.AddMacroItemName(AName: string);
begin
  if AName = '' then
    AName := IntToStr(Random(100));

  ListBox1.Items.Add(AName);
end;

procedure TMacroManageF.AddMacroName(AName: string);
var
  LRow, LAddResult: integer;
begin
  if FMacroManageList.IsExistMacroName(AName) then
  begin
    ShowMessage('동일한 매크로 이름이 존재합니다.');
    exit;
  end
  else
  begin
    if AName = '' then
      AName := 'Noname Macro1';

    LAddResult := FMacroManageList.AddMacro2ListWithName(AName);

    if LAddResult = -1 then
    begin

    end
    else
    begin
      LRow := MacroGrid.AddRow;
      MacroGrid.CellByName['Macroname', LRow].AsString := AName;
      MacroGrid.CellByName['IsExecute', LRow].AsBoolean := True;
      MacroGrid.CellByName['RepeatCount', LRow].AsInteger := 1;
    end;
  end;
end;

procedure TMacroManageF.AddMacroTest1;
var
  LMacroManagements: TMacroManagements;
  LMacroManagement: TMacroManagement;
  LMacroItem: TMacroItem;
  LActionItem: TActionItem;
  LJson: RawUTF8;
  LValid: Boolean;
//  LList: TObjectList;
  LVar: TDocVariantData;
  LP: PUtf8Char;
begin
//  LMacroManagement := TMacroManagement.Create(nil);
//  LMacroManagement.MacroName := 'Test1 Name';
//  LMacroManagement.MacroDesc := 'Test1 Desc';
//  LMacroItem := LMacroManagement.MacroCollect.Add;
//  LMacroItem.ItemName := 'Test1 Item Name';
//  LMacroItem.ItemValue := 'Test1 Item Value';
//  LActionItem := LMacroManagement.ActionCollect.Add;
//  LActionItem.ActionCode := 'Test1 Action Code';
//  LActionItem := LMacroManagement.ActionCollect.Add;
//  LActionItem.ActionCode := 'Test2 Action Code';
//
//  TJSONSerializer.RegisterClassForJSON([TMacroManagement,TActionCollect<TActionItem>, TMacroCollect<TMacroItem>,TActionItem, TMacroItem]);
//  LMacroManagements := TObjectList.Create;
//  LMacroManagements.Add(LMacroManagement);
////  Memo1.Text := ObjectToJSON(LMacroManagement, [woHumanReadable, woObjectListWontStoreClassName]);
//  Memo1.Text := ObjectToJSON(LMacroManagements, [woHumanReadable,woStoreClassName]);
////  TMacroManagement(LMacroManagements.Items[0]).Free;
//  LMacroManagements.Delete(0);
//  LMacroManagements.Extract(LMacroManagement);
//  LMacroManagements.Free;
////  LMacroManagement.Free;
//
////  ObjArraySetLength(LMacroManagements, 1);
////  TJSONSerializer.RegisterObjArrayForJSON([TypeInfo(TMacroManagements), TMacroManagement]);
////  ObjArrayAdd(LMacroManagements, LMacroManagement);
////  Memo1.Text := ObjArrayToJSON(LMacroManagements, [woHumanReadable, woObjectListWontStoreClassName]);
////  ObjArrayClear(LMacroManagements);
////
////  ObjArraySetLength(LMacroManagements, 1);
//  LJson := Memo1.Text;
////  LVar := _Safe(_JSONFast(LJson))^;
//  LMacroManagements := TObjectList.Create;
////  DocVariantToObjArray(LVar, LMacroManagements, TMacroManagement);
//  LP := @LJson[1];
//  JsonToObject(LMacroManagements, LP,LValid, TMacroManagement,[j2oIgnoreUnknownProperty]);
////  LMacroManagements := JsonToNewObject(LP,LValid);
////  LMacroManagement := LMacroManagements[0];
//  ShowMessage(IntToStr(LMacroManagements.Count));
//  LMacroManagements.Free;
////  LMacroManagement := LMacroManagements.Items[0] as TMacroManagement;
////  Memo1.Lines.Clear;
////  Memo1.Lines.Add(LMacroManagement.MacroName);
//
////  AddMacroName(MacroNameEdit.Text);
end;

procedure TMacroManageF.AddMacroTest2;
var
  LMacroManagements: TMacroManagements;
  LMacroManagement: TMacroManagement;
  LMacroItem: TMacros;
  LActionItem: TActions;
  LJson: RawUTF8;
  LValid: Boolean;
  LVar: TDocVariantData;
  LP: PUtf8Char;
begin
  LMacroManagement := TMacroManagement.Create;
  LMacroManagement.MacroName := 'Test1 Name';
  LMacroManagement.MacroDesc := 'Test1 Desc';
//  LMacroItem := LMacroManagement.MacroCollect.Add;
  LMacroItem := LMacroManagement.MacroArrayAdd;
  LMacroItem.MacroItem.ItemName := 'Test1 Item Name';
  LMacroItem.MacroItem.ItemValue := 'Test1 Item Value';
  LActionItem := LMacroManagement.ActionCollect.Add;
  LActionItem.ActionItem.ActionCode := 'Test1 Action Code';
  LActionItem := LMacroManagement.ActionCollect.Add;
  LActionItem.ActionItem.ActionCode := 'Test2 Action Code';

//  TJSONSerializer.RegisterClassForJSON([TMacroManagement,TActions, TMacros,TActionItem, TMacroItem]);
  LMacroManagements := TMacroManagements.Create;
  LMacroManagements.OwnsObjects := True;
  LMacroManagements.Add(LMacroManagement);
//  Memo1.Text := ObjectToJSON(LMacroManagements, [woHumanReadable,woStoreClassName]);
  LMacroManagements.Delete(0);
//  LMacroManagements.Extract(LMacroManagement);
  LMacroManagements.Free;

//  LJson := Memo1.Text;
  LMacroManagements := TMacroManagements.Create;
  LP := @LJson[1];
  JsonToObject(LMacroManagements, LP,LValid, TMacroManagement,[j2oIgnoreUnknownProperty]);
//  Memo2.Text := ObjectToJSON(LMacroManagements, [woHumanReadable,woStoreClassName]);
  LMacroManagements.Free;

//  AddMacroName(MacroNameEdit.Text);
end;

procedure TMacroManageF.AddMouseEvent2Buf(Message: TMessage);
var
  LEvnt: TInput;
  LMsgType: Cardinal;
  LMouseHook: TLowLevelMouseHook;
begin
  LMouseHook := PLowLevelMouseHook(Message.LParam)^;

  LEvnt.Itype := INPUT_MOUSE;
//  LEvnt.mi.dx := MulDiv(LMouseHook.HookStruct.Pt.X, 65536, GetSystemMetrics(SM_CXSCREEN));
//  LEvnt.mi.dy := MulDiv(LMouseHook.HookStruct.Pt.Y, 65536, GetSystemMetrics(SM_CXSCREEN));
  LEvnt.mi.dx := LMouseHook.HookStruct.Pt.X;
  LEvnt.mi.dy := LMouseHook.HookStruct.Pt.Y;
  LEvnt.mi.mouseData := 0;
  LEvnt.mi.time := 0;
  LEvnt.mi.dwExtraInfo := 0;

  LMsgType := Message.WParam;

  if (LMsgType = WM_LBUTTONDOWN) or (LMsgType = WM_LBUTTONDBLCLK) then
  begin
    LEvnt.mi.dwFlags := MOUSEEVENTF_LEFTDOWN;
    LEvnt.mi.dx := 0;
    LEvnt.mi.dy := 0;
  end
  else if (LMsgType = WM_RBUTTONDOWN) or (LMsgType = WM_RBUTTONDBLCLK) then
  begin
    LEvnt.mi.dwFlags := MOUSEEVENTF_RIGHTDOWN;
    LEvnt.mi.dx := 0;
    LEvnt.mi.dy := 0;
  end
  else if (LMsgType = WM_MBUTTONDOWN) or (LMsgType = WM_MBUTTONDBLCLK) then
  begin
    LEvnt.mi.dwFlags := MOUSEEVENTF_MIDDLEDOWN;
    LEvnt.mi.dx := 0;
    LEvnt.mi.dy := 0;
  end
  else if (LMsgType = WM_MBUTTONDOWN) or (LMsgType = WM_MBUTTONDBLCLK) then
  begin
    LEvnt.mi.dwFlags := MOUSEEVENTF_MIDDLEDOWN;
    LEvnt.mi.dx := 0;
    LEvnt.mi.dy := 0;
  end
  else if (LMsgType = WM_LBUTTONUP) then
  begin
    LEvnt.mi.dwFlags := MOUSEEVENTF_LEFTUP;
    LEvnt.mi.dx := 0;
    LEvnt.mi.dy := 0;
  end
  else if (LMsgType = WM_RBUTTONUP) then
  begin
    LEvnt.mi.dwFlags := MOUSEEVENTF_RIGHTUP;
    LEvnt.mi.dx := 0;
    LEvnt.mi.dy := 0;
  end
  else if (LMsgType = WM_MBUTTONUP) then
  begin
    LEvnt.mi.dwFlags := MOUSEEVENTF_MIDDLEUP;
    LEvnt.mi.dx := 0;
    LEvnt.mi.dy := 0;
  end
  else if (LMsgType = WM_MOUSEWHEEL) then
  begin
    LEvnt.mi.dwFlags := MOUSEEVENTF_WHEEL;
  end
  else if (LMsgType = WM_MOUSEMOVE) then
  begin
    LEvnt.mi.dwFlags := MOUSEEVENTF_MOVE or MOUSEEVENTF_ABSOLUTE;
  end;

  if FFirstEvent then
  begin
    FStartTime := PMsgBuff^[FMsgCount].mi.time;
    PMsgBuff^[FMsgCount].mi.time := 0;
    FFirstEvent := false;
  end
  else
    Dec(PMsgBuff^[FMsgCount].mi.time, FStartTime);

  AddInput2MsgBuff(LEvnt);
end;

procedure TMacroManageF.AddMouseEvent2SIHelper(Message: TMessage);
var
//  LEvnt: TInput;
  LMsgType: Cardinal;
  LMouseHook: TLowLevelMouseHook;
begin
  LMouseHook := PLowLevelMouseHook(Message.LParam)^;
  LMsgType := Message.WParam;

  with FSendInputHelper do
  begin
    if (LMsgType = WM_LBUTTONDOWN) or (LMsgType = WM_LBUTTONDBLCLK) then
      AddMouseClick(mbLeft, True, False)
    else if (LMsgType = WM_RBUTTONDOWN) or (LMsgType = WM_RBUTTONDBLCLK) then
      AddMouseClick(mbRight, True, False)
    else if (LMsgType = WM_MBUTTONDOWN) or (LMsgType = WM_MBUTTONDBLCLK) then
      AddMouseClick(mbMiddle, True, False)
    else if (LMsgType = WM_LBUTTONUP) then
      AddMouseClick(mbLeft, False, True)
    else if (LMsgType = WM_RBUTTONUP) then
      AddMouseClick(mbRight, False, True)
    else if (LMsgType = WM_MBUTTONUP) then
      AddMouseClick(mbMiddle, False, True)
//    else if (LMsgType = WM_MOUSEWHEEL) then
    else if (LMsgType = WM_MOUSEMOVE) then
      AddAbsoluteMouseMove(LMouseHook.HookStruct.Pt.X, LMouseHook.HookStruct.Pt.Y)
  end;
end;

procedure TMacroManageF.AlarmFromTo1AlarmBegin(Sender: TObject);
begin
  PlayMacro;
end;

procedure TMacroManageF.ApplyCommandLineOption;
begin
  if FCommandLine.MacroFileName <> '' then
  begin
    LoadMacroFromFile(FCommandLine.MacroFileName);
    DisplayMacroToGrid;
  end;

  if FCommandLine.NoScreenSaver then
    NoScreenSaverCheck.Checked := FCommandLine.NoScreenSaver;

  if FCommandLine.CheckExecuteTime then
    BeginTimeCheck.Checked := FCommandLine.CheckExecuteTime;

  if FCommandLine.SetExecuteTime <> '' then
    BeginTimePicker.Time := StrToDateTime(FCommandLine.SetExecuteTime);//, 'hh:mm:ss');

  if FCommandLine.AutoExecute then
    FPJHTimerPool.AddOneShot(OnAutoExecuteMacro,5000);
end;

procedure TMacroManageF.AssignActionData2Form(ASrcActColl,
  ADestActColl: TActionCollection; var ADestActList: TActionList);
var
  i: integer;
begin
  if Assigned(ADestActColl) then
  begin
    ADestActColl.Clear;
    CopyActionCollect(ASrcActColl, ADestActColl);
    CopyActionColl2ActionList(ASrcActColl, ADestActList);
  end;

//  for i := 0 to ASrcActColl.Count - 1 do
//  begin
//    TActionItem.AddActionItem2List(ADestActList, ASrcActColl.Item[i].ActionItem);
//  end;
end;

procedure TMacroManageF.AssignDynMsg2Grid(AMacroArray: TMacroArray);
var
  i, j, LRow: integer;
  LMacroCol: TMacroCollection;
begin
  NGFrame.NextGrid1.BeginUpdate;
  try
    NGFrame.NextGrid1.ClearRows;

    for i := Low(AMacroArray) to High(AMacroArray) do
    begin
      LMacroCol := AMacroArray[i];

      for j := 0 to LMacroCol.Count - 1 do
      begin
        LRow := NGFrame.NextGrid1.AddRow();
        NGFrame.NextGrid1.CellsByName['ItemName', LRow] := LMacroCol.Item[j].MacroItem.ItemName;
        NGFrame.NextGrid1.CellsByName['Value', LRow] := LMacroCol.Item[j].MacroItem.ItemValue;
      end;
    end;
  finally
    NGFrame.NextGrid1.EndUpdate;
  end;
end;

procedure TMacroManageF.AssignInput2ActionList(AInput: TInput;
  AMacroManage: TMacroManagement);
var
  LItem: TActionItem;
  LActions: TActions;
begin
  LItem := TActionItem.Create;
  try
    LActions := AMacroManage.ActionCollect.Add;
    ConvertInput2ActionItem(AInput, LItem);
    LActions.AssignActionItem2(LItem);
    TActionItem.AddActionItem2List(AMacroManage.FActionList, LItem);
  finally
    LItem.Free;
  end;
end;

procedure TMacroManageF.AssignInputTo(var AInputs: array of TInput);
var
  i: integer;
begin
  for i := Low(AInputs) to High(AInputs) do
  begin
    AInputs[i] := PMsgBuff^[i];
  end;
end;

procedure TMacroManageF.AssignSIHelper2ActionColl(AIndex: integer);
var
  LMacroManagement: TMacroManagement;
  Input: TInput;
begin
  LMacroManagement := FMacroManageList.Items[AIndex] as TMacroManagement;

  for Input in FSendInputHelper do
  begin
    AssignInput2ActionList(Input, LMacroManagement);
  end;
end;

procedure TMacroManageF.BeginTimeCheckClick(Sender: TObject);
begin
  BeginTimePicker.Enabled := BeginTimeCheck.Checked;

  if BeginTimeCheck.Checked then
    AlarmFromTo1.AlarmTimeBegin := FormatDateTime('hh:nn:ss', BeginTimePicker.Time);

  AlarmFromTo1.ActiveBegin := BeginTimeCheck.Checked;
end;

procedure TMacroManageF.BeginTimePickerChange(Sender: TObject);
begin
  AlarmFromTo1.AlarmTimeBegin := FormatDateTime('hh:nn:ss', BeginTimePicker.Time);
end;

procedure TMacroManageF.btnRecorderClick(Sender: TObject);
begin
  ToggleRecording;

  if btnRecorder.Caption = '매크로 기록' then
  begin
    if FHookStarted then
      btnRecorder.Caption := '기록 멈춤';
  end
  else
  begin
    if not FHookStarted then
      btnRecorder.Caption := '매크로 기록';

    if not FHookStarted then
    begin
      SaveMacroRecord();
//      DestroyMsgBuf();
    end;
  end;
end;

procedure TMacroManageF.btnSequenceClick(Sender: TObject);
begin
  FActionStepEnable := False;
  PlayMacro;
end;

procedure TMacroManageF.btnStopClick(Sender: TObject);
begin
  StopMacro;
end;

procedure TMacroManageF.Button1Click(Sender: TObject);
begin
  AddMacroName(MacroNameEdit.Text);
//  AddMacroTest2;
end;

procedure TMacroManageF.Button3Click(Sender: TObject);
var
  i: integer;
  LNameEditF: TNameEditF;
  LMacroManagement: TMacroManagement;
begin
  i := MacroGrid.SelectedRow;

  if i < 0 then
    exit;

  LNameEditF := TNameEditF.Create(nil);
  try
    LNameEditF.Edit1.Text := MacroGrid.CellByName['Macroname', i].AsString;

    if LNameEditF.ShowModal = mrOK then
    begin
      LMacroManagement := FMacroManageList.Items[i] as TMacroManagement;
      LMacroManagement.MacroName := LNameEditF.Edit1.Text;
      MacroGrid.CellByName['Macroname', i].AsString := LNameEditF.Edit1.Text;
    end;

  finally
    LNameEditF.Free;
  end;
end;

procedure TMacroManageF.Button6Click(Sender: TObject);
begin
  AddActionFromForm;
end;

procedure TMacroManageF.NoScreenSaverCheckClick(Sender: TObject);
begin
  SystemCritical.IsCritical := NoScreenSaverCheck.Checked;
//  Timer1.Enabled := CheckBox1.Checked;
end;

procedure TMacroManageF.ChangeMacroName1Click(Sender: TObject);
var
  LIdx: integer;
  LStr: string;
begin
  LStr := CreateInputEdit('Macro Name Edit','Macro Name','');

  if LStr <> '' then
  begin
    LIdx := MacroGrid.SelectedRow;
    FMacroManageList.ChangeMacroNameFromIndex(LIdx, LStr);
    MacroGrid.CellsByName['MacroName', LIdx] := LStr;
  end;
end;

function TMacroManageF.CheckNReSetRegistryForEnableLUA: boolean;
var
  LReg: TRegistry;
  LValue: integer;
begin
  Result := False;
  LReg := TRegistry.Create(KEY_READ or KEY_WRITE);

  try
    LReg.RootKey := HKEY_LOCAL_MACHINE;
    LReg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\System\', False);
    LValue := LReg.ReadInteger('EnableLUA');

    if LValue = 0 then
      if FNeedResetRegistry4EnableLUA then
        LReg.WriteInteger('EnableLUA', 1);

    Result := True;
  finally
    LReg.CloseKey;
    LReg.Free;
  end;
end;

function TMacroManageF.CheckNSetRegistryForEnableLUA: boolean;
var
  LReg: TRegistry;
  LValue: integer;
begin
  Result := False;
  LReg := TRegistry.Create(KEY_READ or KEY_WRITE);

  try
    LReg.RootKey := HKEY_LOCAL_MACHINE;
    LReg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\System\', False);
    LValue := LReg.ReadInteger('EnableLUA');

    FNeedResetRegistry4EnableLUA := LValue <> 0;

    if FNeedResetRegistry4EnableLUA then
      LReg.WriteInteger('EnableLUA', 0);

    Result := True;
  finally
    LReg.CloseKey;
    LReg.Free;
  end;
end;

procedure TMacroManageF.ClearMacro;
begin
  FMacroManageList.ClearObject;
  ClearMacroFromGrid;
end;

procedure TMacroManageF.ClearMacroFromGrid;
begin
  MacroGrid.ClearRows;
  ListBox1.Clear;
  NGFrame.NextGrid1.ClearRows;
  ActionLB.Clear;
end;

function TMacroManageF.CommandLineParse: string;
var
  LStr: string;
  LResult: Boolean;
begin
  Result := '';

  if not Assigned(FCommandLine) then
    FCommandLine := TMacroCommandLineOption.Create;
  try
//      CommandLineParser.Options := [opIgnoreUnknownSwitches];
    LResult := CommandLineParser.Parse(FCommandLine);
  except
    on E: ECLPConfigurationError do begin
      Result := '*** Configuration error ***' + #13#10 +
        Format('%s, position = %d, name = %s',
          [E.ErrorInfo.Text, E.ErrorInfo.Position, E.ErrorInfo.SwitchName]);
      Exit;
    end;
  end;

  if not LResult then
  begin
    Result := Format('%s, position = %d, name = %s',
      [CommandLineParser.ErrorInfo.Text, CommandLineParser.ErrorInfo.Position,
       CommandLineParser.ErrorInfo.SwitchName]) + #13#10;

    for LStr in CommandLineParser.Usage do
      Result := Result + LStr + #13#10;
  end
  else
  begin
  end;
end;

procedure TMacroManageF.CommportConfig1Click(Sender: TObject);
var
  LResult: integer;
begin
  CreateCommThread();

  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);

  if OpenDialog1.Execute(Handle) then
  begin
    FCommConfigFileName := OpenDialog1.FileName;
  end
  else
    FCommConfigFileName := ChangeFileExt(Application.ExeName,'.scomm');

  FSerialCommThread.ConfigFileName := FCommConfigFileName;

  LResult := CreateSerialCommConfigForm(FSerialCommThread);

  //Serial Comm 설정값이 변경된 경우(확인 버튼을 누름)
  if LResult = 1 then
  begin
    SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName);

    if SaveDialog1.Execute then
    begin
      FCommConfigFileName := SaveDialog1.FileName;
      FSerialCommThread.ConfigFileName := FCommConfigFileName;
      FSerialCommThread.SaveSerialCommConfig2File(FCommConfigFileName);
    end;
  end;

  FSerialCommThread.ResetCommport();
end;

procedure TMacroManageF.Config1Click(Sender: TObject);
begin
  SetEventCaptureConfig();
end;

procedure TMacroManageF.ConvertInput2ActionItem(AInput: TInput;
  AActionItem: TActionItem);
begin
  case AInput.Itype of
    INPUT_MOUSE: begin
      AActionItem.ActionCode := TActionTypeHelper.GetActionCodeFromInputFlags(AInput.mi.dwFlags);
      AActionItem.ActionType := TActionTypeHelper.GetActionTypeFromDesc(AActionItem.ActionCode);
      AActionItem.ActionDesc := AActionItem.ActionCode;

      case AActionItem.ActionType of
        atMousePos: begin
          AActionItem.XPos := Round(AInput.mi.dx/($FFFF/Screen.DesktopRect.Size.cx));
          AActionItem.YPos := Round(AInput.mi.dy/($FFFF/Screen.DesktopRect.Size.cy));
          AActionItem.ActionDesc := AActionItem.ActionDesc + '(X:' +
            IntToStr(AActionItem.XPos) + ', Y:' +IntToStr(AActionItem.YPos)+ ')';
        end;
        atMouseLClick, atMouseLDClick, atMouseRClick, atMouseRDClick:
        begin

        end;
      end;//case
    end;
    INPUT_KEYBOARD: begin
    end;
    INPUT_HARDWARE:begin
    end;
  end;//case

  AActionItem.InputText := '';
  AActionItem.WaitSec := 0;
  AActionItem.GridIndex := -1;
  AActionItem.CustomDesc := '';
  AActionItem.ExecMode := TExecuteMode(0);
end;

procedure TMacroManageF.CopySIHelperNInsertDelay(
  var ADestSIHelper: TSendInputHelper; ADelay: Cardinal);
var
  Input: TInput;
begin
  for Input in FSendInputHelper do
  begin
    ADestSIHelper.Add(Input);
    ADestSIHelper.AddDelay(ADelay);
  end;
end;

procedure TMacroManageF.CreateCommThread(AIsReset: Boolean);
begin
  if not Assigned(FSerialCommThread) then
    FSerialCommThread := TSerialCommThread.Create(TForm(Self), INFINITE);

  FSerialCommThread.Resume;

//  if AIsReset then
//
//  if FSerialCommThread.CommPort.Connected then
//    exit;
//
//  if not FSerialCommThread.LoadCommPortFromFile() then
//  begin
//    SetSerialCommConfig();
//  end
end;

procedure TMacroManageF.CreateEvents(manualReset: boolean; ANoOfEvent: integer);
var
  i: integer;
begin
  SetLength(FMacroStepHandles, ANoOfEvent);
  SetLength(FActionStepHandles, ANoOfEvent);

  for i := Low(FMacroStepHandles) to High(FMacroStepHandles) do
    FMacroStepHandles[i] := CreateEvent(nil, manualReset, false, nil);

  FMacroStepWaiter := TWaitFor.Create(FMacroStepHandles);

  for i := Low(FActionStepHandles) to High(FActionStepHandles) do
    FActionStepHandles[i] := CreateEvent(nil, manualReset, false, nil);

  FActionStepWaiter := TWaitFor.Create(FActionStepHandles);
end;

procedure TMacroManageF.CreateNewMacro;
begin
  if FMacroManageList.Count > 0 then
  begin
    if MessageDlg('Are you sure to create new Macro?', mtConfirmation, mbOKCancel, 0) = mrCancel then
    begin
      exit;
    end;
  end;

  ClearMacro;
  AddMacroName;
end;

procedure TMacroManageF.CreateSendInputHelper;
begin
  if not Assigned(FSendInputHelper) then
    FSendInputHelper := TSendInputHelper.Create;
end;

procedure TMacroManageF.DeleteMacroItemName(AIdx: integer);
begin
  if ListBox1.ItemIndex >= 0 then
  begin
//    list.Remove(list.Items[ListBox1.ItemIndex]);
//    FActionCollection.Delete(ListBox1.ItemIndex);
    ListBox1.Items.Delete(ListBox1.ItemIndex);
  end;
end;

procedure TMacroManageF.DeleteMacroname(AIdx: integer);
var
  LMacroManagement: TMacroManagement;
begin
  if MessageDlg('Are you sure to delete selected Macro?', mtConfirmation, mbOKCancel, 0) = mrOK then
  begin
    LMacroManagement := FMacroManageList.Items[AIdx] as TMacroManagement;
//    LMacroManagement.MacroCollect.Free;
//    LMacroManagement.ActionCollect.Free;
    LMacroManagement.FActionList.Free;
    FMacroManageList.Delete(AIdx);
//    LMacroManagement.Free;
    MacroGrid.DeleteRow(AIdx);
    NGFrame.NextGrid1.ClearRows;
    ActionLB.Items.Clear;
  end;
end;

procedure TMacroManageF.DestroyCommThread;
begin
  if FSerialCommThread.Suspended then
    FSerialCommThread.Resume;

  FSerialCommThread.FSendEvent.Signal;
  FSerialCommThread.FReceiveEvent.Signal;
  FSerialCommThread.Terminate;
end;

procedure TMacroManageF.DestroyEvents;
var
  i: integer;
begin
  FreeAndNil(FMacroStepWaiter);
  FreeAndNil(FActionStepWaiter);

  for i := Low(FMacroStepHandles) to High(FMacroStepHandles) do
    if FMacroStepHandles[i] <> 0 then
      Win32Check(CloseHandle(FMacroStepHandles[i]));

  for i := Low(FActionStepHandles) to High(FActionStepHandles) do
    if FActionStepHandles[i] <> 0 then
      Win32Check(CloseHandle(FActionStepHandles[i]));
end;

procedure TMacroManageF.DestroyHook;
begin
  //FKeyBdHook변수가 record Type 이라서 자동 Free됨
  //따라서 명시적으로 Free 할 필요가 없음, Free하면 이중 Free가 되어 Error 발생함
  if Assigned(FKeyBdHook) then
    FKeyBdHook.Free;

  if Assigned(FMouseHook) then
    FMouseHook.Free;
end;

procedure TMacroManageF.DestroyMsgBuf;
begin
  if Assigned(PMsgBuff) then
  begin
    FreeMem(PMsgBuff, Sizeof(TMsgBuff));
    PMsgBuff := nil;
  end;
end;

procedure TMacroManageF.DestroySendInputHelper;
begin
  if Assigned(FSendInputHelper) then
  begin
    FSendInputHelper.Flush;
    FSendInputHelper.Free;
  end;
end;

procedure TMacroManageF.DisplayMacroToGrid(AName: string);
var
  i, LRow: integer;
  LMacroManagement: TMacroManagement;
begin
  MacroGrid.BeginUpdate;
  try
    MacroGrid.ClearRows;
    NGFrame.NextGrid1.ClearRows;
    ActionLB.Items.Clear;

    for i := 0 to FMacroManageList.Count - 1 do
    begin
      LMacroManagement := FMacroManageList.Items[i] as TMacroManagement;
      LRow := MacroGrid.AddRow;
      MacroGrid.CellByName['Macroname', LRow].AsString := LMacroManagement.MacroName;
      MacroGrid.CellByName['IsExecute', LRow].AsBoolean := LMacroManagement.IsExecute;
      MacroGrid.CellByName['RepeatCount', LRow].AsInteger := LMacroManagement.IterateCount;

      AssignActionData2Form(LMacroManagement.ActionCollect,nil,
        LMacroManagement.FActionList);
      AssignDynMsg2Grid(LMacroManagement.MacroArray);
    end;
  finally
    MacroGrid.EndUpdate;
  end;
end;

procedure TMacroManageF.IsExecuteSetCell(Sender: TObject; ACol, ARow: Integer;
  CellRect: TRect; CellState: TCellState);
var
  LMacroManagement: TMacroManagement;
begin
  LMacroManagement := FMacroManageList.Items[ARow] as TMacroManagement;
  LMacroManagement.IsExecute := MacroGrid.CellByName['IsExecute', ARow].AsBoolean;
end;

procedure TMacroManageF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FHookStarted then
    btnRecorderClick(btnRecorder);
end;

procedure TMacroManageF.FormCreate(Sender: TObject);
var
  LErrMsg: string;
begin
  InitHotKey;
  FMacroStepQueue := TOmniMessageQueue.Create(1);
  FActionStepQueue := TOmniMessageQueue.Create(1);
  CreateEvents(False, 2);
  FMacroManageList := TMacroManagements.Create;
  FMacroManageList.OwnsObjects := True;
  TJSONSerializer.RegisterClassForJSON([TMacroManagement, TActions, TMacros, TActionItem, TMacroItem]);
  g_DynGetMessage := GetMsgFromGrid;
  FPJHTimerPool := TPJHTimerPool.Create(nil);
  FEventCaptureConfig := TEventCaptureConfig.Create(FEventCaptureConfigFileName);
  FKeyBdHook := nil;
  FMouseHook := nil;
  CreateSendInputHelper();

  LErrMsg := CommandLineParse;

  if LErrMsg = '' then
  begin
   ApplyCommandLineOption;
  end;
end;

procedure TMacroManageF.FormDestroy(Sender: TObject);
var
  i, j: integer;
begin
  FPJHTimerPool.RemoveAll;
  FPJHTimerPool.Free;
  FCommandLine.Free;
  FEventCaptureConfig.Free;

  for i := 0 to FMacroManageList.Count - 1 do
  begin
//    TMacroManagement(FMacroManageList.Items[i]).FActionList.Free;
//    TMacroManagement(FMacroManageList.Items[i]).Free;
//    for j := 0 to TMacroManagement(FMacroManageList.Items[i]).ActionCollect.Count - 1 do
//    begin
//      TMacroManagement(FMacroManageList.Items[i]).ActionCollect.Item[j].Free;
//    end;
  end;

//  FMacroManageList.Clear;
  FMacroManageList.Free;

  if Assigned(FSerialCommThread) then
    DestroyCommThread;

  FreeAndNil(FMacroStepQueue);
  FreeAndNil(FActionStepQueue);
  DestroyEvents;
  DestroyMsgBuf();
  DestroySendInputHelper();
//  DestroyHook;
end;

procedure TMacroManageF.GetMsgFromGrid(AIndex: integer; var AMsg: string);
begin
  if AIndex > 0  then
  begin
    Dec(AIndex);
    AMsg := NGFrame.NextGrid1.CellByName['Value', AIndex].AsString;
  end;
end;

function TMacroManageF.GetMsgKindFromMsg(AMsg: Cardinal): TMsgKind;
begin
  if (AMsg = WM_MOUSEMOVE) or
     (AMsg = WM_LBUTTONDOWN) or
     (AMsg = WM_LBUTTONDBLCLK) or
     (AMsg = WM_LBUTTONUP) or
     (AMsg = WM_RBUTTONDOWN) or
     (AMsg = WM_RBUTTONUP) or
     (AMsg = WM_RBUTTONDBLCLK) or
     (AMsg = WM_MBUTTONDOWN) or
     (AMsg = WM_MBUTTONUP) or
     (AMsg = WM_MBUTTONDBLCLK) or
     (AMsg = WM_MOUSEWHEEL) then
  begin
    Result := mkMouse;
  end
  else
  if (AMsg = WM_KEYDOWN) or (AMsg = WM_KEYUP) then
  begin
    Result := mkKeyBd;
  end
  else
    Result := mkUnKnown;
end;

procedure TMacroManageF.HotKeyManager1HotKeyPressed(HotKey: Cardinal; Index: Word);
var
  s: string;
  LMsg: TOmniMessage;
begin
  s := HotKeyManager1.GetCommand(Index);

  if s = MACRO_MOUSE_POS then
  begin
    if Assigned(FfrmActions) then
    begin
      if FfrmActions.FCurrentActionType = atMousePos then
      begin
        FfrmActions.FIsUpdateMousePos := not FfrmActions.FIsUpdateMousePos;
//        ShowMessage('FIsUpdateMousePos is ' + BoolToStr(FfrmActions.FIsUpdateMousePos));
      end;
    end;
  end
  else
  if s = MACRO_START then
  begin

  end
  else
  if s = MACRO_ONE_STEP then
  begin
    WinApi.Windows.PulseEvent(FActionStepHandles[0]);

    if FActionStepEnable then
    begin
      StepEnque(2);//Action Step
    end;
  end
  else
  if s = MACRO_STOP then
  begin
    StopMacro;
  end;
end;

procedure TMacroManageF.InitHotKey;
var
  HotKeyVar: Cardinal;
  Modifiers: Word;
begin
  //Ctrl + Alt + F5 = Macro Start
  HotKeyVar := HotKeyManager.GetHotKey(MOD_CONTROL + MOD_ALT, VK_F5);
  HotKeyManager1.AddHotKey(HotKeyVar, MACRO_START);

  //Ctrl + Alt + F6 = Macro Start One-Step
  HotKeyVar := HotKeyManager.GetHotKey(MOD_CONTROL + MOD_ALT, VK_F6);
  HotKeyManager1.AddHotKey(HotKeyVar, MACRO_ONE_STEP);

  //Ctrl + Alt + F7 = Macro Stop
  HotKeyVar := HotKeyManager.GetHotKey(MOD_CONTROL + MOD_ALT, VK_F7);
  HotKeyManager1.AddHotKey(HotKeyVar, MACRO_STOP);

  //Ctrl + Space = Mouse Move Update Stop
  HotKeyVar := HotKeyManager.GetHotKey(MOD_CONTROL, VK_SPACE);
  HotKeyManager1.AddHotKey(HotKeyVar, MACRO_MOUSE_POS);
end;

procedure TMacroManageF.LoadActionFromFile1Click(Sender: TObject);
begin
  if OpenDialog1.Execute(Handle) then
  begin
    LoadMacroFromFile(OpenDialog1.FileName, True);
    DisplayMacroToGrid;
  end;
end;

procedure TMacroManageF.LoadEventCaptureConfigFromFile(AFileName: string);
begin
  FEventCaptureConfig.Load(AFileName);
end;

procedure TMacroManageF.LoadEventCaptureConfigFromFile1Click(Sender: TObject);
begin
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);
  OpenDialog1.FileName := FEventCaptureConfigFileName;

  if OpenDialog1.Execute(Handle) then
  begin
    FEventCaptureConfigFileName := OpenDialog1.FileName;
    LoadEventCaptureConfigFromFile(FEventCaptureConfigFileName);
  end;
end;

procedure TMacroManageF.LoadFromFile1Click(Sender: TObject);
begin
  LoadSIHFromFile();
end;

function TMacroManageF.LoadInputFromFile(AFileName: string): Boolean;
var
  ST1, ST2: TStringList;
  i,j: integer;
begin
  if not FileExists (AFileName) then
    Exit;

  DestroyMsgBuf();
  CreateMsgBuf();

  ST1 := TStringList.Create;
  ST2 := TStringList.Create;

  try
    ST2.LoadFromFile(AFileName);
    ST1.CommaText := ST2[0];
    FMsgCount := strtoint(ST1.Values['MessageCount']);

    for i := 1 to ST2.Count - 1 do
    begin
      j := i-1;
      ST1.Clear;
      ST1.CommaText := ST2[i];
      PMsgBuff[j].Itype := StrToInt(ST1.Values[ST1.Names[0]]);

      case PMsgBuff[j].Itype of
        INPUT_MOUSE: begin
          PMsgBuff[j].mi.dx := StrToInt(ST1.Values['X']);
          PMsgBuff[j].mi.dy := StrToInt(ST1.Values['Y']);
          PMsgBuff[j].mi.mouseData := StrToInt(ST1.Values['MouseData']);
          PMsgBuff[j].mi.dwFlags := StrToInt(ST1.Values['Flags']);
          PMsgBuff[j].mi.time := StrToInt(ST1.Values['Time']);
          PMsgBuff[j].mi.dwExtraInfo := StrToInt(ST1.Values['ExtraInfo']);
        end;
        INPUT_KEYBOARD: begin
//          PMsgBuff[j].ki.wVk := StringToKey(ST1.Values['wVk']);
          PMsgBuff[j].ki.wVk := StrToInt(ST1.Values['wVk']);
          PMsgBuff[j].ki.dwFlags := StrToInt(ST1.Values['Flags']);
          PMsgBuff[j].ki.wScan := StrToInt(ST1.Values['ScanCode']);
          PMsgBuff[j].ki.time := StrToInt(ST1.Values['Time']);
          PMsgBuff[j].ki.dwExtraInfo := StrToInt(ST1.Values['ExtraInfo']);
        end;
        INPUT_HARDWARE:begin
        end;
      end;
    end;
  finally
    ST1.Free;
    ST2.Free;
  end;
end;

procedure TMacroManageF.LoadMacroFromFile(AFileName: string; AIsAppend: Boolean);
var
  LMacroManageList: TMacroManagements;
  i: integer;
  LPath: string;
begin
  if AFileName = '' then
    exit;

  LPath := ExtractFilePath(AFileName);
  AFileName := ExtractFileName(AFileName);

  if LPath = '' then
    LPath := ExtractFilePath(Application.ExeName);

  if AIsAppend then
  begin
    LMacroManageList := TMacroManagements.Create;
    try
      LMacroManageList.LoadFromJSONFile(LPath+AFileName);

      for i := 0 to LMacroManageList.Count - 1 do
      begin
        FMacroManageList.AddMacro2List(TMacroManagement(LMacroManageList.Items[i]));
      end;
    finally
      LMacroManageList.Free;
    end;
  end
  else
  begin
    FMacroManageList.LoadFromJSONFile(LPath+AFileName);

    for i := 0 to FMacroManageList.Count - 1 do
      TMacroManagement(FMacroManageList.Items[i]).SetActionColl2ActionList;
  end;
end;

function TMacroManageF.LoadSIHelperListFromFile(AFileName: string): Boolean;
var
  ST1, ST2: TStringList;
  i: integer;
  LInput: TInput;
begin
  if not FileExists (AFileName) then
    Exit;

  FSendInputHelper.Clear;
  ST1 := TStringList.Create;
  ST2 := TStringList.Create;

  try
    ST2.LoadFromFile(AFileName);
    ST1.CommaText := ST2[0];
    FMsgCount := strtoint(ST1.Values['MessageCount']);

    for i := 1 to ST2.Count - 1 do
    begin
      ST1.Clear;
      ST1.CommaText := ST2[i];
      LInput.Itype := StrToInt(ST1.Values[ST1.Names[0]]);

      case LInput.Itype of
        INPUT_MOUSE: begin
          LInput.mi.dx := StrToInt(ST1.Values['X']);
          LInput.mi.dy := StrToInt(ST1.Values['Y']);
          LInput.mi.mouseData := StrToInt(ST1.Values['MouseData']);
          LInput.mi.dwFlags := StrToInt(ST1.Values['Flags']);
          LInput.mi.time := StrToInt(ST1.Values['Time']);
          LInput.mi.dwExtraInfo := StrToInt(ST1.Values['ExtraInfo']);
        end;
        INPUT_KEYBOARD: begin
//          LInput.ki.wVk := GetVKeyFromChar(ST1.Values['wVk']);
          LInput.ki.wVk := StrToInt(ST1.Values['wVk']);
          LInput.ki.dwFlags := StrToInt(ST1.Values['Flags']);
          LInput.ki.wScan := StrToInt(ST1.Values['ScanCode']);
          LInput.ki.time := StrToInt(ST1.Values['Time']);
          LInput.ki.dwExtraInfo := StrToInt(ST1.Values['ExtraInfo']);
        end;
        INPUT_HARDWARE:begin
        end;
      end;//case

      FSendInputHelper.Add(LInput);
    end;
  finally
    ST1.Free;
    ST2.Free;
  end;
end;

procedure TMacroManageF.LoadSIHFromFile;
begin
  OpenDialog1.Filter := 'SendInputHelper files (*.sih)|*.sih|Any file (*.*)|*.*';
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);

  if OpenDialog1.Execute() then
  begin
//    LoadInputFromFile(OpenDialog1.FileName);
    LoadSIHelperListFromFile(OpenDialog1.FileName);
  end;
end;

procedure TMacroManageF.MouseClickAction4HW;
begin
  CreateCommThread();

  if FSerialCommThread.IsCommportInitialized then
  begin
    FSerialCommThread.SendString('LCLICK');
  end;
end;

procedure TMacroManageF.MacroGridAfterEdit(Sender: TObject; ACol, ARow: Integer;
  Value: WideString);
begin
;
end;

procedure TMacroManageF.MacroGridSelectCell(Sender: TObject; ACol,
  ARow: Integer);
var
  Idx: integer;
begin
  Idx := MacroGrid.SelectedRow;

  if Idx >= 0 then
    SelectMacroItem(idx);
end;

procedure TMacroManageF.NGFramebtnAddRowClick(Sender: TObject);
begin
  if MacroGrid.SelectedRow < 0 then
  begin
    ShowMessage('Select Macro Name first!');
    exit;
  end;

  NGFrame.btnAddRowClick(Sender);
  NGFrame.NextGrid1.EditCell(0, NGFrame.NextGrid1.LastAddedRow);
end;

procedure TMacroManageF.NGFrameToolButton21Click(Sender: TObject);
var
  i, j, LRow: integer;
  LMacroManagement: TMacroManagement;
  LMacros: TMacros;
  LActions: TActions;
begin
  j := MacroGrid.SelectedRow;

  if j < 0 then
  begin
    ShowMessage('Select Macro Name!');
    exit;
  end
  else
  begin
    LMacroManagement := FMacroManageList.Items[j] as TMacroManagement;
//    LMacroManagement.MacroCollect.Clear;
  end;

  for i := 0 to NGFrame.NextGrid1.RowCount - 1 do
  begin
    LMacros := LMacroManagement.MacroArrayAdd;
    LMacros.MacroItem.ItemName := NGFrame.NextGrid1.CellByName['Itemname', i].AsString;
    LMacros.MacroItem.ItemValue := NGFrame.NextGrid1.CellByName['Value', i].AsString;
  end;
end;

procedure TMacroManageF.OnAutoExecuteMacro(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
begin
  FActionStepEnable := False;
  PlayMacro;
end;

procedure TMacroManageF.PlayInputMacro;
var
  LDynInputs: array of TInput;
  LSendInputHelper: TSendInputHelper;
begin
//  SetLength(LDynInputs, FSendInputHelper.Count);
//  AssignInputTo(LDynInputs);
//  FSendInputHelper.AddAbsoluteMouseMove(848, 328);
//  FSendInputHelper.AddMouseClick(mbLeft);
//  SendInput(Length(LDynInputs), LDynInputs[0], SizeOf(TInput));

  LSendInputHelper := TSendInputHelper.Create;
  try
    CopySIHelperNInsertDelay(LSendInputHelper, 50);
    LSendInputHelper.Flush;
  finally
    LSendInputHelper.Free;
  end;
end;

procedure TMacroManageF.PlayInputMacro1Click(Sender: TObject);
begin
  PlayInputMacro();
end;

procedure TMacroManageF.PlayMacro;
var
  LActionList: TActionList;
  LMsg: TOmniMessage;
  Li, LTimes: integer;
begin
  btnSequence.Enabled := false;
  FMacroCancelToken := CreateOmniCancellationToken;
  FWorker := Parallel.ForEach(0,FMacroManageList.Count-1)
    .CancelWith(FMacroCancelToken)
    .NumTasks(1)
    .PreserveOrder
    .NoWait
    .OnStop(
      procedure (const task: IOmniTask)
      begin
        // because of NoWait, OnStop delegate is invoked from the worker code; we must not destroy the worker at that point or the program will block
        task.Invoke(
          procedure begin
            btnSequence.Enabled := true;
            //ShowMessage('Macro Stopped!');
          end
        );
      end
    );

  FWorker.Execute(
    procedure (const task: IOmniTask; const i: integer)
    var
      Li: integer;
    begin
      if TMacroManagement(FMacroManageList.Items[i]).IsExecute then
      begin
        LActionList := TMacroManagement(FMacroManageList.Items[i]).FActionList;
        LTimes := TMacroManagement(FMacroManageList.Items[i]).IterateCount;
        //ShowMessage(TMacroManagement(FMacroManageList.Items[i]).MacroName+':'+IntToStr(i));
        if Assigned(LActionList) then
          PlaySequence(LActionList,LTimes);

//        if FMacroStepQueue.TryDequeue(LMsg) then
//        begin
//          if LMsg.MsgData.AsInteger = 1 then //0: No Step, 1: Macro Step
          if FMacroStepEnable then
            WaitForAny(FMacroStepWaiter, 10000, waAwaited, '');
//        end;
      end;
    end
  );
end;

procedure TMacroManageF.PlayMacroFromRecord;
var
  LActionList: TActionList;
  LMsg: TOmniMessage;
  Li, LTimes: integer;
begin
//  btnSequence.Enabled := false;
//  FMacroCancelToken := CreateOmniCancellationToken;
//  FWorker2 := Parallel.ForEach<pointer>(FMacroManageList.GetEnumerator)
//    .CancelWith(FMacroCancelToken)
//    .NoWait
//    .OnStop(
//      procedure (const task: IOmniTask)
//      begin
//        task.Invoke(
//          procedure begin
//            btnSequence.Enabled := true;
//            ShowMessage('Macro Stopped!');
//          end
//        );
//      end
//    );
//
//  FWorker2.Execute(
//    procedure (const task: IOmniTask; const AObj: pointer)
//    var
//      Li: integer;
//    begin
//      if TMacroManagement(AObj).IsExecute then
//      begin
//        LActionList := TMacroManagement(AObj).FActionList;
//        LTimes := TMacroManagement(AObj).IterateCount;
//        ShowMessage(TMacroManagement(AObj).MacroName+':'+IntToStr(i));
//        if Assigned(LActionList) then
//          PlaySequence(LActionList,LTimes);
//
//        if FMacroStepQueue.TryDequeue(LMsg) then
//        begin
//          if LMsg.MsgData.AsInteger = 1 then //0: No Step, 1: Macro Step
//            WaitForAny(FMacroStepWaiter, 10000, waAwaited, '');
//        end;
//      end;
//    end
//  );
end;

procedure TMacroManageF.PlayMacroRecordFromFile(AFileName: string);
begin
  if AFileName = '' then
  begin
    OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);

    if OpenDialog1.Execute then
      AFileName := OpenDialog1.FileName;
  end;

//  MacroRecorder1.FileName := AFileName;
//  MacroRecorder1.PlayMacro;
end;

procedure TMacroManageF.PlaySequence(AActionList: TActionList; ATimes: integer);
var
  i, j: Integer;
  action: IAction;
  LMsg: TOmniMessage;
  LIsVKDownStatus: Boolean;
  LPrevVKExtendKey: integer;
  LRec    : TMacroSignalEventRec;
  LExecuteMode: TExecuteMode;
begin
  if ATimes > 0 then
  begin
    for j := 0 to ATimes - 1 do
    begin
      LIsVKDownStatus := False;
      LPrevVKExtendKey := -1;

      for i := 0 to AActionList.Count - 1 do
      begin
        FLBpos := i;
        action := AActionList.Items[i];

        //이전 Action의 VKExtendKey(LPrevVKExtendKey)와 현재 Action의 VKExtendKey가 다르면
        //VKExtendKey 키 누름(Mouse Event 중 Extend Key가 눌려진 경우에만 사용됨)
        if action.GetVKExtendKey <> LPrevVKExtendKey then
        begin
          if (action.GetActionType = atDragEnd) then
          begin
            if (LIsVKDownStatus) then
            begin
              action.SetVKExtendKey(LPrevVKExtendKey);
              action.SetVKAction(2); //VKKey Key_Up
              LIsVKDownStatus := False;
            end;
          end
          else
          begin
            LPrevVKExtendKey := action.GetVKExtendKey;

            //VKKey가 Key_Down되었다가 Key_Up 된 경우
            if LPrevVKExtendKey = -1 then
            begin
              action.SetVKAction(2); //VKKey Key_Up
              LIsVKDownStatus := False;
            end
            else if LPrevVKExtendKey <> 0 then
            begin//VKKey가 Key_Down된 경우
              action.SetVKAction(1); //VKKey Key_Down
              LIsVKDownStatus := True;
            end;
          end;
        end
        else
        begin
          //Extend Key_Down상태에서 Mouse Drag가 끝난 경우 이전에 Key_Down을 Key_Up 해 줘야함
          if (action.GetActionType = atDragEnd) then
          begin
            if (LIsVKDownStatus) then
            begin
              action.SetVKExtendKey(LPrevVKExtendKey);
              action.SetVKAction(2); //VKKey Key_Up
            end;
          end
          else
          if LPrevVKExtendKey <> -1 then//이전 Action과 VKExtendKey값이 같으므로 VKExtendKey키를 누르지 않기 위해 -1을 할당함
            action.SetVKExtendKey(-1);
        end;

        LExecuteMode := action.GetExecMode();

        case LExecuteMode of
          emSWEvent,
          emDriver : action.Execute(LExecuteMode,True);
          emHardware: Action2HW(action);
        end;

        Sleep(10);//200
//        Application.ProcessMessages;
        if FBreak then
          break;

//        if FActionStepQueue.TryDequeue(LMsg) then
//        begin
//          LRec := LMsg.MsgData.ToRecord<TMacroSignalEventRec>;
//          LIsStep := LMsg.MsgData.AsInteger = 1;//0: No Step, 1: Action Step

          if FActionStepEnable then
          begin
            WaitForAny(FActionStepWaiter, 10000, waAwaited, '');
          end;
//        end;
      end;

      if FBreak then
        break;
    end;//for
  end
  else
  begin
    i := 0;

    while not FBreak do
    begin
      FLBpos := i;
      action := AActionList.Items[i];
      action.Execute;
      Sleep(200);
//      ListBox1.SetFocus;
//      Application.ProcessMessages;
//      Sleep(200);
      inc(i);
//      if (i > (ListBox1.Items.Count - 1)) then
//        i := 0;
    end;
  end;
end;

procedure TMacroManageF.RepeatCountSetCell(Sender: TObject; ACol, ARow: Integer;
  CellRect: TRect; CellState: TCellState);
var
  LMacroManagement: TMacroManagement;
begin
  LMacroManagement := FMacroManageList.Items[ARow] as TMacroManagement;
  LMacroManagement.IterateCount := MacroGrid.CellByName['RepeatCount', ARow].AsInteger;
end;

procedure TMacroManageF.SaveInput2File(AFileName: string);
var
  ST1, ST2: TStringList;
  i,p: integer;
  S: string;
//  LPoint: TPoint;
begin
  if PMsgBuff = nil then
    Exit;

  if AFileName = '' then
    exit;

  if FMsgCount > 0 then
  begin
    ST1 := TStringList.Create;
    ST2 := TStringList.Create;
    try
      ST1.Values['MessageCount'] := inttostr(FMsgCount);
      ST2.Add(ST1.CommaText);
      S := '';

      for i := 0 to FMsgCount - 1 do
      begin
        ST1.Clear;

        case PMsgBuff[i].Itype of
          INPUT_MOUSE: S := 'INPUTMOUSE';
          INPUT_KEYBOARD: S := 'INPUTKEYBOARD';
          INPUT_HARDWARE: S := 'INPUTHARDWARE';
//          WM_MOUSEMOVE: S := 'MOUSEMOVE';
//          WM_LBUTTONDOWN: S := 'LBUTTONDOWN';
//          WM_LBUTTONUP: S := 'LBUTTONUP';
//          WM_LBUTTONDBLCLK: S := 'LBUTTONDBLCLK';
//          WM_RBUTTONDOWN: S := 'RBUTTONDOWN';
//          WM_RBUTTONUP: S := 'RBUTTONUP';
//          WM_RBUTTONDBLCLK: S := 'RBUTTONDBLCLK';
//          WM_MBUTTONDOWN: S := 'MBUTTONDOWN';
//          WM_MBUTTONUP: S := 'MBUTTONUP';
//          WM_MBUTTONDBLCLK: S := 'MBUTTONDBLCLK';
//          WM_MOUSEWHEEL: S := 'MOUSEWHEEL';
//
//          WM_KEYDOWN: S := 'KEYDOWN';
//          WM_KEYUP: S := 'KEYUP';
//          WM_CHAR: S := 'CHAR';
//          WM_DEADCHAR: S := 'DEADCHAR';
//          WM_SYSKEYDOWN: S := 'SYSKEYDOWN';
//          WM_SYSKEYUP: S := 'SYSKEYUP';
//          WM_SYSCHAR: S := 'SYSCHAR';
//          WM_SYSDEADCHAR: S := 'SYSDEADCHAR';
//          WM_KEYLAST: S := 'KEYLAST';
//          else
//            S := 'UnKnown';
          end;

          ST1.Values[S] := IntToStr(PMsgBuff[i].Itype);

          case PMsgBuff[i].Itype of
            INPUT_MOUSE: begin
//              LPoint.X := PMsgBuff[i].mi.dx;
//              LPoint.Y := PMsgBuff[i].mi.dy;
//              Winapi.Windows.ScreenToClient(GetActiveWindow,LPoint);
//              ST1.Values['X'] := InttoStr(LPoint.X);
//              ST1.Values['Y'] := InttoStr(LPoint.Y);
              ST1.Values['X'] := InttoStr(PMsgBuff[i].mi.dx);
              ST1.Values['Y'] := InttoStr(PMsgBuff[i].mi.dy);
              ST1.Values['MouseData'] := InttoStr(PMsgBuff[i].mi.mouseData);
              ST1.Values['Flags'] := InttoStr(PMsgBuff[i].mi.dwFlags);
              ST1.Values['Time'] := InttoStr(PMsgBuff[i].mi.time);
              ST1.Values['ExtraInfo'] := inttoStr(PMsgBuff[i].mi.dwExtraInfo);
            end;
            INPUT_KEYBOARD: begin
              p := PMsgBuff[i].ki.wVk;

//              if (PMsgBuff[i].ki.dwFlags = WM_KEYDOWN) or (PMsgBuff[i].ki.dwFlags = WM_KEYUP) then
//                ST1.Values['wVk'] := KeyToString(p);
//              else
                ST1.Values['wVk'] := IntToStr(p);

              ST1.Values['Flags'] := InttoStr(PMsgBuff[i].ki.dwFlags);
              ST1.Values['ScanCode'] := InttoStr(PMsgBuff[i].ki.wScan);
              ST1.Values['Time'] := InttoStr(PMsgBuff[i].ki.time);
              ST1.Values['ExtraInfo'] := inttoStr(PMsgBuff[i].ki.dwExtraInfo);
            end;
            INPUT_HARDWARE: begin
            end;
          end;

          ST2.Add(ST1.CommaText);
      end;

      ST2.SaveToFile(AFileName);
    finally
      ST1.Free;
      ST2.Free;
    end;
  end;
end;

procedure TMacroManageF.SaveMacroRecord(AFileName: string);
begin
  if AFileName = '' then
  begin
    SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName);
    SaveDialog1.Filter := 'SendInputHelper files (*.sih)|*.sih|Any file (*.*)|*.*';
    if SaveDialog1.Execute then
      AFileName := SaveDialog1.FileName;
  end;

//  SaveInput2File(AFileName);
  SaveSIHelperList2File(AFileName);
end;

procedure TMacroManageF.SaveMacroToFile(AFileName: string);
var
  LJson: RawUTF8;
begin
  if AFileName = '' then
    exit;

//  LJson := ObjectToJSON(FMacroManageList, [woHumanReadable,woStoreClassName]);
  FMacroManageList.SaveToJSONFile(AFileName);
end;

procedure TMacroManageF.SaveSIHelperList2File(AFileName: string);
var
  ST1, ST2: TStringList;
  i,p: integer;
  S: string;
  LInput: TInput;
begin
  if FSendInputHelper.Count = 0 then
    Exit;

  if AFileName = '' then
    exit;

  ST1 := TStringList.Create;
  ST2 := TStringList.Create;
  try
    ST1.Values['MessageCount'] := inttostr(FSendInputHelper.Count);
    ST2.Add(ST1.CommaText);
    S := '';

    for LInput in FSendInputHelper do
    begin
      ST1.Clear;

      case LInput.Itype of
        INPUT_MOUSE: S := 'INPUTMOUSE';
        INPUT_KEYBOARD: S := 'INPUTKEYBOARD';
        INPUT_HARDWARE: S := 'INPUTHARDWARE';
      end;

      ST1.Values[S] := IntToStr(LInput.Itype);
      case LInput.Itype of
        INPUT_MOUSE: begin
          ST1.Values['X'] := InttoStr(LInput.mi.dx);
          ST1.Values['Y'] := InttoStr(LInput.mi.dy);
          ST1.Values['MouseData'] := InttoStr(LInput.mi.mouseData);
          ST1.Values['Flags'] := InttoStr(LInput.mi.dwFlags);
          ST1.Values['Time'] := InttoStr(LInput.mi.time);
          ST1.Values['ExtraInfo'] := inttoStr(LInput.mi.dwExtraInfo);
        end;
        INPUT_KEYBOARD: begin
//          p := LInput.ki.wVk;
          ST1.Values['wVk'] := GetCharFromVKey(LInput.ki.wVk);
//          ST1.Values['wVk'] := InttoStr(LInput.ki.wVk);
          ST1.Values['Flags'] := InttoStr(LInput.ki.dwFlags);
          ST1.Values['ScanCode'] := InttoStr(LInput.ki.wScan);
          ST1.Values['Time'] := InttoStr(LInput.ki.time);
          ST1.Values['ExtraInfo'] := inttoStr(LInput.ki.dwExtraInfo);
        end;
        INPUT_HARDWARE: begin
        end;
      end;//case

      ST2.Add(ST1.CommaText);
    end; //for

    ST2.SaveToFile(AFileName);
  finally
    ST1.Free;
    ST2.Free;
  end;
end;

procedure TMacroManageF.SelectActionCollect(AIdx: integer);
var
  j: integer;
  LMacroManagement: TMacroManagement;
begin
  if AIdx = -1 then
    AIdx := MacroGrid.SelectedRow;

  ActionLB.Items.BeginUpdate;
  try
    ActionLB.Items.Clear;

    LMacroManagement := FMacroManageList.Items[AIdx] as TMacroManagement;

    for j := 0 to LMacroManagement.ActionCollect.Count - 1 do
    begin
      ActionLB.Items.AddObject(LMacroManagement.ActionCollect.Item[j].ActionItem.ActionDesc, LMacroManagement.ActionCollect.Item[j]);
    end;

    Label2.Caption := 'Count : ' + IntToStr(j);
  finally
    ActionLB.Items.EndUpdate;
  end;
end;

procedure TMacroManageF.SelectMacroCollect(AIdx: integer);
var
  j, LRow: integer;
  LMacroManagement: TMacroManagement;
begin
  LMacroManagement := FMacroManageList.Items[AIdx] as TMacroManagement;
  AssignDynMsg2Grid(LMacroManagement.MacroArray);
//  NGFrame.NextGrid1.BeginUpdate;
//  try
//    NGFrame.NextGrid1.ClearRows;


//    for j := 0 to LMacroManagement.MacroCollect.Count - 1 do
//    begin
//      LRow := NGFrame.NextGrid1.AddRow;
//      NGFrame.NextGrid1.CellByName['Itemname',LRow].AsString := LMacroManagement.MacroCollect.Item[j].MacroItem.ItemName;
//      NGFrame.NextGrid1.CellByName['Value',LRow].AsString := LMacroManagement.MacroCollect.Item[j].MacroItem.ItemValue;
//    end;
//  finally
//    NGFrame.NextGrid1.EndUpdate;
//  end;
end;

procedure TMacroManageF.SelectMacroItem(AIdx: integer);
begin
  SelectMacroCollect(AIdx);
  SelectActionCollect(AIdx);
end;

procedure TMacroManageF.SendInputTest1Click(Sender: TObject);
 var
  LInput: TInput;
  LInputs: array[0..2] of TInput;
  SIH: TSendInputHelper;
begin
  SIH := TSendInputHelper.Create;
//  SIH.AddRelativeMouseMove(848, 328);
  SIH.AddAbsoluteMouseMove(848, 328);
  SIH.AddMouseClick(mbLeft);
  SIH.Flush;
  SIH.Free;

//  LInputs[0].Itype:= INPUT_MOUSE;
////  LInputs[0].mi.dx:= 859;
////  LInputs[0].mi.dy:= 282;
//  LInputs[0].mi.dx:= MulDiv(859, 65536, GetSystemMetrics(SM_CXSCREEN));//100*(65536/GetSystemMetrics(SM_CXSCREEN));
//  LInputs[0].mi.dy:= MulDiv(282, 65536, GetSystemMetrics(SM_CXSCREEN));//100*(65536/GetSystemMetrics(SM_CXSCREEN));
//  LInputs[0].mi.mouseData:= 0;
//  LInputs[0].mi.dwFlags:= MOUSEEVENTF_MOVE or MOUSEEVENTF_ABSOLUTE;
//  LInputs[0].mi.time:= 0;
//  LInputs[0].mi.dwExtraInfo:= 0;
//
//  LInputs[1].Itype:= INPUT_MOUSE;
//  LInputs[1].mi.dx:= 0;
//  LInputs[1].mi.dy:= 0;
//  LInputs[1].mi.mouseData:= 0;
//  LInputs[1].mi.dwFlags:= MOUSEEVENTF_LEFTDOWN;
//  LInputs[1].mi.time:= 0;
//  LInputs[1].mi.dwExtraInfo:= 0;
//
//  LInputs[2].Itype:= INPUT_MOUSE;
//  LInputs[2].mi.dx:= 0;
//  LInputs[2].mi.dy:= 0;
//  LInputs[2].mi.mouseData:= 0;
//  LInputs[2].mi.dwFlags:= MOUSEEVENTF_LEFTUP;
//  LInputs[2].mi.time:= 0;
//  LInputs[2].mi.dwExtraInfo:= 0;
//
//  SendInput(Length(LInputs), LInputs[0], SizeOf(TInput))
end;

procedure TMacroManageF.SetEventCaptureConfig;
begin
  CreateEventCaptureConfigF(FEventCaptureConfig, FEventCaptureConfigFileName);
end;

procedure TMacroManageF.CreateKeyBdHook;
begin
  if Assigned(FKeyBdHook) then
    exit;

  FKeyBdHook := THookInstance<TLowLevelKeyboardHook>.CreateHook(Self);
  FKeyBdHook.OnPreExecute := procedure(Hook: THook; var HookMsg: THookMessage)
    var
      LLKeyBoardHook: TLowLevelKeyboardHook;
//      ScanCode: integer;
    begin
      LLKeyBoardHook := TLowLevelKeyboardHook(Hook);

      if LLKeyBoardHook.LowLevelKeyStates.KeyState <> ksKeyDown then
        exit;

//      ScanCode := LLKeyBoardHook.KeyName.ScanCode;

      if HookMsg.Result = HC_ACTION then
      begin
        SendMessage(Handle, WM_Notify_KeyBd_Event, HookMsg.Msg, LongInt(@LLKeyBoardHook));
      end;
//        Caption := '[' + IntToStr(HookMsg.Msg.WParam) + ' : ' + IntToStr(HookMsg.Msg) +']';
//      SendMessage(Handle, WM_Notify_KeyBd_Event, LongInt(@HookMsg), LongInt(@LLKeyBoardHook));

//      if not(ScanCode in [VK_NUMPAD0 .. VK_NUMPAD9, VK_0 .. VK_9]) then
//      begin
//        Caption := 'Got ya! Key [' + LLKeyBoardHook.KeyName.KeyExtName + '] blocked.';
//        HookMsg.Result := 1;
//      end
//      else
//        Caption := '';
    end;
end;

procedure TMacroManageF.CreateMsgBuf;
begin
  if pMsgBuff <> nil then Exit;

  GetMem(PMsgBuff, Sizeof(TMsgBuff));

  if PMsgBuff = nil then exit;

  FMsgCount := 0;
  FFirstEvent := true;
  FStartTime := GetTickCount;
end;

procedure TMacroManageF.CreateMouseHook;
begin
  if Assigned(FMouseHook) then
    exit;

  FMouseHook := THookInstance<TLowLevelMouseHook>.CreateHook(Self);
  FMouseHook.OnPreExecute := procedure(Hook: THook; var HookMsg: THookMessage)
    var
      LLMouseHook: TLowLevelMouseHook;
//      LPt: TPoint;
    begin
      LLMouseHook := TLowLevelMouseHook(Hook);

      if HookMsg.Result = HC_ACTION then
      begin
//        FMousePt := LLMouseHook.HookStruct.Pt;
//        if HookMsg.Msg = WM_MOUSEMOVE then
        SendMessage(Handle, WM_Notify_Mouse_Event, HookMsg.Msg, LongInt(@LLMouseHook));
//        HookMsg.Result := 1;
      end;
    end;
end;

procedure TMacroManageF.ShowMacroManageListCount;
begin
  ShowMessage(IntToStr(FMacroManageList.Count));
end;

procedure TMacroManageF.SignalEvent(const task: IOmniTask);
var
  ov: TOmniValue;
  LHandleKind: integer;
begin
  LHandleKind := task.Param[0];
  Sleep(task.Param[1]);
  ov := task.Param[2];

  if LHandleKind = 1 then //MacroEvent
    SetEvent(FMacroStepHandles[ov.AsInteger])
  else if LHandleKind = 2 then //ActionEvent
    SetEvent(FActionStepHandles[ov.AsInteger]);
end;

//AHandleKind = 1 : MacroEvent, 2 : ActionEvent
procedure TMacroManageF.SignalEventAsync(AHandleKind: integer; timeout_ms: cardinal; idx: integer);
begin
  CreateTask(SignalEvent, 'SignalEvent')
    .SetParameter(AHandleKind)
    .SetParameter(timeout_ms)
    .SetParameter(idx)
    .Unobserved
    .Run;
end;

procedure TMacroManageF.SpeedButton1Click(Sender: TObject);
begin
  if not FMacroStepEnable then
    FMacroStepEnable := True;

  SignalEventAsync(1, 1000, 0);
//  StepEnque(1);//Macro Step
end;

procedure TMacroManageF.SpeedButton2Click(Sender: TObject);
begin
  if not FActionStepEnable then
  begin
    FActionStepEnable := True;
    PlayMacro;
  end;

  SignalEventAsync(2, 1000, 0);
//  StepEnque(2);//Action Step
end;

procedure TMacroManageF.SpeedButton3Click(Sender: TObject);
var
  LIsAppend: Boolean;
begin
  LIsAppend := False;

  if FMacroManageList.Count > 0 then
  begin
    if MessageDlg('Are you want to append Macro from file?', mtConfirmation, mbYesNo, 0) = mrYes then
    begin
      LIsAppend := True;
    end;
  end;

  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);

  if OpenDialog1.Execute(Handle) then
  begin
    LoadMacroFromFile(OpenDialog1.FileName, LIsAppend);
    DisplayMacroToGrid;
  end;
end;

procedure TMacroManageF.SpeedButton4Click(Sender: TObject);
begin
  if SaveDialog1.Execute(Handle) then
    SaveMacroToFile(SaveDialog1.FileName);
end;

procedure TMacroManageF.SpeedButton5Click(Sender: TObject);
begin
  DeleteMacroname(MacroGrid.SelectedRow);
end;

procedure TMacroManageF.SpeedButton6Click(Sender: TObject);
begin
  AddMacroItemName(Edit1.Text);
end;

procedure TMacroManageF.SpeedButton7Click(Sender: TObject);
begin
  DeleteMacroItemName;
end;

procedure TMacroManageF.SpeedButton8Click(Sender: TObject);
begin
  CreateNewMacro;
end;

procedure TMacroManageF.ToggleRecording;
begin
  CreateKeyBdHook();
  CreateMouseHook();

  FKeyBdHook.Active := not FKeyBdHook.Active;
  FMouseHook.Active := not FMouseHook.Active;

  FHookStarted := FMouseHook.Active or FKeyBdHook.Active;

//  if FHookStarted then
//    CreateMsgBuf;

  //  if CheckNSetRegistryForEnableLUA then
//    MacroRecorder1.RecordMacro;
end;

procedure TMacroManageF.StepEnque(AHandleKind: integer);
var
  LOmniValue: TOmniValue;
  LRec    : TMacroSignalEventRec;
begin
  LRec.FHandleKind := AHandleKind; //1: Macr Step, 2: Action Step
  LRec.FTimeout_ms := 1000; //1 Sec
  LRec.Fidx := 0; //First item index for event handler
  LOmniValue := TOmniValue.FromRecord<TMacroSignalEventRec>(LRec);

  if AHandleKind = 1 then
    FMacroStepQueue.Enqueue(TOmniMessage.Create(1, LOmniValue))
  else
  if AHandleKind = 2 then
    FActionStepQueue.Enqueue(TOmniMessage.Create(1, LOmniValue));
end;

procedure TMacroManageF.StopMacro;
begin
  FBreak := true;
  FMacroCancelToken.Signal;
end;

procedure TMacroManageF.StopRecording;
begin
//  MacroRecorder1.StopRecording;
//  CheckNReSetRegistryForEnableLUA();
end;

procedure TMacroManageF.Timer1Timer(Sender: TObject);
var
  MousePos: TPoint;
begin
//  GetCursorPos(MousePos);
//  if MousePos.X > 800 then
//    SetCursorPos(10,10);
//  MousePos.X := Mouse.CursorPos.X + 1;
//  MousePos.Y := Mouse.CursorPos.Y + 1;
//  Mouse.CursorPos := MousePos;
end;

procedure TMacroManageF.ToolButton1Click(Sender: TObject);
var
  i: integer;
begin
  if MacroGrid.SelectedCount > 0 then
  begin
    if MacroGrid.SelectedCount = 1 then
    begin
      if MacroGrid.SelectedRow > 0 then
      begin
        FMacroManageList.Move(MacroGrid.SelectedRow, MacroGrid.SelectedRow - 1);
        MacroGrid.MoveRow(MacroGrid.SelectedRow, MacroGrid.SelectedRow - 1);
        MacroGrid.SelectedRow := MacroGrid.SelectedRow - 1;
      end;
    end
    else
    begin
      for i := 1 to MacroGrid.RowCount - 1 do
      begin
        if MacroGrid.Selected[i] then
        begin
          MacroGrid.MoveRow(i, i - 1);
          MacroGrid.Selected[i] := False;
          MacroGrid.Selected[i-1] := True;
        end;
      end;
    end;
  end;
end;

procedure TMacroManageF.ToolButton2Click(Sender: TObject);
var
  CurrIndex, LastIndex: Integer;
begin
  CurrIndex := MacroGrid.SelectedRow;
  LastIndex := MacroGrid.RowCount;

  if CurrIndex + 1 < LastIndex then
  begin
    FMacroManageList.Move(CurrIndex, CurrIndex + 1);
    MacroGrid.MoveRow(CurrIndex, CurrIndex + 1);
    MacroGrid.SelectedRow := CurrIndex + 1;
  end;
end;

procedure TMacroManageF.WaitForAll(AStepWait: TWaitFor; timeout_ms: cardinal;
  expectedResult: TWaitFor.TWaitForResult; const msg: string);
begin
  if AStepWait.WaitAll(timeout_ms) <> expectedResult then
    raise Exception.Create('WaitAll returned unexpected result');
end;

procedure TMacroManageF.WaitForAny(AStepWait: TWaitFor; timeout_ms: cardinal;
  expectedResult: TWaitFor.TWaitForResult; const msg: string;
  checkHandle: integer);
begin
  if AStepWait.WaitAny(timeout_ms) = expectedResult then begin
    if (checkHandle >= 0) and
       ((Length(AStepWait.Signalled) <> 1) or
        (AStepWait.Signalled[0].Index <> checkHandle))
    then
      raise Exception.Create('WaitAny returned unexpected handle number');
  end
  else
    raise Exception.Create('WaitAny returned unexpected result');
end;

procedure TMacroManageF.WMNotifyKeyBdEvent(var Message: TMessage);
//var
//  LLKeyBoardHook: TLowLevelKeyboardHook;
//  LMsg: THookMessage;
begin
//  LMsg := PMessage(Message.WParam)^;

//  if Message.WParam = 256 then
//  LLKeyBoardHook := PLowLevelKeyboardHook(Message.LParam)^;

  // 229 ( 0xE5 ) : VK_PROCESSKEY ( IME PROCESS key )
//  if ((Message.WParam = 229 and Message.LParam = -2147483647) or (Message.WParam = 229 and Message.LParam = -2147483648))

  AddEvent2Buf(Message);

  Caption := '[' + IntToStr(Message.Msg) + ' : ' + IntToStr(Message.WParam) + ' : ' + IntToStr(Message.LParam) + ']';
//  Caption := '[' + IntToStr(LLKeyBoardHook.HookStruct.vkCode) + ']';
//  Caption := '[' + LLKeyBoardHook.KeyName.KeyExtName + ']';
end;

procedure TMacroManageF.WMNotifyMouseEvent(var Message: TMessage);
var
  LMouseHook: TLowLevelMouseHook;
  Lpt: TPoint;
begin
  LMouseHook := PLowLevelMouseHook(Message.LParam)^;
  AddEvent2Buf(Message);
  GetCursorPos(Lpt);
  Caption := '[X: ' + IntToStr(LMouseHook.HookStruct.Pt.X) +
             ', Y: ' + IntToStr(LMouseHook.HookStruct.Pt.Y) + ']' +
             ' ==> [X: ' + IntToStr(LPt.X) + ', Y: ' + IntToStr(LPt.Y) + ']';
end;

procedure TMacroManageF.WMReceiveString(var Message: TMessage);
begin
  FCommBufStr := Self.Hint;

  if FCommBufStr = 'OK' then
  begin
    ShowMessage(FCommBufStr);
  end;
end;

procedure TMacroManageF._PlaySequence(AIdx: integer);
var
  LActionList: TActionList;
begin
  LActionList := TMacroManagement(FMacroManageList.Items[AIdx]).FActionList;

  if Assigned(LActionList) then
    PlaySequence(LActionList,TMacroManagement(FMacroManageList.Items[AIdx]).IterateCount);
end;

end.
