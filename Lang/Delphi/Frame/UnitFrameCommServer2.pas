unit UnitFrameCommServer2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.SyncObjs, //System.TypInfo,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvOfficeStatusBar, OtlComm,
  AdvOfficeStatusBarStylers, Vcl.ExtCtrls, Vcl.Menus, JvComponentBase,
  JvTrayIcon, JvExControls, JvXPCore, JvXPButtons, Vcl.StdCtrls,
  Vcl.ComCtrls, //Cromis.Threading, Cromis.AnyValue,
  TimerPool,
  {$IfDef USE_REMOTEDEBUG}
//  mORMotHttpClient,
  {$EndIf USE_REMOTEDEBUG}
  mormot.rest.server, mormot.orm.core, mormot.net.server, mormot.soa.server,
  mormot.soa.core, mormot.rest.memserver, mormot.soa.codegen, mormot.core.rtti,
  mormot.rest.http.server, mormot.core.interfaces, mormot.core.log,
  UnitCommUserClass;

const
  IsHandleUserAuthentication = True;
  WM_OnMemoMessage = WM_USER + 1;

type
  TDisplayTarget = (dtSystemLog, dtConnectLog, dtCommLog, dtStatusBar);

  TDispMsgRecord = packed record
    FMsg: string;
    FDspTarget: TDisplayTarget;
  end;

  TRestMode = (rmRESTful, rmWebSocket);
  TStartServerProc = procedure of object;

  TFrameCommServer = class(TFrame)
    Splitter1: TSplitter;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    lvConnections: TListView;
    TabSheet2: TTabSheet;
    Splitter2: TSplitter;
    SendMemo: TRichEdit;
    Recvmemo: TRichEdit;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    Panel1: TPanel;
    AutoStartCheck: TCheckBox;
    Panel2: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LblPort: TLabel;
    LblCurConnent: TLabel;
    LblMaxConn: TLabel;
    Label8: TLabel;
    ServerStartBtn: TJvXPButton;
    ServerStopBtn: TJvXPButton;
    JvXPButton3: TJvXPButton;
    JvXPButton4: TJvXPButton;
    JvXPButton5: TJvXPButton;
    JvXPButton6: TJvXPButton;
    AdvOfficeStatusBar1: TAdvOfficeStatusBar;
    JvTrayIcon1: TJvTrayIcon;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    rlsmd1: TMenuItem;
    StopMonitor1: TMenuItem;
    StartMonitor1: TMenuItem;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    N5: TMenuItem;
    MenuItem4: TMenuItem;
    Timer1: TTimer;
    AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler;
    ServerIpCombo: TComboBox;
    PopupMenu2: TPopupMenu;
    DeleteItem1: TMenuItem;
    N6: TMenuItem;
    ShowDebug1: TMenuItem;
    SMCommLog: TMemo;
    SMSysLog: TMemo;
    SMUDPConnectLog: TMemo;
    procedure ServerStartBtnClick(Sender: TObject);
    procedure ServerStopBtnClick(Sender: TObject);
    procedure DeleteItem1Click(Sender: TObject);
    procedure ShowDebug1Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
  private
  {$IfDef USE_REMOTEDEBUG}
    fDebugNumber: integer;
  {$EndIf USE_REMOTEDEBUG}
    FPJHTimerPool: TPJHTimerPool;
    FAutoStartTimerHandle: integer;
    FStopEvent    : TEvent;
    FDisplayMsgQueue: TOmniMessageQueue;

    procedure OnMemoMessage(var Msg: TMessage); message WM_OnMemoMessage;
    procedure OnAutoStartServer(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt); virtual;
    function SessionCreate(Sender: TRestServer; Session: TAuthSession;
                  Ctxt: TRestServerURIContext): boolean;
    function SessionClosed(Sender: TRestServer; Session: TAuthSession;
                  Ctxt: TRestServerURIContext): boolean;
    procedure AsyncDisplayMessage;
    procedure DisplayMessage(msg: string; ADspNo: TDisplayTarget);
  public
    FModel: TOrmModel;
    FHTTPServer: TRestHttpServer;
    FRestServer: TRestServer;
    FServiceFactoryServer: TServiceFactoryServerAbstract;

    FIpAddr: string;
    FURL: string; //Server���� Client�� Config Change Notify �ϱ� ���� Call Back URL

    FRootName,
    FJSONName,
    FPortName: string;
    FIsServerActive: Boolean;
    FStartServerProc: TStartServerProc;
    FAutoStartInterval: integer;
    FRestMode: TRestMode;
    FCommUserList: TCommUser;
