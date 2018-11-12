object frmLocked: TfrmLocked
  Left = 241
  Top = 149
  BorderStyle = bsNone
  Caption = 'frmLocked'
  ClientHeight = 449
  ClientWidth = 688
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    688
    449)
  PixelsPerInch = 96
  TextHeight = 13
  object lblTimeLeft: TLabel
    Left = 0
    Top = 0
    Width = 688
    Height = 449
    Align = alClient
    Alignment = taCenter
    Caption = 'lblTimeLeft'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -64
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
    Layout = tlCenter
  end
  object Panel1: TPanel
    Left = 192
    Top = 24
    Width = 305
    Height = 57
    Anchors = []
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 30
      Width = 70
      Height = 13
      Caption = 'Mot de passe :'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lblUser: TLabel
      Left = 0
      Top = 0
      Width = 305
      Height = 20
      Align = alTop
      Alignment = taCenter
      Caption = 'lblUser'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object edtPassword: TEdit
      Left = 85
      Top = 26
      Width = 121
      Height = 21
      MaxLength = 100
      PasswordChar = '*'
      TabOrder = 0
      OnKeyPress = edtPasswordKeyPress
    end
    object btnCheckPW: TButton
      Left = 220
      Top = 24
      Width = 75
      Height = 25
      Action = actCheckPassword
      Default = True
      TabOrder = 1
    end
  end
  object tmrLock: TTimer
    Enabled = False
    OnTimer = tmrLockTimer
    Left = 648
    Top = 8
  end
  object alMain: TActionList
    OnUpdate = alMainUpdate
    Left = 616
    Top = 8
    object actCheckPassword: TAction
      Caption = '&Ok'
      OnExecute = actCheckPasswordExecute
    end
  end
  object tmrSecurity: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = tmrSecurityTimer
    Left = 583
    Top = 8
  end
end
