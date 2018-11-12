unit Config;

interface

uses Registry;

type
    TSettings = class
    private
        Reg: TRegIniFile;
        FFirstBoot, FAllowSave, FLockCtrlAltSuppr, FLockTaskMgr, FHideStartButton,
            FLockWindowsKey, FLockCtrlEsc, FLockRightButton, FReplaceStartButton, FCloseAll: Boolean;
        FServeurHost, FAdminLogin, FAdminPassword, FMonetarySymbol, FLogin_Update, FPassword_Update, FLogo, FPwdClose: string;
        FImagesRefreshRate: Integer; // Refresh Rate in seconds
    public
        constructor Create;
        procedure Save;
        procedure Load;
        property Logo: string read FLogo write FLogo;
        property AdminLogin: string read FAdminLogin write FAdminLogin;
        property Login_Update: string read FLogin_Update write FLogin_Update;
        property Password_Update: string read FPassword_Update write FPassword_Update;
        property AdminPassword: string read FAdminPassword write FAdminPassword;
        property AllowSave: Boolean write FAllowSave;
        property FirstBoot: Boolean read FFirstBoot write FFirstBoot;
        property ImagesRefreshRate: Integer read FImagesRefreshRate write FImagesRefreshRate;
        property MonetarySymbol: string read FMonetarySymbol write FMonetarySymbol;
        property ServeurHost: string read FServeurHost write FServeurHost;
        property LockCtrlAltSuppr: Boolean read FLockCtrlAltSuppr write FLockCtrlAltSuppr;
        property LockCtrlEsc: Boolean read FLockCtrlEsc write FLockCtrlEsc;
        property LockTaskMgr: Boolean read FLockTaskMgr write FLockTaskMgr;
        property LockWindowsKey: Boolean read FLockWindowsKey write FLockWindowsKey;
        property LockRightButton: Boolean read FLockRightButton write FLockRightButton;
        property HideStartButton: Boolean read FHideStartButton write FHideStartButton;
        property ReplaceStartButton: Boolean read FReplaceStartButton write FReplaceStartButton;
        property CloseAll: Boolean read FCloseAll write FCloseAll;
        property PwdClose: String read FPwdClose write FPwdClose;

    end; // TSettings

function Settings: TSettings;

const
    SEC_GENERAL = 'Cappuccino';

implementation

uses SysUtils, Forms, Classes, Windows;

const
    ENCODE_ADDITIONNER = 294;

var
    _Settings: TSettings;

//** Regular Routines *********************************************************

function Settings: TSettings;
begin
    Result := _Settings;
end; // Settings

function EncodePassword(const Password: string): string;
var
    Index: Integer;
    Temp: TStrings;
begin
    Temp := TStringList.Create;
    try
        Temp.Delimiter := '.';
        for Index := 1 to Length(Password) do
            Temp.Add(IntToStr(Ord(Password[Index]) + ENCODE_ADDITIONNER));
        Result := Temp.DelimitedText;
    finally
        Temp.Free;
    end;
end; // EncodePassword

function DecodePassword(const EncodedPasswd: string): string;
var
    Index: Integer;
    Temp: TStrings;
begin
    Result := '';
    Temp := TStringList.Create;
    try
        Temp.Delimiter := '.';
        Temp.DelimitedText := EncodedPasswd;
        for Index := 0 to Temp.Count - 1 do
            Result := Result + Char(StrToInt(Temp[Index]) - ENCODE_ADDITIONNER);
    finally
        Temp.Free;
    end;
end; // DecodePassword

//** TSettings ***************************************************************

constructor TSettings.Create;
begin
    inherited Create;
    FAllowSave := true;
end; // Create

