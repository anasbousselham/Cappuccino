object frmModifyAuthentication: TfrmModifyAuthentication
  Left = 289
  Top = 257
  BorderStyle = bsDialog
  Caption = 'Modifier votre login/mot de passe'
  ClientHeight = 167
  ClientWidth = 314
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 12
    Top = 8
    Width = 289
    Height = 113
    TabOrder = 0
    object Label1: TLabel
      Left = 84
      Top = 16
      Width = 69
      Height = 13
      Caption = 'Nouveau lo&gin'
      FocusControl = edtLogin
    end
    object Label2: TLabel
      Left = 20
      Top = 64
      Width = 110
      Height = 13
      Caption = 'Nouveau mot de &passe'
      FocusControl = edtPassword
    end
    object Label3: TLabel
      Left = 148
      Top = 64
      Width = 104
      Height = 13
      Caption = '&Retaper mot de passe'
      FocusControl = edtRetryPassword
    end
    object edtLogin: TEdit
      Left = 84
      Top = 30
      Width = 121
      Height = 21
      MaxLength = 30
      TabOrder = 0
      OnKeyPress = edtLoginKeyPress
    end
    object edtPassword: TEdit
      Left = 20
      Top = 78
      Width = 121
      Height = 21
      MaxLength = 15
      PasswordChar = '*'
      TabOrder = 1
      OnKeyPress = GenericPasswordKeyPress
    end
    object edtRetryPassword: TEdit
      Left = 148
      Top = 78
      Width = 121
      Height = 21
      MaxLength = 15
      PasswordChar = '*'
      TabOrder = 2
      OnKeyPress = GenericPasswordKeyPress
    end
  end
  object btnCancel: TButton
    Left = 79
    Top = 133
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Annuler'
    ModalResult = 2
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object btnOk: TButton
    Left = 159
    Top = 133
    Width = 74
    Height = 25
    Action = actModifyAuthentication
    Default = True
    TabOrder = 2
  end
  object alMain: TActionList
    OnUpdate = alMainUpdate
    Left = 272
    Top = 128
    object actModifyAuthentication: TAction
      Caption = '&Ok'
      OnExecute = actModifyAuthenticationExecute
    end
  end
end
