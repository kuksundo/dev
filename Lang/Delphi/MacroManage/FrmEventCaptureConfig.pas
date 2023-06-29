unit FrmEventCaptureConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ExtCtrls, JvExControls, JvLabel, Vcl.Buttons,
  UnitConfigIniClass2, IniPersist;

type
  TEventCaptureConfig = class(TINIConfigBase)
  private
    FTimerCaptureInterval,
    FEnableMouseCapture,
    FMouseLBtnDown,
    FMouseLBtnUp,
    FMouseLBtnDblClick,
    FMouseMBtnDown,
    FMouseMBtnUp,
    FMouseMBtnDblClick,
    FMouseRBtnDown,
    FMouseRBtnUp,
    FMouseRBtnDblClick,
    FMouseWheelActivate,
    FEnableKeyboardCapture,
    FKeyboardDown,
    FKeyboardUp,
    FKeyboardTextEnable
    : Boolean;

    FTimerInterval: integer;
    FKeyboardText: string;
  published
    //Section Name, Key Name, Default Key Value  (Control.hint = SectionName;KeyName 으로 저장 함)
    [IniValue('Timer','Timer Capture Enable', 'False', 10)]
    property TimerCaptureInterval : Boolean read FTimerCaptureInterval write FTimerCaptureInterval;
    [IniValue('Timer','Timer Capture Enable', '0', 11)]
    property TimerInterval : integer read FTimerInterval write FTimerInterval;

    [IniValue('Mouse','Mouse Capture Enable', 'False', 20)]
    property EnableMouseCapture : Boolean read FEnableMouseCapture write FEnableMouseCapture;
    [IniValue('Mouse','Mouse Left Button Down', 'False', 21)]
    property MouseLBtnDown : Boolean read FMouseLBtnDown write FMouseLBtnDown;
    [IniValue('Mouse','Mouse Left Button Up', 'False', 22)]
    property MouseLBtnUp : Boolean read FMouseLBtnUp write FMouseLBtnUp;
    [IniValue('Mouse','Mouse Left Button Dbl Click', 'False', 23)]
    property MouseLBtnDblClick : Boolean read FMouseLBtnDblClick write FMouseLBtnDblClick;
    [IniValue('Mouse','Mouse Middle Button Down', 'False', 24)]
    property MouseMBtnDown : Boolean read FMouseMBtnDown write FMouseMBtnDown;
    [IniValue('Mouse','Mouse Middle Button Up', 'False', 25)]
    property MouseMBtnUp : Boolean read FMouseMBtnUp write FMouseMBtnUp;
    [IniValue('Mouse','Mouse Middle Button Dbl Click', 'False', 26)]
    property MouseMBtnDblClick : Boolean read FMouseMBtnDblClick write FMouseMBtnDblClick;
    [IniValue('Mouse','Mouse Right Button Down', 'False', 27)]
    property MouseRBtnDown : Boolean read FMouseRBtnDown write FMouseRBtnDown;
    [IniValue('Mouse','Mouse Right Button Up', 'False', 28)]
    property MouseRBtnUp : Boolean read FMouseRBtnUp write FMouseRBtnUp;
    [IniValue('Mouse','Mouse Right Button Dbl Click', 'False', 29)]
    property MouseRBtnDblClick : Boolean read FMouseRBtnDblClick write FMouseRBtnDblClick;
    [IniValue('Mouse','Mouse Wheel Activate', 'False', 30)]
    property MouseWheelActivate : Boolean read FMouseWheelActivate write FMouseWheelActivate;

    [IniValue('Keyboard','Keyboard Capture Enable', 'False', 40)]
    property EnableKeyboardCapture : Boolean read FEnableKeyboardCapture write FEnableKeyboardCapture;
    [IniValue('Keyboard','Keyboard Down', 'False', 41)]
    property KeyboardDown : Boolean read FKeyboardDown write FKeyboardDown;
    [IniValue('Keyboard','Keyboard Up', 'False', 42)]
    property KeyboardUp : Boolean read FKeyboardUp write FKeyboardUp;
    [IniValue('Keyboard','Keyboard Text Enable', 'False', 43)]
    property KeyboardTextEnable : Boolean read FKeyboardTextEnable write FKeyboardTextEnable;
    [IniValue('Keyboard','Keyboard Text', '', 44)]
    property KeyboardText : string read FKeyboardText write FKeyboardText;
  end;

  TEventCaptureConfigF = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    CheckBox1: TCheckBox;
    SpinEdit1: TSpinEdit;
    MouseCaptureCheck: TCheckBox;
    KeyBoardCaptureCheck: TCheckBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    MouseCapturePanel: TPanel;
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    JvLabel3: TJvLabel;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    KeyBoardCapturePanel: TPanel;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    Edit1: TEdit;
    Bevel8: TBevel;
    procedure MouseCaptureCheckClick(Sender: TObject);
    procedure KeyBoardCaptureCheckClick(Sender: TObject);
  private
    { Private declarations }
  public
  end;

  procedure CreateEventCaptureConfigF(AEventCaptureConfig: TEventCaptureConfig;
    AFileName: string);

implementation

uses UnitPanelUtil;

{$R *.dfm}

procedure CreateEventCaptureConfigF(AEventCaptureConfig: TEventCaptureConfig;
    AFileName: string);
var
  LEventCaptureConfigF: TEventCaptureConfigF;
begin
  LEventCaptureConfigF := TEventCaptureConfigF.Create(nil);
  try
    if FileExists(AFileName) then
      AEventCaptureConfig.Load(AFileName);

    TINIConfigBase.LoadConfig2Form(TForm(LEventCaptureConfigF), AEventCaptureConfig);

    if LEventCaptureConfigF.ShowModal = mrOK then
    begin
      TINIConfigBase.LoadConfigForm2Object(TForm(LEventCaptureConfigF), AEventCaptureConfig);

      if AFileName = '' then
        AFileName := ChangeFileExt(Application.ExeName, '.ini');

      AEventCaptureConfig.Save(AFileName, AEventCaptureConfig);
    end;
  finally
    LEventCaptureConfigF.Free;
  end;
end;

procedure TEventCaptureConfigF.KeyBoardCaptureCheckClick(Sender: TObject);
begin
  KeyBoardCapturePanel.Enabled := KeyBoardCaptureCheck.Checked;
  SetEnableComponentsOnPanel(KeyBoardCapturePanel, KeyBoardCapturePanel.Enabled);
end;

procedure TEventCaptureConfigF.MouseCaptureCheckClick(Sender: TObject);
begin
  MouseCapturePanel.Enabled := MouseCaptureCheck.Checked;
  SetEnableComponentsOnPanel(MouseCapturePanel, MouseCapturePanel.Enabled);
end;

end.