procedure TSettings.Load;
begin
    Reg := TRegIniFile.Create;
    try
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        Reg.OpenKeyReadOnly('SOFTWARE');
        FServeurHost := Reg.ReadString(SEC_GENERAL, 'ServeurHost', '');
        FFirstBoot := Reg.ReadBool(SEC_GENERAL, 'FirstBoot', true);
        FAdminLogin := DecodePassword(Reg.ReadString(SEC_GENERAL, 'L', ''));
        FAdminPassword := DecodePassword(Reg.ReadString(SEC_GENERAL, 'P', ''));
        FImagesRefreshRate := Reg.ReadInteger(SEC_GENERAL, 'ImagesRefreshRate', 5);
        FLockCtrlAltSuppr := Reg.ReadBool(SEC_GENERAL, 'LockCtrlAltSuppr', true);
        FLockTaskMgr := Reg.ReadBool(SEC_GENERAL, 'LockTaskMgr', true);
        FLockWindowsKey := Reg.ReadBool(SEC_GENERAL, 'LockWindowsKey', false);
        FHideStartButton := Reg.ReadBool(SEC_GENERAL, 'HideStartButton', false);
        FMonetarySymbol := Reg.ReadString(SEC_GENERAL, 'MonetarySymbol', 'Dh');
        FLockCtrlEsc := Reg.ReadBool(SEC_GENERAL, 'LockCtrlEsc', false);
        FLockRightButton := Reg.ReadBool(SEC_GENERAL, 'LockRightButton', false);
        FReplaceStartButton:= Reg.ReadBool(SEC_GENERAL, 'ReplaceStartButton', false);
        FCloseAll := Reg.ReadBool(SEC_GENERAL, 'CloseAll', true);
        FLogin_Update := DecodePassword(Reg.ReadString(SEC_GENERAL, 'L_UPDATE', ''));
        FPassword_Update := DecodePassword(Reg.ReadString(SEC_GENERAL, 'P_UPDATE', ''));
        FPwdClose:= DecodePassword(Reg.ReadString(SEC_GENERAL, 'PwdClose',''));
      //  FLogo := Reg.ReadString(SEC_GENERAL, 'Logo', ExtractFilePath(Application.Exename) + 'Logo\'+'logo.bmp');
    finally
        Reg.Free;
    end;
end; // Load

procedure TSettings.Save;
begin
    Reg := TRegIniFile.Create;
    try
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        Reg.OpenKey('SOFTWARE', true);
        Reg.EraseSection(SEC_GENERAL);
        Reg.WriteString(SEC_GENERAL, 'ServeurHost', FServeurHost);
        Reg.WriteBool(SEC_GENERAL, 'FirstBoot', FFirstBoot);
        Reg.WriteString(SEC_GENERAL, 'L', EncodePassword(FAdminLogin));
        Reg.WriteString(SEC_GENERAL, 'P', EncodePassword(FAdminPassword));
        Reg.WriteInteger(SEC_GENERAL, 'ImagesRefreshRate', FImagesRefreshRate);
        Reg.WriteBool(SEC_GENERAL, 'LockCtrlAltSuppr', FLockCtrlAltSuppr);
        Reg.WriteBool(SEC_GENERAL, 'LockTaskMgr', FLockTaskMgr);
        Reg.WriteBool(SEC_GENERAL, 'LockWindowsKey', FLockWindowsKey);
        Reg.WriteBool(SEC_GENERAL, 'HideStartButton', FHideStartButton);
        Reg.WriteString(SEC_GENERAL, 'MonetarySymbol', FMonetarySymbol);
        Reg.WriteBool(SEC_GENERAL, 'LockCtrlEsc', FLockCtrlEsc);
        Reg.WriteBool(SEC_GENERAL, 'LockRightButton', FLockRightButton);
        Reg.WriteBool(SEC_GENERAL, 'ReplaceStartButton', FReplaceStartButton);
        Reg.WriteBool(SEC_GENERAL, 'CloseAll', FCloseAll);
        Reg.WriteString(SEC_GENERAL, 'L_UPDATE', EncodePassword(FLogin_Update));
        Reg.WriteString(SEC_GENERAL, 'P_UPDATE', EncodePassword(FPassword_Update));
        Reg.WriteString(SEC_GENERAL, 'PwdClose', EncodePassword(FPwdClose));
      //  Reg.WriteString(SEC_GENERAL, 'Logo', FLogo);
    finally
        Reg.Free;
    end;
end; // Save

initialization
    _Settings := TSettings.Create;
    _Settings.Load;

finalization
    if _Settings.FAllowSave then
        _Settings.Save;
    _Settings.Free;
end.
