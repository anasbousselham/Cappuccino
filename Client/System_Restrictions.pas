unit System_Restrictions;

interface

uses ExtCtrls;

type
    TTempTimer = class
    private
        FTimer: TTimer;
        procedure KillMessage(Sender: TObject);
    protected
        constructor Create;
    end; // TTempTimer

procedure DisableAltF4(const Disable: Boolean);
procedure DisableAltTab(const Disable: Boolean);
procedure DisableWindowsKey(const Disable: Boolean);
procedure DisableAltEsc(const Disable: Boolean);
procedure DisableCtrlEsc(const Disable: Boolean);
procedure DisableCtrlAltDel(const Disable: Boolean);
procedure DisableStartButton(const Disable: Boolean);
procedure DisableTray(const Disable: Boolean);
procedure DisableDeskTop(const Disable: Boolean);
procedure DisableRightButton(const Disable: Boolean);
procedure DisableTaskBar(const Disable: Boolean);
procedure DisableTaskMgr(const Disable: Boolean);
procedure ReplaceStartmenu(const Disable: Boolean);
procedure InstallDll;
procedure UninstallDll;

implementation

uses ComputerInfo, SysUtils, Forms, Windows, Registry,Main_frm;

const
    KEY_ALT_F4 = 0;
    KEY_CTRL_ALT_DEL = 1;
    KEY_ALT_TAB = 2;
    KEY_ALT_ESC = 3;
    KEY_CTRL_ESC = 4;
    KEY_WIN = 5;
    KEY_RIGHT_BUTTON = 6;
    ITEM_TASK_BAR = 1;
    ITEM_DESKTOP = 2;
    ITEM_START_BUTTON = 3;
    ITEM_TRAY = 5;

var
    TempTimer: TTempTimer;

procedure wlInstallHook; stdcall;
    external 'dgina.dll' name 'wlInstallHook';
procedure wlUnInstallHook; stdcall;
    external 'dgina.dll' name 'wlUninstallHook';
procedure wlDisableKey (Key:integer; disable: Boolean); stdcall;
    external 'dgina.dll' name 'wlDisableKey';
procedure wlDisableItem(Key:integer; disable: Boolean); stdcall;
    external 'dgina.dll' name 'wlDisableItem';
function  wlIsDisableItem(Item:integer): Boolean; stdcall;
    external 'dgina.dll' name 'wlIsDisableItem';
function  wlVersion: Integer; external 'dgina.dll' name 'wlVersion';

procedure DisableAltF4(const Disable: Boolean);
begin
    wlDisableKey(KEY_ALT_F4, Disable);
//frmMain.WinLock.noAltF4:=Disable;
end; // DisableAltF4

procedure DisableAltTab(const Disable: Boolean);
begin
    wlDisableKey(KEY_ALT_TAB, Disable);
//frmMain.WinLock.noAltTab:=Disable;
end; // DisableAltTab

procedure DisableWindowsKey(const Disable: Boolean);
begin
    wlDisableKey(KEY_WIN, Disable);
//frmMain.WinLock.noWinkeys:=Disable;
end; // DisableWindowsKey

procedure DisableAltEsc(const Disable: Boolean);
begin
    wlDisableKey(KEY_ALT_ESC, Disable);
//frmMain.WinLock.noAltEsc:=disable;
end; // DisableAltEsc

procedure DisableCtrlEsc(const Disable: Boolean);
begin
    wlDisableKey(KEY_CTRL_ESC, Disable);
//frmMain.WinLock.noCtrlEsc:=disable;
end; // DisableCtrlEsc

procedure DisableCtrlAltDel(const Disable: Boolean);
begin
    wlDisableKey(KEY_CTRL_ALT_DEL, Disable);
//frmMain.WinLock.noCtrlAltDel:=disable;
end; // DisableCtrlAltDel

procedure DisableStartButton(const Disable: Boolean);
begin
wlDisableItem(ITEM_START_BUTTON, Disable);
//frmMain.WinLock.noStartbutton:=disable;
end; // DisableStartButton

procedure DisableTray(const Disable: Boolean);
begin
wlDisableItem(ITEM_TRAY, Disable);
//frmMain.WinLock.noTaskTray:=disable;
end; // DisableTray

procedure DisableDeskTop(const Disable: Boolean);
begin
wlDisableItem(ITEM_DESKTOP, Disable);
//frmMain.WinLock.noDesktop:=disable;
end; // DisableDeskTop

procedure DisableRightButton(const Disable: Boolean);
begin
wlDisableKey(KEY_RIGHT_BUTTON, Disable);
//frmMain.WinLock.noRButton:=disable;
end; // DisableRightButton

procedure DisableTaskBar(const Disable: Boolean);
begin
wlDisableItem(ITEM_TASK_BAR, Disable);
//frmMain.WinLock.noTaskRebar:=disable;
end; // DisableTaskBar

procedure DisableTaskMgr(const Disable: Boolean);
var
    Reg: TRegistry;
begin
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey('Software', True);
    Reg.OpenKey('Microsoft', True);
    Reg.OpenKey('Windows', True);
    Reg.OpenKey('CurrentVersion', True);
    Reg.OpenKey('Policies', True);
    Reg.OpenKey('System', True);
    if Disable then
        Reg.WriteString('DisableTaskMgr', '1')
    else
        Reg.DeleteValue('DisableTaskMgr');
    Reg.CloseKey;
end; // DisableTaskMgr

procedure ReplaceStartmenu(const Disable: Boolean);
begin
//frmMain.WinLock.ReplaceStartmenu:=disable;
end;

procedure InstallDll;
var
    Reg: TRegIniFile;
begin
   Reg := TRegIniFile.Create;
    try
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        Reg.WriteString('\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon',
            'GinaDLL', 'dwlgina.dll');
    finally
        Reg.CloseKey;
        Reg.Free;
    end;
    CopyFile(PChar(ExtractFilePath(Application.ExeName) + 'dGina.dll'),
        PChar(Trim(GetWindowsDir(false)) + '\'  + 'dGina.dll'), true);
    CopyFile(PChar(ExtractFilePath(Application.ExeName) + 'dwlGina.dll'),
        PChar(Trim(GetWindowsDir(false))  + '\' + 'dwlGina.dll'), true);
end; // InstallDll

procedure UninstallDll;
var
    Reg: TRegIniFile;
begin
    Reg := TRegIniFile.Create;
    try
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        Reg.DeleteKey('\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon',
            'GinaDLL');
    finally
        Reg.CloseKey;
        Reg.Free;
    end;
    DeleteFile(PChar(Trim(GetWindowsDir(false)) + '\' + 'dGina.dll'));
    DeleteFile(PChar(Trim(GetWindowsDir(false)) + '\' + 'dwlGina.dll'));
end; // UninstallDll

{ TTempTime }

constructor TTempTimer.Create;
begin
    inherited Create;
    FTimer := TTimer.Create(Application.MainForm);
    FTimer.Interval := 10;
    FTimer.Enabled := true;
    FTimer.OnTimer := KillMessage;
end;

procedure TTempTimer.KillMessage(Sender: TObject);
begin
    keybd_event(13, 0, 0, 0);
    FTimer.Enabled := false;
end; // KillMessage

initialization
    TempTimer := TTempTimer.Create;
    try
       wlInstallHook;
    finally
        TempTimer.Free;
    end;
finalization
   wlUnInstallHook;

end.
