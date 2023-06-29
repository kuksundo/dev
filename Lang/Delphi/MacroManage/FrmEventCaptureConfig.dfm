object EventCaptureConfigF: TEventCaptureConfigF
  Left = 0
  Top = 0
  Caption = 'Event Capture'
  ClientHeight = 416
  ClientWidth = 275
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 275
    Height = 57
    Align = alTop
    Caption = 'Timer Capture'
    TabOrder = 0
    object CheckBox1: TCheckBox
      Tag = 10
      Left = 16
      Top = 24
      Width = 113
      Height = 17
      Hint = 'Checked'
      Caption = 'Capture every (ms)'
      TabOrder = 0
    end
    object SpinEdit1: TSpinEdit
      Tag = 11
      Left = 135
      Top = 22
      Width = 121
      Height = 22
      Hint = 'Value'
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 57
    Width = 275
    Height = 176
    Align = alTop
    Caption = 'Mouse Capture'
    TabOrder = 1
    object MouseCaptureCheck: TCheckBox
      Tag = 20
      Left = 13
      Top = 19
      Width = 230
      Height = 17
      Hint = 'Checked'
      Caption = 'Capture screen at every mouse event'
      TabOrder = 0
      OnClick = MouseCaptureCheckClick
    end
    object MouseCapturePanel: TPanel
      Left = 2
      Top = 42
      Width = 271
      Height = 132
      Align = alBottom
      Enabled = False
      TabOrder = 1
      object JvLabel1: TJvLabel
        Left = 24
        Top = 5
        Width = 56
        Height = 13
        Alignment = taCenter
        Caption = 'Left Button'
        Transparent = True
      end
      object JvLabel2: TJvLabel
        Left = 96
        Top = 4
        Width = 67
        Height = 13
        Alignment = taCenter
        Caption = 'Middle Button'
        Transparent = True
      end
      object JvLabel3: TJvLabel
        Left = 184
        Top = 5
        Width = 62
        Height = 13
        Alignment = taCenter
        Caption = 'Right Button'
        Transparent = True
      end
      object Bevel1: TBevel
        Left = 9
        Top = 2
        Width = 81
        Height = 22
        Shape = bsFrame
      end
      object Bevel2: TBevel
        Left = 87
        Top = 2
        Width = 85
        Height = 22
        Shape = bsFrame
      end
      object Bevel3: TBevel
        Left = 170
        Top = 2
        Width = 88
        Height = 22
        Shape = bsFrame
      end
      object Bevel4: TBevel
        Left = 9
        Top = 22
        Width = 80
        Height = 81
        Shape = bsFrame
      end
      object Bevel5: TBevel
        Left = 87
        Top = 22
        Width = 85
        Height = 81
        Shape = bsFrame
      end
      object Bevel6: TBevel
        Left = 170
        Top = 22
        Width = 88
        Height = 81
        Shape = bsFrame
      end
      object Bevel7: TBevel
        Left = 9
        Top = 101
        Width = 249
        Height = 29
        Shape = bsFrame
      end
      object CheckBox4: TCheckBox
        Tag = 21
        Left = 16
        Top = 32
        Width = 64
        Height = 17
        Hint = 'Checked'
        Caption = 'Clicked'
        Enabled = False
        TabOrder = 0
      end
      object CheckBox5: TCheckBox
        Tag = 22
        Left = 16
        Top = 55
        Width = 64
        Height = 17
        Hint = 'Checked'
        Caption = 'Released'
        Enabled = False
        TabOrder = 1
      end
      object CheckBox6: TCheckBox
        Tag = 23
        Left = 16
        Top = 76
        Width = 77
        Height = 17
        Hint = 'Checked'
        Caption = 'Dbl-Clicked'
        Enabled = False
        TabOrder = 2
      end
      object CheckBox7: TCheckBox
        Tag = 24
        Left = 99
        Top = 32
        Width = 64
        Height = 17
        Hint = 'Checked'
        Caption = 'Clicked'
        Enabled = False
        TabOrder = 3
      end
      object CheckBox8: TCheckBox
        Tag = 25
        Left = 99
        Top = 55
        Width = 64
        Height = 17
        Hint = 'Checked'
        Caption = 'Released'
        Enabled = False
        TabOrder = 4
      end
      object CheckBox9: TCheckBox
        Tag = 26
        Left = 99
        Top = 76
        Width = 77
        Height = 17
        Hint = 'Checked'
        Caption = 'Dbl-Clicked'
        Enabled = False
        TabOrder = 5
      end
      object CheckBox10: TCheckBox
        Tag = 27
        Left = 182
        Top = 32
        Width = 64
        Height = 17
        Hint = 'Checked'
        Caption = 'Clicked'
        Enabled = False
        TabOrder = 6
      end
      object CheckBox11: TCheckBox
        Tag = 28
        Left = 182
        Top = 55
        Width = 64
        Height = 17
        Hint = 'Checked'
        Caption = 'Released'
        Enabled = False
        TabOrder = 7
      end
      object CheckBox12: TCheckBox
        Tag = 29
        Left = 182
        Top = 76
        Width = 74
        Height = 17
        Hint = 'Checked'
        Caption = 'Dbl-Clicked'
        Enabled = False
        TabOrder = 8
      end
      object CheckBox13: TCheckBox
        Tag = 30
        Left = 16
        Top = 105
        Width = 148
        Height = 17
        Hint = 'Checked'
        Caption = 'MouseWheel activated'
        Enabled = False
        TabOrder = 9
      end
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 233
    Width = 275
    Height = 144
    Align = alTop
    Caption = 'Keyboard Capture'
    TabOrder = 2
    object KeyBoardCaptureCheck: TCheckBox
      Tag = 40
      Left = 16
      Top = 24
      Width = 240
      Height = 17
      Hint = 'Checked'
      Caption = 'Capture screen at every keyboard event'
      TabOrder = 0
      OnClick = KeyBoardCaptureCheckClick
    end
    object KeyBoardCapturePanel: TPanel
      Left = 2
      Top = 47
      Width = 271
      Height = 95
      Align = alBottom
      Enabled = False
      TabOrder = 1
      object Bevel8: TBevel
        Left = 9
        Top = 7
        Width = 249
        Height = 57
        Shape = bsFrame
      end
      object CheckBox14: TCheckBox
        Tag = 41
        Left = 16
        Top = 8
        Width = 89
        Height = 17
        Hint = 'Checked'
        Caption = 'Key Clicked'
        Enabled = False
        TabOrder = 0
      end
      object CheckBox15: TCheckBox
        Tag = 42
        Left = 16
        Top = 28
        Width = 113
        Height = 17
        Hint = 'Checked'
        Caption = 'Key Released'
        Enabled = False
        TabOrder = 1
      end
      object CheckBox16: TCheckBox
        Tag = 43
        Left = 16
        Top = 46
        Width = 105
        Height = 17
        Hint = 'Checked'
        Caption = 'Only these keys:'
        Enabled = False
        TabOrder = 2
      end
      object Edit1: TEdit
        Tag = 44
        Left = 16
        Top = 66
        Width = 240
        Height = 21
        Hint = 'Text'
        BevelInner = bvLowered
        Enabled = False
        TabOrder = 3
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 377
    Width = 275
    Height = 39
    Align = alClient
    TabOrder = 3
    object BitBtn1: TBitBtn
      Left = 32
      Top = 6
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 160
      Top = 6
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
    end
  end
end