//    FMessageQueue: TThreadSafeQueue;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitVar;
    procedure DestroyVar;

  {$IfDef USE_REMOTEDEBUG}
    procedure CreateRemoteDebugClient;
    procedure DestroyRemoteDebugClient;
    procedure SendDebug(AMsg: string);
  {$EndIf USE_REMOTEDEBUG}
    procedure CreateHttpServer(ARootName, AJSONName, APort: string;
      aClient: TInterfacedClass; const aInterfaces: array of PRttiInfo;
            aInstanceCreation: TServiceInstanceImplementation; aIsClientWrapper: boolean = False);
    procedure CreateHttpServer4WS(APort, ATransmissionKey: string;
      aClient: TInterfacedClass; const aInterfaces: array of TGUID);
    procedure DestroyHttpServer;

    procedure MySessionCreate(ARemoteIP, ASessionID, AUserId: string);
    procedure MySessionClosed(ARemoteIP, ASessionID, AUserId: string);

    procedure DisplayMessageUsingMsgQueue(msg: string; ADspNo: TDisplayTarget);

    procedure AddConnectionToLV(AIPAddr, APort, ASessionID: string; AUserName: string = ''); overload;
    procedure AddConnectionToLV(ACommUserItem: TCommUserItem); overload;
    function AddCommUser2Collect(AUserId, APasswd, AIpAddress, AUserName, ASessionId, AUrl: string): Boolean;
    function DeleteCommUser2Collect(AUserId, APasswd, AIpAddress, AUserName, ASessionId, AUrl: string): Boolean;
    function CheckExistUserFromList(AUserId,AIpAddress,AUrl: string): integer;
    procedure DeleteConnectionFromLV(AIPAddr, APort, ASessionID: string; AUserName: string = ''); overload;
    procedure DeleteConnectionFromLV(ACommUserItem: TCommUserItem); overload;

    procedure ApplyStatus2Component;
    function Get_HHI_IPAddr: string;
  end;

implementation

uses getIp, System.StrUtils, OtlParallel, otlTask, otlCommon;//SynLog,

{$R *.dfm}

{ TFrameCommServer }

function TFrameCommServer.AddCommUser2Collect(AUserId, APasswd, AIpAddress,
  AUserName, ASessionId, AUrl: string): Boolean;
var
  LCommUserItem: TCommUserItem;
begin
  Result := CheckExistUserFromList(AUserId,AIpAddress,AUrl) <> -1; //������ True

  if not Result then
  begin
    LCommUserItem := FCommUserList.CommUserCollect.Add;
    LCommUserItem.UserID := AUserId;
    LCommUserItem.Passwd := APasswd;
    LCommUserItem.IpAddress := AIpAddress;
    LCommUserItem.UserName := AUserName;
    LCommUserItem.SessionId := ASessionId;
    LCommUserItem.Url := AUrl;

    AddConnectionToLV(LCommUserItem);
  end;
end;

procedure TFrameCommServer.AddConnectionToLV(AIPAddr, APort, ASessionID: string;
  AUserName: string);
var
  LListItem: TListItem;
begin
  LListItem := lvConnections.Items.Add;
  LListItem.Caption := AIPAddr;
  LListItem.SubItems.Add('Connected');
  LListItem.SubItems.Add(DateTimeToStr(Now));
  LListItem.SubItems.Add(APort);
  LListItem.SubItems.Add(AUserName);
  LListItem.SubItems.Add(ASessionID);
//  DisplayMessage(DateTimeToStr(Now) + ' : Connected from [ ' + AIPAddr + ' : ' + AUserName + ' ]', dtConnectLog);
end;

procedure TFrameCommServer.AddConnectionToLV(ACommUserItem: TCommUserItem);
var
  LListItem: TListItem;
  LStr: string;
begin
  LListItem := lvConnections.Items.Add;
  LListItem.Caption := ACommUserItem.IpAddress;
  LListItem.SubItems.Add('Connected');
  LListItem.SubItems.Add(DateTimeToStr(Now));
  LListItem.SubItems.Add(ACommUserItem.ServerPortNo);
  LListItem.SubItems.Add(ACommUserItem.UserName);
  LListItem.SubItems.Add(ACommUserItem.SessionId);
  LStr := DateTimeToStr(Now) + ' : Connected from [ ' + ACommUserItem.IpAddress + ' : ' + ACommUserItem.UserName + ' ]';
  DisplayMessage(LStr, dtConnectLog);
