unit JHP.Util.gpSharedMem;

interface

uses Windows, Messages, SysUtils, classes, Generics.Collections,
  GpSharedMemory, GpSharedEvents
;

const
  gp_SHARED_MAX_SIZE = 20000000;

type
  TgpKind = (gkProducer, gpListener, gpBoth);
  TgpKinds = set of TgpKind;

  TJHP_gpShM = class
  private
    FSMName,
    FNameSpace,
    FEventName: string;
  public
    FgpSM: TGpSharedMemory;
    FgpEP: TGpSharedEventProducer;
    FgpEL: TGpSharedEventListener;

    constructor Create(const ASMName: string; ANameSpace: string = ''; AEventName: string='');
    destructor Destroy;

//    procedure GpSEEventReceivedNotify(Sender: TObject;
//      producerHandle: TGpSEHandle; const producerName, eventName,
//      eventData: string);
    function InitgpSMEvent(const ANameSpace, AEventName: string; AgpKinds: TgpKinds; AGpEventRecvNotify: TGpSEEventReceivedNotify=nil): integer;
    procedure FinalgpSMEvent(const ANameSpace, AEventName: string; AgpKinds: TgpKinds);

    function InitgpSM4Producer(const ANameSpace, AEventName: string): integer;
    procedure AddEventName2gpSMProducer(const AEventName: string);
    procedure DeleteEventName4gpSMProducer(const AEventName: string);
    procedure FinalgpSM4Producer(const AEventName: string);

    function InitgpSM4Listener(const ANameSpace, AEventName: string;
      AGpEventRecvNotify: TGpSEEventReceivedNotify): integer;
    procedure AddEventName2gpSMListener(const AEventName: string);
    procedure DeleteEventName4gpSMListener(const AEventName: string);
    procedure FinalgpSM4Listener(const AEventName: string);

    function RecvDataFromgpSM: string;
    procedure SendData2gpSM(const AEventName, AData: string);
  end;

implementation

{ TJHP_gpShM }

procedure TJHP_gpShM.AddEventName2gpSMListener(const AEventName: string);
begin
  if not Assigned(FgpEL) then
    exit;

  if (AEventName <> '') then
    FgpEL.MonitoredEvents.Add(AEventName);
end;

procedure TJHP_gpShM.AddEventName2gpSMProducer(const AEventName: string);
begin
  if not Assigned(FgpEP) then
    exit;

  if (AEventName <> '') then
  begin
    FgpEP.PublishedEvents.Add(AEventName);
    FgpEP.Active := True;
  end;
end;

constructor TJHP_gpShM.Create(const ASMName: string; ANameSpace: string = ''; AEventName: string='');
begin
  FSMName := ASMName;
  FNameSpace := ANameSpace;
  FEventName := AEventName;

  FgpSM := TGpSharedMemory.Create(ASMName, 0, gp_SHARED_MAX_SIZE);
end;

procedure TJHP_gpShM.DeleteEventName4gpSMListener(const AEventName: string);
var
  i: integer;
begin
  if FgpEL.MonitoredEvents.Find(AEventName, i) then
    FgpEL.MonitoredEvents.Add(AEventName);
end;

procedure TJHP_gpShM.DeleteEventName4gpSMProducer(const AEventName: string);
var
  i: integer;
begin
  if FgpEP.PublishedEvents.find(AEventName, i) then
    FgpEP.PublishedEvents.delete(i);
end;

destructor TJHP_gpShM.Destroy;
begin
  if Assigned(FgpEP) then
    FgpEP.Free;

  if Assigned(FgpEL) then
    FgpEL.Free;

  if Assigned(FgpSM) then
    FgpSM.Free;
end;

procedure TJHP_gpShM.FinalgpSMEvent(const ANameSpace, AEventName: string; AgpKinds: TgpKinds);
var
  LgpKinds: TgpKinds;
begin
  if gpBoth in AgpKinds then
  begin
    LgpKinds := [gkProducer, gpListener];
  end;

  if gkProducer in AgpKinds then
    FinalgpSM4Producer(AEventName);

  if gpListener in AgpKinds then
    FinalgpSM4Listener(AEventName);
end;

procedure TJHP_gpShM.FinalgpSM4Listener(const AEventName: string);
begin
  if Assigned(FgpEL) then
    FgpEL.Free;
end;

procedure TJHP_gpShM.FinalgpSM4Producer(const AEventName: string);
begin
  if Assigned(FgpEP) then
    FgpEP.Free;
end;

function TJHP_gpShM.InitgpSMEvent(const ANameSpace, AEventName: string; AgpKinds: TgpKinds;
  AGpEventRecvNotify: TGpSEEventReceivedNotify): integer;
var
  LgpKinds: TgpKinds;
begin
  if gpBoth in AgpKinds then
  begin
    LgpKinds := [gkProducer, gpListener];
  end;

  if gkProducer in AgpKinds then
    InitgpSM4Producer(ANameSpace, AEventName);

  if gpListener in AgpKinds then
    InitgpSM4Listener(ANameSpace, AEventName, AGpEventRecvNotify);
end;

function TJHP_gpShM.RecvDataFromgpSM: string;
var
  LStrList: TStringList;
begin
  Result := '';

  LStrList := TStringList.Create;
  try
    if FgpSM.AcquireMemory(False, INFINITE) <> nil then
    begin
      LStrList.LoadFromStream(FgpSM.AsStream);
      Result := LStrList.Strings[1];
    end;

    if FgpSM.Acquired then
      FgpSM.ReleaseMemory;
  finally
    LStrList.Free;
  end;
end;

function TJHP_gpShM.InitgpSM4Listener(const ANameSpace,
  AEventName: string; AGpEventRecvNotify: TGpSEEventReceivedNotify): integer;
begin
  FgpEL := TGpSharedEventListener.Create(nil);
  FgpEL.Namespace := ANameSpace;
//  FGpSharedEventListener.MonitorEvent(gp_EventName4SimEditData);
  FgpEL.MonitoredEvents.Add(AEventName);
  FgpEL.OnEventReceived := AGpEventRecvNotify;
  FgpEL.Active := True;
end;

function TJHP_gpShM.InitgpSM4Producer(const ANameSpace, AEventName: string): integer;
begin
  if Assigned(FgpEP) then
    exit;

  if (AEventName <> '') then
  begin
    FgpEP := TGpSharedEventProducer.Create(nil);
    FgpEP.Namespace := ANameSpace;
    FgpEP.PublishedEvents.Add(AEventName);
    FgpEP.Active := True;
  end;
end;

procedure TJHP_gpShM.SendData2gpSM(const AEventName, AData: string);
var
  LStrList: TStringList;
begin
  LStrList := TStringList.Create;
  try
    LStrList.Add(IntToStr(GetCurrentProcessId));
    LStrList.Add(AData);

    if FgpSM.AcquireMemory(True, INFINITE) <> nil then
    begin
      if FgpSM.IsWriting then
        LStrList.SaveToStream(FgpSM.AsStream);
    end;

    if FgpSM.Acquired then
      FgpSM.ReleaseMemory;

    FgpEP.BroadcastEvent(AEventName,
              FormatDateTime('hh:mm:ss.zzz', Now));
//    FgpEP.PublishEvent(AEventName);
  finally
    LStrList.Free;
  end;
end;

end.
