object frmOptions: TfrmOptions
  Left = 256
  Top = 213
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Param'#232'tres'
  ClientHeight = 300
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    000001000200101000000100180068030000260000002020100001000400E802
    00008E0300002800000010000000200000000100180000000000000300000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    00B5B5B5A6A6A6A5A5A5A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6A6
    A6A6A6A6A6A6A6A69B9B9B6F6F6FB89582744836693E2C693E2C693E2C693E2C
    693E2C69402C693E2C693E2C693E2C693E2C693E2C6B3E2CBC917F4D4D4DC59A
    7DD5CABDD1C6B7D2C6B7D2C7B9D0C9BEDBCFBDE7D3B4D4C8B7D2CBBED0C9BDD1
    C6B6D2C6B7D9CBBDBC917F4D4D4DBC917FE5FFFFE1FCFFE1FFFFF0FFFFFFFFEF
    C8E0F99589A6F7EED2F8FFFFE7F8FFE7F8FFE7F8FFE9FFFFBC917F4D4D4DBC91
    7FE0FBFFE7F8FFE7F8FF7C95D08567807D89A11476CBB1847A4D549DCDB0A3E8
    FAFDE7F8FFE7F8FFBC917F4D4D4DBC917FE2FBFFE7F8FFE7F8FF7FC2DD2B86D2
    4096D664E8FF246CBD099CE6A8B2A4FDEBD0E7F8FFE7F8FFBC917F4D4D4DBC91
    7FE2FBFFE7F8FF7384BC387FC581F1FF64D9FC5CCAEF4ED7FD3DCDF31B49A3C5
    B0AFE7F8FFE7F8FFBC917F4D4D4DBC917FE3FCFFE7F8FF92D3EE60CFF76BDCFF
    BBE3EF785E591E6AA523B4EB01A5E2B0CED3E7F8FFE7F8FFBC917F4D4D4DBC91
    7FE2FCFFE7F8FFE7F8FF83C3EC54CEFBDBF1F8785750278FB02BBFF085C9D5DE
    F4F8E7F8FFE7F8FFBC917F4D4D4DBC917FE3FCFFE7F8FFE7F8FFA9C1E05DD2FE
    CEE2E5503835449DAF43CCF9F1E6E1E7F8FFE7F8FFE7FDFFBC917F4D4D4DBC91
    7FE8FFFFE7F8FFE7F8FFECFFFFE8FFFFDDDBD3545454C7D0D5EEFFFFECFDFFE7
    F9FFE5F8FFECFFFFBC917F4D4D4DBC917FDCEBE6DAE2DCDBE2DBDDE2DCE1E4DD
    E0E7DFE5EADEE5E8E2E2E4DDDBE1DBD9DDD8D9DFD9E4EBDEBC917F4E4E4EB259
    01AD5401AD5501AC5301AB5601AD5501AD5401AE5701AD5401AC5401AD5501B4
    600FB75F0599592AAF6B2C686868DA8729E48A21E48516E38315E38314E48417
    E48417E38416E38114E2810EE1800EE88B20EE8C1BCC8747C885420000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000FFFF00008000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    00000000000000010000FFFF0000280000002000000040000000010004000000
    0000000200000000000000000000000000000000000000000000000080000080
    00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
    000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    00000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pcMain: TPageControl
    Left = 8
    Top = 7
    Width = 441
    Height = 256
    ActivePage = tsIdentification
    MultiLine = True
    TabOrder = 0
    OnChange = pcMainChange
    object tsIdentification: TTabSheet
      Caption = 'Identification'
      object GroupBox1: TGroupBox
        Left = 16
        Top = 8
        Width = 401
        Height = 121
        Caption = 'Protection'
        TabOrder = 0
        object Label2: TLabel
          Left = 71
          Top = 30
          Width = 170
          Height = 13
          Caption = 'Adresse IP du serveur Cappuccino :'
          FocusControl = edtServeurHost
        end
        object Label1: TLabel
          Left = 54
          Top = 59
          Width = 187
          Height = 13
          Caption = '&Login administrateur sur cette machine :'
          FocusControl = edtLogin
        end
        object Label3: TLabel
          Left = 16
          Top = 91
          Width = 225
          Height = 13
          Caption = '&Mot de passe administrateur sur cette machine :'
          FocusControl = edtPassword
        end
        object edtServeurHost: TEdit
          Left = 248
          Top = 25
          Width = 121
          Height = 21
          TabOrder = 0
          OnKeyPress = GenericWithoutSpaceKeyPress
        end
        object edtLogin: TEdit
          Left = 248
          Top = 55
          Width = 121
          Height = 21
          TabOrder = 1
          OnKeyPress = edtLoginKeyPress
        end
        object edtPassword: TEdit
          Left = 248
          Top = 87
          Width = 121
          Height = 21
          PasswordChar = '*'
          TabOrder = 2
          OnKeyPress = GenericWithoutSpaceKeyPress
        end
      end
      object GroupBox2: TGroupBox
        Left = 16
        Top = 136
        Width = 257
        Height = 81
        Caption = 'Compte Mise '#224' jour'
        TabOrder = 1
        object Label4: TLabel
          Left = 24
          Top = 24
          Width = 83
          Height = 13
          Caption = 'Nom d'#39'utilisateur :'
        end
        object Label5: TLabel
          Left = 24
          Top = 48
          Width = 64
          Height = 13
          Caption = 'Mot de pass :'
        end
        object edtLogin_Update: TEdit
          Left = 120
          Top = 24
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object edtPassword_Update: TEdit
          Left = 120
          Top = 48
          Width = 121
          Height = 21
          PasswordChar = '*'
          TabOrder = 1
        end
      end
      object GroupBox3: TGroupBox
        Left = 280
        Top = 136
        Width = 137
        Height = 81
        Caption = 'OTP'
        TabOrder = 2
        object Label7: TLabel
          Left = 10
          Top = 38
          Width = 72
          Height = 13
          Caption = 'Date Password'
        end
        object edtPwdClose: TEdit
          Left = 88
          Top = 34
          Width = 41
          Height = 21
          MaxLength = 6
          PasswordChar = '*'
          TabOrder = 0
        end
      end
    end
    object tsRestrictions: TTabSheet
      Caption = 'Restrictions'
      ImageIndex = 3
      object Label6: TLabel
        Left = 32
        Top = 56
        Width = 334
        Height = 13
        Caption = 
          'Cochez les options que vous voulez bloquer durant une session cl' +
          'ient :'
      end
      object Label8: TLabel
        Left = 8
        Top = 8
        Width = 409
        Height = 13
        Caption = 
          'Ces parametres ne s'#39'appliqueront pas pendant une session adminis' +
          'trateur et il n'#39'est pas'
      end
      object Label9: TLabel
        Left = 8
        Top = 24
        Width = 349
        Height = 13
        Caption = 
          'possible de modifier les restrictions pendant l'#39#233'cran d'#39'ouvertur' +
          'e de session.'
      end
      object chkLockCtrlAltSuppr: TCheckBox
        Left = 16
        Top = 152
        Width = 137
        Height = 17
        Caption = 'Bloquer le Ctrl-Alt-Suppr'
        TabOrder = 3
      end
      object chkHideStartButton: TCheckBox
        Left = 16
        Top = 104
        Width = 145
        Height = 17
        Caption = 'Cacher le bouton d'#233'marrer.'
        TabOrder = 1
      end
      object chkLockWindowsKey: TCheckBox
        Left = 16
        Top = 80
        Width = 201
        Height = 17
        Caption = 'Bloquer la touche Windows du clavier.'
        TabOrder = 0
      end
      object chkLockTaskMgr: TCheckBox
        Left = 16
        Top = 176
        Width = 185
        Height = 17
        Caption = 'Bloquer le gestionnaire des t'#226'ches.'
        TabOrder = 4
      end
      object chkLockCtrlEsc: TCheckBox
        Left = 16
        Top = 128
        Width = 177
        Height = 17
        Caption = 'Bloquer le raccourci Ctrl + Echap'
        TabOrder = 2
      end
      object chkLockRightButton: TCheckBox
        Left = 16
        Top = 200
        Width = 185
        Height = 17
        Caption = 'Bloquer le bouton droit de la souris'
        TabOrder = 5
      end
      object chkReplaceStartButton: TCheckBox
        Left = 232
        Top = 80
        Width = 177
        Height = 17
        Caption = 'Remplacer le boutton D'#233'marrer'
        TabOrder = 6
      end
      object chkCloseAll: TCheckBox
        Left = 176
        Top = 104
        Width = 249
        Height = 17
        Caption = 'Fermer toutes les applications a la d'#233'connection'
        Checked = True
        State = cbChecked
        TabOrder = 7
      end
    end
    object tsInstall: TTabSheet
      Caption = 'Installation'
      ImageIndex = 3
      object btnUpDate: TButton
        Left = 104
        Top = 78
        Width = 225
        Height = 25
        Hint = 
          'Permet de r'#233'installer les dll ainsi que de mettre a jour la base' +
          ' de registre'
        Caption = '&Mettre '#224' jour les dll et la base de registre'
        TabOrder = 0
        OnClick = btnUpDateClick
      end
      object btnRemoveRegistryEntries: TButton
        Left = 104
        Top = 126
        Width = 225
        Height = 25
        Hint = 
          'Permet de r'#233'installer les dll ainsi que de mettre a jour la base' +
          ' de registre'
        Caption = '&Retirer les modifications de la base de registre'
        TabOrder = 1
        OnClick = btnRemoveRegistryEntriesClick
      end
    end
  end
  object btnOk: TButton
    Left = 374
    Top = 269
    Width = 75
    Height = 25
    Action = actApply
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object alMain: TActionList
    OnUpdate = alMainUpdate
    Left = 388
    Top = 232
    object actApply: TAction
      Caption = 'Ok'
      OnExecute = actApplyExecute
    end
    object actAddImage: TAction
      Caption = '&Ajouter'
    end
    object actDeleteImage: TAction
      Caption = '&Supprimer'
    end
  end
  object opdgMain: TOpenPictureDialog
    Filter = 
      'Tous (*.jpg;*.jpeg;*.bmp;*.ico;*.emf;*.wmf)|*.jpg;*.jpeg;*.bmp;|' +
      'Fichier image JPEG (*.jpg)|*.jpg|Fichier image JPEG (*.jpeg)|*.j' +
      'peg|Bitmaps (*.bmp)|*.bmp'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 420
    Top = 232
  end
  object popImages: TPopupMenu
    Left = 356
    Top = 232
    object Ajouter1: TMenuItem
      Action = actAddImage
    end
    object Supprimer1: TMenuItem
      Action = actDeleteImage
    end
  end
end