end;

procedure TFrameCommServer.ApplyStatus2Component;
begin
  ServerStartBtn.Enabled := not FIsServerActive;
  ServerStopBtn.Enabled := FIsServerActive;

  ServerIpCombo.Text := FIpAddr;
  LblPort.Caption := FPortName;
end;

procedure TFrameCommServer.AsyncDisplayMessage;
begin
  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      i: integer;
      handles: array [0..1] of THandle;
      msg    : TOmniMessage;
      rec: TDispMsgRecord;
    begin
      handles[0] := FStopEvent.Handle;
      handles[1] := FDisplayMsgQueue.GetNewMessageEvent;

      while WaitForMultipleObjects(2, @handles, false, INFINITE) = (WAIT_OBJECT_0 + 1) do
      begin
        while FDisplayMsgQueue.TryDequeue(msg) do
        begin
          rec := msg.MsgData.ToRecord<TDispMsgRecord>;

          if msg.MsgID = 1 then
          begin
          end
          else
          if msg.MsgID = 2 then
          begin
          end
          else
          if msg.MsgID = 3 then
          begin
          end;

          task.Invoke(
            procedure
            begin
              DisplayMessage(rec.FMsg, rec.FDspTarget);
            end
          );
        end;//while
      end;//while
    end,

    Parallel.TaskConfig.OnMessage(Self).OnTerminated(
      procedure
      begin
      end
    )
  );
end;

function TFrameCommServer.CheckExistUserFromList(AUserId,AIpAddress,AUrl: string): integer;
var
  i: integer;
begin
  Result := -1;

  for i := 0 to FCommUserList.CommUserCollect.Count - 1 do
  begin
    if (FCommUserList.CommUserCollect.Items[i].UserID = AUserId) and
      (FCommUserList.CommUserCollect.Items[i].IpAddress = AIpAddress) and
      (FCommUserList.CommUserCollect.Items[i].Url = AUrl) then
    begin
      Result := i;
      break;
    end;
  end;
end;

constructor TFrameCommServer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  InitVar;

  {$IfDef USE_REMOTEDEBUG}
  CreateRemoteDebugClient;
  {$EndIf USE_REMOTEDEBUG}
end;

procedure TFrameCommServer.CreateHttpServer(ARootName, AJSONName, APort: string;
  aClient: TInterfacedClass; const aInterfaces: array of PRttiInfo;
  aInstanceCreation: TServiceInstanceImplementation; aIsClientWrapper: boolean);
begin
  if not Assigned(FModel) then
  begin
    FModel := TOrmModel.Create([],ARootName);
    FRootName := ARootName;
  end;

  if not Assigned(FRestServer) then
  begin
    // initialize a TObjectList-based database engine
    FRestServer := TRestServerFullMemory.Create(FModel,AJSONName,false,IsHandleUserAuthentication);

    // add the http://localhost:888/root/wrapper code generation web page
    if aIsClientWrapper then
      AddToServerWrapperMethod(FRestServer,
        ['..\..\..\common\mORMot\CrossPlatform\templates','..\..\..\common\mORMot\CrossPlatform\templates']);

    FJSONName := AJSONName;
    // register our ICalculator service on the server side
    FRestServer.ServiceRegister(aClient, aInterfaces, aInstanceCreation);//.ByPassAuthentication := True;

    FRestServer.OnSessionCreate := SessionCreate;
    FRestServer.OnSessionClosed := SessionClosed;
  end;

  if not Assigned(FHTTPServer) then
  begin
    // launch the HTTP server
    FPortName := APort;
    FHTTPServer := TRestHttpServer.Create(APort,[FRestServer],'+',useHttpApiRegisteringURI);
    FHTTPServer.AccessControlAllowOrigin := '*'; // for AJAX requests to work
    FIsServerActive := True;
  end;
end;

procedure TFrameCommServer.CreateHttpServer4WS(APort, ATransmissionKey: string;
  aClient: TInterfacedClass; const aInterfaces: array of TGUID);
begin
  if not Assigned(FRestServer) then
  begin
    // initialize a TObjectList-based database engine
    FRestServer := TRestServerFullMemory.CreateWithOwnModel([]);
    // register our Interface service on the server side
    FRestServer.CreateMissingTables;
    FServiceFactoryServer := FRestServer.ServiceDefine(aClient, aInterfaces , sicShared);
    FServiceFactoryServer.SetOptions([], [optExecLockedPerInterface]). // thread-safe fConnected[]
      ByPassAuthentication := true;

    FRestMode := rmWebSocket;

