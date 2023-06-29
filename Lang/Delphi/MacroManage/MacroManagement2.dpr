program MacroManagement2;

uses
  Vcl.Forms,
  UnitMacroRecorderMain2 in 'UnitMacroRecorderMain2.pas' {MacroManageF},
  UnitAction2 in 'UnitAction2.pas' {frmActions},
  UnitNextGridFrame in '..\..\..\..\..\project\common\Frames\UnitNextGridFrame.pas' {Frame1: TFrame},
  UnitMacroListClass2 in 'UnitMacroListClass2.pas',
  UnitNameEdit in '..\..\..\..\..\project\util\MacroManagement\UnitNameEdit.pas' {NameEditF},
  ralarm in '..\..\..\..\..\vcl\ralarm\ralarm.pas',
  thundax.lib.actions_pjh in '..\..\..\..\..\project\common\thundax.lib.actions_pjh.pas',
  SystemCriticalU in '..\..\..\..\..\project\common\SystemCriticalU.pas',
  sndkey32 in '..\..\..\..\..\project\OpenSrc\lib\DelphiDabbler\sndkey32.pas',
  UnitMouseUtil in '..\..\..\..\..\project\common\UnitMouseUtil.pas',
  UnitStringUtil in '..\..\..\..\..\project\common\UnitStringUtil.pas',
  UnitMacroConfigClass in '..\..\..\..\..\project\util\MacroManagement\UnitMacroConfigClass.pas',
  UnitSerialCommThread in '..\..\Common\UnitSerialCommThread.pas',
  UnitCopyData in '..\..\..\..\..\project\Common\UnitCopyData.pas',
  MyKernelObject4GpSharedMem in '..\..\..\..\..\project\Common\MyKernelObject4GpSharedMem.pas',
  FrmSerialCommConfig in '..\..\..\..\..\project\util\MacroManagement\FrmSerialCommConfig.pas' {SerialCommConfigF},
  UnitKeyBdUtil in '..\..\Common\UnitKeyBdUtil.pas',
  Winapi.Hooks in '..\..\OpenSrc\lib\Hooks-master\Winapi.Hooks.pas',
  SendInputHelper in '..\..\OpenSrc\lib\SendInputHelper-master\SendInputHelper.pas',
  IniPersist in '..\..\..\..\..\project\OpenSrc\lib\robstechcorner\rtti\IniPersist.pas',
  FrmEventCaptureConfig in 'FrmEventCaptureConfig.pas' {EventCaptureConfigF},
  UnitPanelUtil in '..\..\Common\UnitPanelUtil.pas',
  UnitEnumHelper in '..\..\..\..\..\project\Common\UnitEnumHelper.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMacroManageF, MacroManageF);
  Application.Run;
end.