//    FRestServer.OnSessionCreate := SessionCreate;
//    FRestServer.OnSessionClosed := SessionClosed;
  end;

  if not Assigned(FHTTPServer) then
  begin
    // launch the HTTP server
    FPortName := APort;
    FHTTPServer := TRestHttpServer.Create(APort, [FRestServer], '+' , useBidirSocket);
    FHTTPServer.WebSocketsEnable(FRestServer, ATransmissionKey);
    FIsServerActive := True;
  end;
end;

{$IfDef USE_REMOTEDEBUG}
procedure TFrameCommServer.CreateRemoteDebugClient;
begin
//  PTypeInfo(TypeInfo(TSynLogInfo))^.EnumBaseType^.AddCaptionStrings('Debug');
  SQLite3Log.Family.Level := LOG_VERBOSE;
  TSQLHttpClient.CreateForRemoteLogging(
    AnsiString(RCS_REMOTEDEBUG_IP),SQLite3Log,StrToInt(RCS_REMOTEDEBUG_PORT));
end;
{$EndIf USE_REMOTEDEBUG}

function TFrameCommServer.DeleteCommUser2Collect(AUserId, APasswd, AIpAddress,
  AUserName, ASessionId, AUrl: string): Boolean;
var
  i: integer;
//  LCommUserItem: TCommUserItem;
begin
  i := CheckExistUserFromList(AUserId,AIpAddress,AUrl);
  Result := i <> -1;//������ True

  if Result then
  begin
    DeleteConnectionFromLV(FCommUserList.CommUserCollect.Items[i]);
    FCommUserList.CommUserCollect.Delete(i);
  end;
end;

procedure TFrameCommServer.DeleteConnectionFromLV(ACommUserItem: TCommUserItem);
var
  i: integer;
  LListItem: TListItem;
begin
  for i := 0 to lvConnections.Items.Count - 1 do
  begin
    LListItem := lvConnections.Items.Item[i];

    if (LListItem.Caption = ACommUserItem.IpAddress) and
      (LListItem.SubItems.Strings[2] = ACommUserItem.ServerPortNo) and
      (LListItem.SubItems.Strings[3] = ACommUserItem.UserName) and
      (LListItem.SubItems.Strings[4] = ACommUserItem.SessionId) then
    begin
      lvConnections.Items.Delete(i);
      DisplayMessage(DateTimeToStr(Now) + ' : DisConnected from [ ' + ACommUserItem.IpAddress + ' : ' + ACommUserItem.UserName +  ' ]', dtConnectLog);
      break;
    end;
  end;
end;

procedure TFrameCommServer.DeleteConnectionFromLV(AIPAddr, APort, ASessionID,
  AUserName: string);
var
  i: integer;
  LListItem: TListItem;
begin
  for i := 0 to lvConnections.Items.Count - 1 do
  begin
    LListItem := lvConnections.Items.Item[i];

    if (LListItem.Caption = AIPAddr) and
      (LListItem.SubItems.Strings[2] = APort) and
      (LListItem.SubItems.Strings[3] = AUserName) and
      (LListItem.SubItems.Strings[4] = ASessionID) then
    begin
      lvConnections.Items.Delete(i);
//      DisplayMessage(DateTimeToStr(Now) + ' : DisConnected from [ ' + AIPAddr + ' : ' + AUserName +  ' ]', dtConnectLog);
      break;
    end;
  end;
end;

procedure TFrameCommServer.DeleteItem1Click(Sender: TObject);
begin
  lvConnections.Items.Delete(lvConnections.Selected.Index);
  DisplayMessage(DateTimeToStr(Now) + ' : Deletedted from menu', dtConnectLog);
end;

destructor TFrameCommServer.Destroy;
begin
  {$IfDef USE_REMOTEDEBUG}
  DestroyRemoteDebugClient;
  {$EndIf USE_REMOTEDEBUG}

  DestroyVar;

  inherited;
end;

procedure TFrameCommServer.DestroyHttpServer;
begin
  if Assigned(FHTTPServer) then
    FreeAndNil(FHTTPServer);

  if Assigned(FRestServer) then
  begin
    if FRestMode = rmWebSocket then
      FRestServer := nil
    else
      FreeAndNil(FRestServer);
  end;

  if Assigned(FModel) then
    FreeAndNil(FModel);
end;

{$IfDef USE_REMOTEDEBUG}
procedure TFrameCommServer.DestroyRemoteDebugClient;
begin
  SQLite3Log.Family.EchoRemoteStop;
end;
{$EndIf USE_REMOTEDEBUG}

procedure TFrameCommServer.DestroyVar;
begin
  FCommUserList.Free;
  FPJHTimerPool.RemoveAll;
//  FreeAndNil(FMessageQueue);
  FPJHTimerPool.Free;
  FStopEvent.SetEvent;
  FDisplayMsgQueue.Free;
  FreeAndNil(FStopEvent);
end;

procedure TFrameCommServer.DisplayMessage(msg: string; ADspNo: TDisplayTarget);
//var
//  LMemoHandle, LMemoCount: integer;
//  LMemo: TSynMemo;
begin
  if msg = ' ' then
  begin
    exit;
  end;

//  LMemo := nil;

  case ADspNo of
    dtSystemLog : begin
      with SMSysLog do
      begin
        if Lines.Count > 100 then
          Clear;
        Lines.Add(msg);
      end;//with

//      LMemo := SMSysLog;
    end;//dtSystemLog
    dtConnectLog: begin
      with SMUDPConnectLog do
      begin
        if Lines.Count > 100 then
          Clear;
        Lines.Add(msg);
      end;//with

//      LMemo := SMUDPConnectLog;
    end;//dtConnectLog
    dtCommLog: begin
      //SMCommLog.IsScrolling := true;
      with SMCommLog do
      begin
        if Lines.Count > 100 then
          Clear;
        Lines.Add(msg);
      end;//with

//      LMemo := SMCommLog;
    end;//dtCommLog

    dtStatusBar: begin
       AdvOfficeStatusBar1.SimplePanel := True;
       AdvOfficeStatusBar1.SimpleText := msg;
    end;//dtStatusBar
  end;//case

//  if Assigned(LMemo) then
//  begin
//    LMemo.SelStart := LMemo.GetTextLen;
//    LMemo.SelLength := 0;
//    LMemo.ScrollBy(0, LMemo.Lines.Count);
//    LMemo.Refresh;
//    SendMessage(LMemoHandle, EM_SCROLLCARET, 0, 0);
//    SendMessage(LMemoHandle, EM_LINESCROLL, 0, LMemoCount);
//  end;
end;

procedure TFrameCommServer.DisplayMessageUsingMsgQueue(msg: string;
  ADspNo: TDisplayTarget);
var
  LOmniValue: TOmniValue;
  rec: TDispMsgRecord;
begin
  rec.FMsg := DateTimeToStr(Now) + ' => ' + msg;
  rec.FDspTarget := ADspNo;
  LOmniValue := TOmniValue.FromRecord<TDispMsgRecord>(rec);
  FDisplayMsgQueue.Enqueue(TOmniMessage.Create(1, LOmniValue));
end;

function TFrameCommServer.Get_HHI_IPAddr: string;
var
  i: integer;
begin
  Result := '';

  for i := 0 to ServerIpCombo.Items.Count - 1 do
  begin
    if LeftStr(ServerIpCombo.Items.Strings[i],3) = '10.' then
    begin
      Result := ServerIpCombo.Items.Strings[i];
      Break;
    end;
  end;
end;

procedure TFrameCommServer.InitVar;
begin
  FPJHTimerPool := TPJHTimerPool.Create(Self);
//  FMessageQueue := TThreadSafeQueue.Create;
  ServerIpCombo.Items.Assign(GetLocalIPList);
  FCommUserList := TCommUser.Create(nil);
  FStopEvent := TEvent.Create;
  FDisplayMsgQueue := TOmniMessageQueue.Create(1000);

  if AutoStartCheck.Checked then
    FAutoStartTimerHandle := FPJHTimerPool.Add(OnAutoStartServer, 1000)
end;

procedure TFrameCommServer.MySessionClosed(ARemoteIP, ASessionID, AUserId: string);
begin
  DeleteConnectionFromLV(ARemoteIP, FPortName, ASessionID, AUserId);
end;

procedure TFrameCommServer.MySessionCreate(ARemoteIP, ASessionID, AUserId: string);
begin
  AddConnectionToLV(ARemoteIP, FPortName, ASessionID, AUserId);
end;

procedure TFrameCommServer.OnAutoStartServer(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
begin
  if AutoStartCheck.Checked then
  begin
    //server isn't running
    if (ServerStartBtn.Enabled) and (not ServerStopBtn.Enabled) and
          (not FIsServerActive) then
    begin
      if ElapsedTime > FAutoStartInterval then
      begin
        FPJHTimerPool.Remove(FAutoStartTimerHandle);
        FAutoStartTimerHandle := -1;
//        AutoStartCheck.Caption := 'Auto start after ' + IntToStr(FAutoStartInterval div 1000) + '  seconds';
        if Assigned(FStartServerProc) then
          FStartServerProc;
        AutoStartCheck.Caption := AutoStartCheck.Caption + '(Server start done.)';
      end
      else
      begin
        AutoStartCheck.Caption := 'Auto start after ' + IntToStr((FAutoStartInterval - ElapsedTime) div 1000) + ' seconds';
      end;
    end;
  end;
end;

procedure TFrameCommServer.OnMemoMessage(var Msg: TMessage);
//var
//  MessageValue: TAnyValue;
begin
  if Msg.WParam = 3 then
  begin
//    while FMessageQueue.Dequeue(MessageValue) do
//      DisplayMessage(MessageValue.AsString,TDisplayTarget(Msg.WParam));
  end
  else
  begin
//    FMessageQueue.Dequeue(MessageValue);
//    DisplayMessage(MessageValue.AsString,TDisplayTarget(Msg.WParam));
  end;
end;

procedure TFrameCommServer.Panel2Click(Sender: TObject);
begin

end;

{$IfDef USE_REMOTEDEBUG}
procedure TFrameCommServer.SendDebug(AMsg: string);
begin
  SQLite3Log.Add.Log(TSynLogInfo(2),
    FormatUTF8('% - %',[AMsg,fDebugNumber]));
  inc(fDebugNumber);
end;
{$EndIf USE_REMOTEDEBUG}

procedure TFrameCommServer.ServerStartBtnClick(Sender: TObject);
begin
  FIpAddr := Get_HHI_IPAddr;
  FURL := 'http://' + FIpAddr + ':' + FPortName + '/' + FRootName + '/';
  ApplyStatus2Component;
  AsyncDisplayMessage;
end;

procedure TFrameCommServer.ServerStopBtnClick(Sender: TObject);
begin
  DestroyHttpServer;

  if FIsServerActive then
  begin
    FIsServerActive := False;
    ApplyStatus2Component;
  end;
end;

function TFrameCommServer.SessionClosed(Sender: TRestServer;
  Session: TAuthSession; Ctxt: TRestServerURIContext): boolean;
var
  LOmniValue: TOmniValue;
  rec: TDispMsgRecord;
begin
  rec.FMsg := DateTimeToStr(Now) + ' : DisConnected from [ ' + Session.RemoteIP + ' : ' + Session.User.LogonName +  ' ]';
  rec.FDspTarget := dtConnectLog;
  LOmniValue := TOmniValue.FromRecord<TDispMsgRecord>(rec);
  FDisplayMsgQueue.Enqueue(TOmniMessage.Create(1, LOmniValue));

  DeleteConnectionFromLV(Utf8ToString(Session.RemoteIP), FPortName, IntToStr(Session.ID), Utf8ToString(Session.User.LogonName));
//  DisplayMessage(DateTimeToStr(Now) + ' : DisConnected from [ ' + Session.RemoteIP + ' : ' + Session.User.LogonName +  ' ]', dtConnectLog);
  Result := False;
end;

function TFrameCommServer.SessionCreate(Sender: TRestServer;
  Session: TAuthSession; Ctxt: TRestServerURIContext): boolean;
var
  LOmniValue: TOmniValue;
  rec: TDispMsgRecord;
begin
  rec.FMsg := DateTimeToStr(Now) + ' : Connected from [ ' + Session.RemoteIP + ' : ' + Session.User.LogonName + ' ]';
  rec.FDspTarget := dtConnectLog;
  LOmniValue := TOmniValue.FromRecord<TDispMsgRecord>(rec);
  FDisplayMsgQueue.Enqueue(TOmniMessage.Create(1, LOmniValue));

  AddConnectionToLV(Session.RemoteIP, FPortName, IntToStr(Session.ID), Session.User.LogonName);
//  DisplayMessage(DateTimeToStr(Now) + ' : Connected from [ ' + Session.RemoteIP + ' : ' + Session.User.LogonName + ' ]', dtConnectLog);
  Result := False;
end;

procedure TFrameCommServer.ShowDebug1Click(Sender: TObject);
begin
  AllocConsole;
//  TextColor(ccLightGray); // to force the console to be recognized

  with TSynLog.Family do begin
    Level := LOG_VERBOSE;
    EchoToConsole := LOG_VERBOSE; // log all events to the console
  end;
end;

end.
