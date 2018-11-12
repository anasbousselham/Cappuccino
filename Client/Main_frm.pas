unit Main_frm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDCustomPanelFill, StdCtrls, ActnList,
  IdTCPConnection, IdTCPClient, IdBaseComponent, IdComponent, IdIPWatch,
  LMDBaseLabel,  LMDCustomSimpleLabel, LMDSimpleLabel, jpeg, IdTCPServer,
  LMDControl, LMDBaseControl, LMDBaseGraphicControl, JvComponent,
  dxCore, dxButtons, buttons, ShellAPI, Menus,
  MMSYSTEM,ShlObj, ComObj, ComCtrls, auHTTP, auAutoUpgrader,
  LMDCustomComponent, LMDOneInstance,registry, GIFImage, TFlatEditUnit;


  type
  rsp=function (dwProcessID,dwType:DWord):DWORD;stdcall;
  TMessageType = record
    Msg, FontName: string;
    Size, Seconds: Integer;
    Color: TColor;
  end; // TMessageType

type
  TCustomer = record
    Login, FirstName, SurName, Password: string;
    Id, TimeLeft,TotalTime: Integer;
    FirstLog, FreeCompte: Boolean;
    StartDate,DateConnection: TDateTime;
    DateValidite: Tdate;
    Account: Double;
  end; // TCustomer

  TfrmMain = class(TForm)
    Image1: TImage;
    ipwMain: TIdIPWatch;
    itcMain: TIdTCPClient;
    alMain: TActionList;
    actCheckPassWord: TAction;
    itsMain: TIdTCPServer;
    tmrMessage: TTimer;
    tmrSecurity: TTimer;
    tmrAdminSession: TTimer;
    tmrEndSession: TTimer;
    dxButton1: TdxButton;
    tmredtLoginFocus: TTimer;
    ProgressBarFree: TProgressBar;
    Label1: TLabel;
    auAutoUpgrader1: TauAutoUpgrader;
    Label2: TLabel;
    LMDOneInstance1: TLMDOneInstance;
    CloseAdmin: TTimer;
    edtLogin: TFlatEdit;
    edtPassword: TFlatEdit;
    procedure alMainUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actCheckPassWordExecute(Sender: TObject);
    procedure itsMainichSetTimeLeftCommand(ASender: TIdCommand);
    procedure itsMainichSetUserCommand(ASender: TIdCommand);
    procedure itsMainichStartSessionCommand(ASender: TIdCommand);
    procedure itsMainichEndSessionCommand(ASender: TIdCommand);
    procedure itsMainichLogErrorMessageCommand(ASender: TIdCommand);
    procedure itsMainStartAdminSessionCommand(ASender: TIdCommand);
    procedure itsMainichMessageCommand(ASender: TIdCommand);
    procedure itsMainichAbordShutdownCommand(ASender: TIdCommand);
    procedure itsMainichLogOffCommand(ASender: TIdCommand);
    procedure itsMainichShutdownCommand(ASender: TIdCommand);
    procedure itsMainichRebootCommand(ASender: TIdCommand);
    procedure itsMainichKillProcessCommand(ASender: TIdCommand);
    procedure itsMainichSendProcessListCommand(ASender: TIdCommand);
    procedure itsMainichChangeAuthenticationMsgCommand(
      ASender: TIdCommand);
    procedure itsMainichLockSessionCommand(ASender: TIdCommand);
    procedure itsMainichScreenImageCommand(ASender: TIdCommand);
    procedure itsMainichSetServeurHostCommand(ASender: TIdCommand);
    procedure itsMainichConnexionCheckCommand(ASender: TIdCommand);
    procedure itsMainichSetLoginPasswordCommand(ASender: TIdCommand);
    procedure itsMainichGetOSCommand(ASender: TIdCommand);
    procedure itsMainichGetMemoryCommand(ASender: TIdCommand);
    procedure itsMainichSetAccountCommand(ASender: TIdCommand);
    procedure itsMainichSessionModifiedCommand(ASender: TIdCommand);
    procedure itsMainichGetComputerHostCommand(ASender: TIdCommand);
    procedure itsMainichSetRightsCommand(ASender: TIdCommand);
    procedure itsMainichAddToStartupCommand(ASender: TIdCommand);
    procedure itsMainichUninstallCommand(ASender: TIdCommand);
    procedure tmrAdminSessionTimer(Sender: TObject);
    procedure tmredtLoginFocusTimer(Sender: TObject);
    procedure tmrEndSessionTimer(Sender: TObject);
    procedure tmrSecurityTimer(Sender: TObject);
    procedure tmrMessageTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure itsMainConnect(AThread: TIdPeerThread);
    procedure itsMainDisconnect(AThread: TIdPeerThread);
    procedure itsMainichRunShellCommand(ASender: TIdCommand);
    procedure itsMainichOpenCdCommand(ASender: TIdCommand);
    procedure itsMainichCloseCdCommand(ASender: TIdCommand);
    procedure itsMainichFreeRamCommand(ASender: TIdCommand);
    procedure auAutoUpgrader1Progress(Sender: TObject;
      const FileURL: String; FileSize, BytesRead, ElapsedTime,
      EstimatedTimeLeft: Integer; PercentsDone, TotalPercentsDone: Byte;
      TransferRate: Single);
    procedure itsMainichUpdateCommand(ASender: TIdCommand);
    procedure auAutoUpgrader1BeginUpgrade(Sender: TObject;
      const UpgradeMsg: String; UpgradeMethod: TacUpgradeMethod;
      Files: TStringList; var CanUpgrade: Boolean);
    procedure itsMainNoCommandHandler(ASender: TIdTCPServer;
      const AData: String; AThread: TIdPeerThread);
    procedure itsMainException(AThread: TIdPeerThread;
      AException: Exception);
    procedure CloseAdminTimer(Sender: TObject);
    procedure edtLoginKeyPress(Sender: TObject; var Key: Char);

     private
       { Private declarations }
       FAdminSession: Boolean;
    FThread: TIdPeerThread;
    FUserList: TStrings;
    FMessageType: TMessageType;
    procedure StartCustomerSession;
    procedure StartAdminSession;
    procedure MemAllocMemory(Sender: TObject; AQuantity: integer);
    procedure MemDeallocMemory(Sender: TObject; AQuantity: integer);
    procedure GetVersion;
    procedure erraseyahoo;
    procedure errasemsn;
  public
       { Public declarations }
    procedure IsADActive();
    procedure ActiveDeskDesactive();
    procedure EndCustomerSession;
    procedure EndAdminSession;
    procedure UpDateTimeLeft;
    procedure KillNewProcess;

    function TryToConnect: Boolean;
    FUNCTION MyExitWindows(RebootParam:LongWord) : Boolean;
    property UserList: TStrings read FUserList;
    property AdminSession: Boolean read FAdminSession;

  end;
procedure SetRights(const Reason: Integer); // 0: Locked, 1:Customer, 2:Admin
function ApplicationRunning: Boolean;
procedure CloseActiveWindows(const NeededActiveForm: TForm);
procedure WriteEventInLog( StrEvent : string ) ;

var
  frmMain: TfrmMain;
  Customer: TCustomer;
implementation

{$R *.dfm}

uses Process, IdException, Session_Open_frm, Config, Message_frm, ShutDown,
    System_Restrictions, Options_frm, Locked_frm, ComputerInfo,
    FirstLog_frm, Math, Modify_Authentication_frm, SearchFiles, StrUtils,
    URLEnc, uMem, UInfoVersion, Information_frm, u_Saeubern;

var
    OldProcessList: TStrings;

    //////////////////////////////////////

function ApplicationRunning: Boolean;
var
    Index: Integer;
    Process: TProcess;
begin
    Result := true;
    UpDateProcessList;
    for Index := 0 to ProcessList.Count - 1 do
    begin
        Process := ProcessList[Index];
        if (Process.Name = ExtractFileName(Application.ExeName)) and
            (Process.Id <> GetCurrentProcessId) then
            Exit;
    end;
    Result := false;
end; // ApplicationRunning

procedure SetAppCurrDir ;
begin
     SetCurrentDir(ExtractFileDir(Application.ExeName));
end ;

Function TimeStamp : string ;
begin
     result := FormatDateTime( 'dd/mm/yyyy"  |  "hh:nn:ss', Now ) ;

end ;

procedure WriteEventInLog( StrEvent : string ) ;

var       FEvents : textfile;
          StrTimestamp : string ;
          IOStatus : integer ;
begin
     try
        SetAppCurrDir ;
        StrTimestamp := TimeStamp ;
        if ( FileExists('monitor.log') )
           then begin
                     {$I-}
                     AssignFile(FEvents,'monitor.log');
                     Append(FEvents);
                     IOStatus := IOResult ;
                     {$I+}
                end
           else begin
                     {$I-}
                     AssignFile(FEvents,'monitor.log');
                     Rewrite(FEvents);
                     IOStatus := IOResult ;
                     {$I+}
                end;
        if ( IOStatus <> 0 )
           then
               case IOStatus of
               101 : showmessage('Disk is Full : '+  StrTimestamp );
               102 : showmessage('File not Assigned: ' +  StrTimestamp );
               103 : showmessage('File not Open: ' +  StrTimestamp );
               105 : showmessage('File not Open for Output: ' +  StrTimestamp );
               else showmessage('Unknown I/O Error [' + inttostr(iostatus) + '] ' + StrTimestamp );
               end
           else Writeln(FEvents, StrTimestamp + '  ' + StrEvent ) ;
        {$I-}
        CloseFile(FEvents);
        {$I+}
     except
        on EFOpenError do
             MessageDlg('File of log of events could not be opened.',mtWarning,[mbOK],0);
        on EFCreateError do
             MessageDlg('File of log of events could not be created.',mtWarning,[mbOK],0);
     end;
end;


FUNCTION TfrmMain.MyExitWindows(RebootParam:LongWord) : Boolean;
VAR
  cbtpPrevious          : DWORD;
  pcbtpPreviousRequired : DWORD;
  tpResult              : Boolean;
  TTokenHd              : THandle;
  TTokenPvg             : TTokenPrivileges;
  rTTokenPvg            : TTokenPrivileges;
BEGIN
  IF Win32Platform=VER_PLATFORM_WIN32_NT THEN BEGIN
    tpResult:=OpenProcessToken(GetCurrentProcess(),TOKEN_ADJUST_PRIVILEGES OR TOKEN_QUERY,TTokenHd);
    IF tpResult THEN BEGIN
      tpResult:=LookupPrivilegeValue(NIL,'SeShutdownPrivilege',TTokenPvg.Privileges[0].Luid); //"SeShutdownPrivilege"
      TTokenPvg.PrivilegeCount:=1;
      TTokenPvg.Privileges[0].Attributes:=SE_PRIVILEGE_ENABLED;
      cbtpPrevious:=SizeOf(rTTokenPvg);
      pcbtpPreviousRequired:=0;
      IF tpResult THEN Windows.AdjustTokenPrivileges(TTokenHd,False,TTokenPvg,cbtpPrevious,rTTokenPvg,pcbtpPreviousRequired);
    END;
  END;
  Result:=ExitWindowsEx(RebootParam,0);
END;

procedure cacherapp;

var h:thandle;
RegisterServiceProcess:rsp;
begin
//Application.ShowMainForm:=False;
h:=LoadLibrary('KERNEL32.DLL');
 if h<>0 then
 begin
  RegisterServiceProcess:=GetProcAddress(h,'RegisterServiceProcess');
  if @RegisterServiceProcess<>nil then RegisterServiceProcess(GetCurrentProcessID,1);
  FreeLibrary(h);
 end;
     end;

procedure CloseActiveWindows(const NeededActiveForm: TForm);
var
    AHandle: HWND;
    Index: Integer;
begin
    if frmSessionOpen.Tag = 1 then
        Exit;
    Index := 0;
    while not Application.Active and (Index < 100) do
    begin
        Inc(Index);
        AHandle := GetForegroundWindow;
        if (AHandle <> frmMain.Handle) and (AHandle <> frmLocked.Handle) and
            (AHandle <> frmSessionOpen.Handle) and (AHandle <> frmModifyAuthentication.Handle) and (AHandle <> frmInformation.Handle) then
            CloseWindow(AHandle)
        else
            Exit;
    end;
end; // CloseActiveWindows

Function AfficheBarreDeTaches(Affiche:Boolean):Boolean;
Var BarreDeTaches : HWnD;
begin
BarreDeTaches:=FindWindow('Shell_TrayWnd', NIL);
if BarreDeTaches<>Null then
if Affiche then
ShowWindow(BarreDeTaches, SW_SHOW) // Afficher
Else
ShowWindow(BarreDeTaches, SW_HIDE); // Masquer
Result:=BarreDeTaches<>Null;
end;

procedure TfrmMain.IsADActive();
Var ADesk: IActiveDesktop;
    ADOpt: _tagCOMPONENTSOPT;
begin

    Try
      ADOpt.dwSize := SizeOf(ADOpt);
      ADesk := CreateComObject(CLSID_ActiveDesktop) as IActiveDesktop;
      ADesk.GetDesktopItemOptions(ADOpt,0);
      If ADOpt.fActiveDesktop then
       begin
       //
       end
      else
       ActiveDeskDesactive();
    Except
      On Exception Do ShowMessage('Une erreur est apparue lors de' + #13 +
                                  'la désactivation de Active Desktop...');
    end;

end;


procedure TFrmMain.GetVersion;
begin
  with TInfoVersion.create(ParamStr(0)) do
  try
    Label2.Caption := Format('Client Cappuccino V %d.%d build %d', [GetMajorNum,
      GetMinorNum, GetBuildNum]);
  finally
    free;
  end;
end;

procedure TfrmMain.ActiveDeskDesactive();
Var ADesk: IActiveDesktop;
    ADOpt: _tagCOMPONENTSOPT;
begin

    Try
      ADOpt.dwSize := sizeof(ADOpt);
      ADOpt.fActiveDesktop := False;
      ADOpt.fEnableComponents := False;
      ADesk := CreateComObject(CLSID_ActiveDesktop) as IActiveDesktop;
      ADesk.SetDesktopItemOptions(ADOpt,0);
      ADesk.ApplyChanges(AD_APPLY_ALL or AD_APPLY_FORCE);
    Except
      On Exception Do ShowMessage('Une erreur est apparue lors de' + #13 +
                                  'la désactivation de Active Desktop...');
    end;
  IsADActive()
end;

procedure TfrmMain.itsMainichAddToStartupCommand(ASender: TIdCommand);
begin
    if ASender.UnparsedParams = '1' then
        LaunchApplicationOnStartup
    else
        RemoveApplicationToStartup;
end;

procedure TfrmMain.itsMainichSetRightsCommand(ASender: TIdCommand);
begin
    Settings.LockWindowsKey := ASender.Params[0] = '1';
    Settings.HideStartButton := ASender.Params[1] = '1';
    Settings.LockCtrlEsc := ASender.Params[2] = '1';
    Settings.LockCtrlAltSuppr := ASender.Params[3] = '1';
    Settings.LockTaskMgr := ASender.Params[4] = '1';
    Settings.LockRightButton := ASender.Params[5] = '1';
    Settings.ReplaceStartButton := ASender.Params[6] = '1';
    Settings.CloseAll := ASender.Params[7] ='1';
    Settings.Save;
    if not Visible and not FAdminSession then
        SetRights(1);
end;

procedure SetRights(const Reason: Integer);
begin
    DisableRightButton((Reason = 0) or ((Reason = 1) and Settings.LockRightButton));
    DisableCtrlAltDel((Reason = 0) or ((Reason = 1) and Settings.LockCtrlAltSuppr));
    DisableAltF4(Reason = 0);
    DisableAltTab(Reason = 0);
    DisableWindowsKey((Reason = 0) or ((Reason = 1) and Settings.LockWindowsKey));
    DisableAltEsc(Reason = 0);
    DisableCtrlEsc((Reason = 0) or ((Reason = 1) and Settings.LockCtrlEsc));
    DisableTaskMgr((Reason = 0) or ((Reason = 1) and Settings.LockTaskMgr));
    DisableStartButton((Reason = 1) and Settings.HideStartButton);
    ReplaceStartmenu((Reason =0) or ((Reason =1) and settings.ReplaceStartButton));
    DisableDeskTop(Reason =0);




    
end;

procedure UpDateOldProcessList;
var
    Index: Integer;
    Process: TProcess;
begin
    repeat
        UpDateProcessList;
        for Index := 0 to ProcessList.Count - 1 do
        begin
            Process := ProcessList[Index];
            OldProcessList.Add(IntToStr(Process.Id));
        end;
    until OldProcessList.Count > 1;
end; // UpDateOldProcessList

procedure TfrmMain.itsMainichGetComputerHostCommand(ASender: TIdCommand);
begin
    if TryToConnect then
        itcMain.WriteLn('SENDHOST ' + ipwMain.LocalName + #254 + ipwMain.LocalIP);
end; // itsMainichGetComputerHostCommand

procedure TfrmMain.itsMainichSessionModifiedCommand(ASender: TIdCommand);
begin
    Customer.Account := StrToFloat(ASender.UnparsedParams);
end;

procedure TfrmMain.itsMainichSetAccountCommand(ASender: TIdCommand);
begin
    Customer.Account := StrToFloat(ASender.UnparsedParams);
end;

procedure TfrmMain.itsMainichGetMemoryCommand(ASender: TIdCommand);
var
    Drive: PChar;
begin
    if TryToConnect then
    begin
        Drive := PChar(ExtractFileDrive(GetWindowsDir(false)));
        itcMain.WriteLn('SENDMEMORY ' + ipwMain.LocalName + #254 +
            FormatFloat('0.00 Mo', GetDriveMemory(Drive, mtFree, msnMo)) + #254 +
            FormatFloat('0.00 Mo', GetDriveMemory(Drive, mtTotal, msnMo)));
    end;
end; // itsMainichGetMemoryCommand



procedure TfrmMain.itsMainichScreenImageCommand(ASender: TIdCommand);
var
    ABitmap: TBitmap;
    AStream: TStream;
    ScreenDC: HDC;
    FileName: string;
begin
    FileName := ExtractFilePath(Application.Exename) + 'Screen.bmp';
    DeleteFile(FileName);
    ABitmap := TBitmap.Create;
    try
        ABitmap.Width := Screen.Width;
        ABitmap.Height := Screen.Height;
        ScreenDC := GetDC(0);
        try
            BitBlt(ABitmap.Canvas.Handle, 0, 0, ABitmap.Width, ABitmap.Height,
                ScreenDC, 0, 0, SRCCOPY);
        finally
            ReleaseDC(0, ScreenDC);
        end;
        ABitmap.SaveToFile(FileName);
    finally
        ABitmap.Free;
    end;
    while not FileExists(FileName) do
        Application.ProcessMessages;
    AStream := TFileStream.Create(FileName, fmOpenRead and fmShareDenyWrite);
    try
        FThread.Connection.WriteStream(AStream, true, true);
    finally
        AStream.Free;
    end;
end; // itsMainichScreenImageCommand

procedure TfrmMain.itsMainichSetServeurHostCommand(ASender: TIdCommand);
begin
    Settings.ServeurHost := ASender.UnparsedParams;
end;

procedure TfrmMain.itsMainichConnexionCheckCommand(ASender: TIdCommand);
begin
    if TryToConnect then
        itcMain.WriteLn('CONNEXIONCHECK ' + ipwMain.LocalName);
end; // itsMainichConnexionCheckCommand

procedure TfrmMain.itsMainichSetLoginPasswordCommand(ASender: TIdCommand);
begin
    Settings.AdminLogin := ASender.Params[0];
    Settings.AdminPassword := ASender.Params[1];
end;

procedure TfrmMain.itsMainichGetOSCommand(ASender: TIdCommand);
begin
if TryToConnect then
        itcMain.WriteLn('SENDOS ' + ipwMain.LocalName + #254 + GetOs);
end; // itsMainichGetOSCommand

procedure TfrmMain.itsMainichChangeAuthenticationMsgCommand(
  ASender: TIdCommand);
var
    Flags: Integer;
begin
    Flags := StrToInt(ASender.Params[2]);
    frmSessionOpen.Tag := 1;
    if (Application.MessageBox(PChar(ASender.Params[0]), PChar(ASender.Params[1]),
        MB_OK + Flags) = mrOk) and (ASender.Params[3] = '1') then
    begin
        frmModifyAuthentication.Close;
        frmSessionOpen.Tag := 0;
    end;
end; // itsMainichChangeAuthenticationMsgCommand


procedure TfrmMain.itsMainichLockSessionCommand(ASender: TIdCommand);
var
    TimeOut: Integer;
begin
    TimeOut := StrToInt(ASender.UnparsedParams);
    if TimeOut <= 0 then
    begin
        frmSessionOpen.Tag := 1;
        Application.MessageBox('Cette option à été désactivée par le serveur.', 'Erreur',
            MB_OK + MB_ICONINFORMATION);
        frmSessionOpen.Tag := 0;
    end else
    begin
        frmSessionOpen.Timer1.Enabled:=false;
        frmSessionOpen.Close;
        frmLocked.TimeLeft := TimeOut * 60;
        frmLocked.tmrLock.Enabled := true;
    end;
end; // CloseActiveWindows

//** Regular Methods **********************************************************

procedure TfrmMain.KillNewProcess;
var
    Index: Integer;
    Process: TProcess;
begin
    UpDateProcessList;
    for Index := 0 to ProcessList.Count - 1 do
    begin
        Process := ProcessList[Index];
        if OldProcessList.IndexOf(IntToStr(Process.Id)) = -1 then
            KillProcess(Process.Name);
    end;
end; // KillNewProcess

procedure TfrmMain.StartCustomerSession;
begin
   if FAdminSession then
        EndAdminSession;

    if TryToConnect then
    begin
        Hide;
       // frmSessionOpen.UpDateSoundList;
        edtLogin.Clear;
        edtPassword.Clear;
        FAdminSession := false;
        Customer.StartDate := Now;
       frmSessionOpen.UpDatePosition;
        frmSessionOpen.tmrMain.Enabled := true;
        tmrAdminSession.Enabled := false;
       SetRights(1);
    //   WinLock.ReplaceStartmenu:=true;
       // AfficheBarreDeTaches(true);
       // ShowWindow(FindWindow('Progman',nil),SW_RESTORE);
        if Customer.FirstLog  then
        begin
            frmFirstLog := TfrmFirstLog.Create(nil);
           frmSessionOpen.Tag := 1;
            if (frmFirstLog.ShowModal = mrOk) and frmSessionOpen.ShowTimeAndAccount then
               frmSessionOpen.Timer1.Enabled:=true;
              //  frmSessionOpen.Show;
            frmSessionOpen.Tag := 0;
        end else if frmSessionOpen.ShowTimeAndAccount then
                      //  frmSessionOpen.Show;
frmSessionOpen.Timer1.Enabled:=true;

        frmSessionOpen.tmrMainTimer(Self);
       // frmSessionOpen.Show;
       // frmSessionOpen.WindowState := wsNormal;
      

    end;
end; // StartCustomerSession

procedure TfrmMain.StartAdminSession;
begin
    if customer.FreeCompte then
    begin
    frmSessionOpen.actOptions.Enabled:=false;
    frmSessionOpen.actClose.Enabled:=false;
   end;
    edtLogin.Clear;
    edtPassword.Clear;
    FAdminSession := true;
    frmSessionOpen.UpDateGUI;
    Hide;
    SetRights(2);
    CloseAdmin.Enabled:=true;
    WriteEventInLog('Ouverture d''une session administrateur');
    
 //   AfficheBarreDeTaches(true);
//ShowWindow(FindWindow('Progman',nil),SW_RESTORE);
end; // StartAdminSession

procedure TfrmMain.errasemsn;
var
 Reg: TRegistry;
begin
Reg := TRegistry.Create;
Reg.RootKey := HKEY_CURRENT_USER;
Reg.OpenKey('\Software\Microsoft\MSNMessenger\', True);
if Reg.ReadString('User.NET Messenger Service')<>'' then
begin
Reg.WriteString('User.NET Messenger Service', '@hotmail.com');
Reg.CloseKey;
end; end;

procedure TfrmMain.erraseyahoo;
var
Reg: TRegistry;
begin
Reg := TRegistry.Create;
Reg.RootKey := HKEY_CURRENT_USER;
Reg.OpenKey('\Software\Microsoft\Yahoo\Pager', True);
if Reg.ReadString('Yahoo! User ID')<>'' then
begin
Reg.WriteString('Yahoo! User ID', '@yahoo.fr');
Reg.CloseKey;
end;  end;

procedure RestartApplication;

begin

  WinExec(PChar(Application.ExeName), SW_SHOW);

  Application.Terminate;

end;

procedure TfrmMain.EndCustomerSession;

begin
    frmSessionOpen.tmrMain.Enabled := false;

    if TryToConnect then
                        itcMain.WriteLn('USERENDSESSION ' + IntToStr(Customer.Id));
    frmSessionOpen.progressbar1.Position:=0;
    FAdminSession := false;
    frmLocked.tmrLock.Enabled := false;
    tmrAdminSession.Enabled := true;
    frmSessionOpen.RestoreWindow;
    frmLocked.Close;
    frmSessionOpen.Timer1.Enabled:=false;
    frmSessionOpen.Close;
    frmInformation.Close;
    frmModifyAuthentication.Close;
    if frmFirstLog <> nil then
        frmFirstLog.Close;
    SetRights(0);
    Show;
    tmredtLoginFocus.Enabled := true;
    SaeubernStarten;
    if settings.CloseAll then
    begin
    KillNewProcess;
    CloseActiveWindows(Self);
    end;
    errasemsn;
    erraseyahoo;

   // RestartApplication;
end; // EndCustomerSession


procedure TfrmMain.EndAdminSession;
begin
    WriteEventInLog('fermeture de la session administrateur');
    FAdminSession := false;
    frmOptions.Tag := 1;
    frmOptions.Close;
    frmSessionOpen.Timer1.Enabled:=false;
    frmSessionOpen.Close;
    SetRights(0);
    Show;
    tmredtLoginFocus.Enabled := true;
   if settings.CloseAll then
     KillNewProcess;
     SaeubernStarten;
end; // EndAdminSession

procedure TfrmMain.UpDateTimeLeft;
begin
    try
        itcMain.WriteLn('UPDATETIMELEFT ' + ipwMain.LocalName + ' ' + IntToStr(Customer.TimeLeft));
    except
        on EIdException do
            EndCustomerSession;
    end;
end; // UpDateTimeLeft

function TfrmMain.TryToConnect;
begin
    Result := true;
    if not itcMain.Connected then
    try
        itcMain.Host := Settings.ServeurHost;
        itcMain.Connect(100);
    except
        on E: EIdException do
            Result := false;
        On E: EIdSocketError do   Application.MessageBox(pchar(E.Message), 'Erreur', MB_OK + MB_ICONINFORMATION);    end;
end; // TryToConnect

procedure TfrmMain.alMainUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
    actCheckPassWord.Enabled := (Trim(edtLogin.Text) <> '') and (Trim(edtPassword.Text) <> '');
    Handled := true;
end;

procedure TfrmMain.actCheckPassWordExecute(Sender: TObject);
begin
if (Settings.AdminLogin = LowerCase(edtLogin.Text)) and (Settings.AdminPassword = edtPassword.Text) then

        StartAdminSession

    else if TryToConnect then
        itcMain.WriteLn('CHECKPASSWORD ' + ipwMain.LocalName + ' ' +
            edtLogin.Text + ' ' + edtPassword.Text)
    else
    begin
        frmSessionOpen.Tag := 1;
        Application.MessageBox('Erreur lors de la connexion.', 'Erreur', MB_OK + MB_ICONERROR);
        frmSessionOpen.Tag := 0;
        edtPassword.Clear;
        edtLogin.Clear;
        edtLogin.SetFocus;
    end;
end;

procedure TfrmMain.itsMainichSetTimeLeftCommand(ASender: TIdCommand);
begin
    Customer.TimeLeft := StrToInt(ASender.UnparsedParams);
    frmSessionOpen.progressbar1.Max:=Customer.TotalTime+Customer.TimeLeft;
end;

procedure TfrmMain.itsMainichSetUserCommand(ASender: TIdCommand);
begin
    Customer.Id := StrToInt(ASender.Params[0]);
    Customer.Login := ASender.Params[1];
    Customer.Password := ASender.Params[2];
    Customer.FirstLog := ASender.Params[3] = '1';
    Settings.MonetarySymbol := ASender.Params[4];
    frmSessionOpen.ShowTimeAndAccount := ASender.Params[5]= '1';
    Customer.DateValidite:= strTodate(Asender.Params[6]);
    Customer.DateConnection:=strTodatetime(Asender.Params[7]);
    Customer.TotalTime:= strtoint(Asender.Params[8]);
    Customer.FreeCompte:= ASender.Params[9]='1';
     //   if frmSessionOpen.Visible and not frmSessionOpen.ShowTimeAndAccount then
 //       frmSessionOpen.Close;

end;

procedure TfrmMain.itsMainichStartSessionCommand(ASender: TIdCommand);
begin
    StartCustomerSession;
end;

procedure TfrmMain.itsMainichEndSessionCommand(ASender: TIdCommand);
begin
    tmrEndSession.Enabled := true;
end;

procedure TfrmMain.itsMainichLogErrorMessageCommand(ASender: TIdCommand);
var
    Flags: Integer;
begin
    Flags := StrToInt(ASender.Params[2]);
    frmSessionOpen.Tag := 1;
    Application.MessageBox(PChar(ASender.Params[0]), PChar(ASender.Params[1]), MB_OK + Flags);
    frmSessionOpen.Tag := 0;
    edtPassword.Clear;
    edtLogin.Clear;
    tmredtLoginFocus.Enabled := true;
end; // itsMainichLogErrorMessageCommSand

procedure TfrmMain.itsMainStartAdminSessionCommand(ASender: TIdCommand);
begin
//if Customer.FreeCompte then  StartAdminSession;//freecompte
   StartAdminSession;
end;

procedure TfrmMain.itsMainichMessageCommand(ASender: TIdCommand);
begin
    FMessageType.Msg := URLDecode(ASender.Params[0]);
    FMessageType.FontName := URLDecode(ASender.Params[4]);
    FMessageType.Size := StrToInt(ASender.Params[3]);
    FMessageType.Seconds := StrToInt(ASender.Params[1]);
    FMessageType.Color := StringToColor(ASender.Params[2]);
    tmrMessage.Enabled := true;
end;

procedure TfrmMain.itsMainichAbordShutdownCommand(ASender: TIdCommand);
begin
    AbordShutDown;
end;

procedure TfrmMain.itsMainichLogOffCommand(ASender: TIdCommand);
begin
    LogOff;
end;

procedure TfrmMain.itsMainichShutdownCommand(ASender: TIdCommand);
begin
ShutDownWindows(false, StrToInt(ASender.Params[1]), URLDecode(ASender.Params[0]));
//ShutDownWindows(false);
//MyExitWindows(EWX_POWEROFF OR EWX_FORCE);
//MyExitWindows(EWX_SHUTDOWN OR EWX_FORCE);
end;

procedure TfrmMain.itsMainichRebootCommand(ASender: TIdCommand);
begin
 ShutDownWindows(true, StrToInt(ASender.Params[1]), URLDecode(ASender.Params[0]));
//ShutDownWindows(true);
//MyExitWindows(EWX_REBOOT or EWX_FORCE);
end;

procedure TfrmMain.itsMainichKillProcessCommand(ASender: TIdCommand);
begin
UpDateProcessList;
    KillProcess(ASender.UnparsedParams);
end;

procedure TfrmMain.itsMainichSendProcessListCommand(ASender: TIdCommand);
var
    Temp: TStrings;
    Index: Integer;
    Process: TProcess;
begin
    Temp := TStringList.Create;
    UpDateProcessList;
    try
        for Index := 0 to ProcessList.Count - 1 do
        begin
            Process := ProcessList[Index];
            Temp.Add(Process.Name);
        end;
        if TryToConnect then
            itcMain.WriteLn('RECEIVEPROCESSLIST ' + Temp.CommaText);
    finally
        Temp.Free;
    end;
end; // itsMainichSendProcessListCommand

procedure TfrmMain.itsMainichUninstallCommand(ASender: TIdCommand);
begin
if AdminSession then
        EndAdminSession
    else if not Visible then
        EndCustomerSession;
    Uninstall;
    ShutDownWindows(true, 10, 'Désinstallation de CAPPUCCINO CLIENT.');
   //   ShutDownWindows(true);
    frmSessionOpen.actCloseExecute(nil);
end;

procedure TfrmMain.tmrAdminSessionTimer(Sender: TObject);
begin
    try
        if TryToConnect then
            itcMain.WriteLn('ADMINSESSION ' + ipwMain.LocalName + #254 + IntToStr(Integer(FAdminSession)));
    except
    end;
end;

procedure TfrmMain.tmredtLoginFocusTimer(Sender: TObject);
begin
tmredtLoginFocus.Enabled := false;
    if Enabled and Visible then
        edtLogin.SetFocus;
end;

procedure TfrmMain.tmrEndSessionTimer(Sender: TObject);
begin
    tmrEndSession.Enabled := false;
    if FAdminSession then
        EndAdminSession
    else
        EndCustomerSession;
//        AfficheBarreDeTaches(false);
//ShowWindow(FindWindow('Progman',nil),SW_Hide);
setRights(1);
end;

procedure TfrmMain.tmrSecurityTimer(Sender: TObject);
begin
    if settings.CloseAll then begin
    KillNewProcess;
    CloseActiveWindows(Self);
    end;
end;

procedure TfrmMain.tmrMessageTimer(Sender: TObject);
begin
    TfrmMessage.Execute(FMessageType.Msg, FMessageType.FontName, FMessageType.Seconds,
        FMessageType.Size, FMessageType.Color);
    tmrMessage.Enabled := false;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
//if not DirectoryExists(ExtractFilePath(ParamStr(0))+'Logos') then
//CreateDir(ExtractFilePath(ParamStr(0))+'Logos');
SetWindowLong(Application.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW);
cacherapp;
//IsADActive();
//SetWindowLong(Application.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW);
//SetWindowLong(Application.Handle, GWL_EXSTYLE, WS_EX_NOPARENTNOTIFY);
//SetWindowRgn(Handle, CreateRoundRectRgn(0, 3, Width, Height,45,45), True);
//AfficheBarreDeTaches(false);
//ShowWindow(FindWindow('Progman',nil),SW_HIDE);
//setrights(1);
GetVersion;
Mem.OnAllocMemory   := MemAllocMemory;
Mem.OnDeallocMemory := MemDeallocMemory;
ProgressBarFree.Position := 1;
ProgressBarFree.Min      := 1;
ProgressBarFree.Max      := Mem.GetMemoryStatus.TotalPhys;
auAutoUpgrader1.HTTPUsername := Settings.Login_Update;
auAutoUpgrader1.HTTPPassword := Settings.Password_Update;
   if not GetSystemMetrics(SM_NETWORK) and $01 = $01 then
    Application.MessageBox('Probléme sur le réseaux local, ', 'Erreur', MB_OK + MB_ICONERROR);
    FThread := nil;
    itcMain.Host := Settings.ServeurHost;
    itsMain.Active:=true;
    FUserList := TStringList.Create;
    frmOptions := TfrmOptions.Create(nil);
    if Settings.FirstBoot then
        frmOptions.ShowModal;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    if frmMain.TryToConnect then
        frmMain.itcMain.WriteLn('ADMINSESSION ' + frmMain.ipwMain.LocalName + #254 + '0');
    CanClose := Boolean(Tag);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
    FUserList.Free;
//    frmOptions.Free;
//    AfficheBarreDeTaches(true);
//ShowWindow(FindWindow('Progman',nil),SW_RESTORE);
end;

procedure TfrmMain.FormHide(Sender: TObject);
begin

DisableTaskBar(false);
  tmrSecurity.Enabled := false;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
edtlogin.SetFocus;
DisableTaskBar(true);
    
    SetRights(0);
    tmrSecurity.Enabled := true;
    
end;


procedure TfrmMain.itsMainConnect(AThread: TIdPeerThread);
begin
inherited;
    FThread := AThread;
end;

procedure TfrmMain.itsMainDisconnect(AThread: TIdPeerThread);
begin
inherited;
FThread := nil;

end;

procedure TfrmMain.itsMainichRunShellCommand(ASender: TIdCommand);
begin
shellexecute(Application.Handle, nil, PChar(ASender.Params[0]), nil, nil,  SW_SHOWNORMAL);
//    showmessage(PChar(ASender.Params[0]));
end;

procedure TfrmMain.itsMainichOpenCdCommand(ASender: TIdCommand);
begin
mciSendString('Set cdaudio door open wait', nil, 0, Application.Handle);
end;

procedure TfrmMain.itsMainichCloseCdCommand(ASender: TIdCommand);
begin
mciSendString('Set cdaudio door closed wait', nil, 0, Application.Handle);
end;

procedure TfrmMain.MemAllocMemory(Sender: TObject; AQuantity: integer);
begin
  //Position the progressbar
  ProgressBarFree.Position := AQuantity;
end;

procedure TfrmMain.MemDeallocMemory(Sender: TObject; AQuantity: integer);
begin
  //Position the progressbar
  ProgressBarFree.Position := (ProgressBarFree.Position + AQuantity);
end;

procedure TfrmMain.itsMainichFreeRamCommand(ASender: TIdCommand);
begin
try
    ProgressBarFree.Visible:=true;
    label1.Visible:=true;
    Screen.Cursor := crHourGlass;
    actCheckPassWord.Enabled:=false;
    Mem.FreeRAM(Mem.GetMemoryStatus.TotalPhys);
    ProgressBarFree.Position := ProgressBarFree.Max;
    finally
    ProgressBarFree.Position:=0;
    Screen.Cursor := crDefault;
    ProgressBarFree.Visible:=false;
    label1.Visible:=false;
    actCheckPassWord.Enabled:=true;
    end;
end;

procedure TfrmMain.auAutoUpgrader1Progress(Sender: TObject;
  const FileURL: String; FileSize, BytesRead, ElapsedTime,
  EstimatedTimeLeft: Integer; PercentsDone, TotalPercentsDone: Byte;
  TransferRate: Single);
begin
ProgressBarFree.Position:=PercentsDone;
end;

procedure TfrmMain.itsMainichUpdateCommand(ASender: TIdCommand);
begin
auAutoUpgrader1.CheckUpdate;
end;

procedure TfrmMain.auAutoUpgrader1BeginUpgrade(Sender: TObject;
  const UpgradeMsg: String; UpgradeMethod: TacUpgradeMethod;
  Files: TStringList; var CanUpgrade: Boolean);
begin
ProgressBarFree.Visible:=true;
label1.Visible:=true;
label1.Caption:='Mise à jour, patientez SVP. ';
end;

procedure TfrmMain.itsMainNoCommandHandler(ASender: TIdTCPServer;
  const AData: String; AThread: TIdPeerThread);
begin
MessageBox(Handle, 'Attention, des connections anonymes sur le client, ou envoie erronée de données', 'Problème de connection', MB_ICONEXCLAMATION );
end;

procedure TfrmMain.itsMainException(AThread: TIdPeerThread;
  AException: Exception);
begin
// MessageBox(handle, PChar(AException.Message), 'Erreur', MB_OK);
end;

procedure TfrmMain.CloseAdminTimer(Sender: TObject);
begin
EndAdminSession;
CloseAdmin.Enabled:=false;
end;

procedure TfrmMain.edtLoginKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
edtpassword.SetFocus;
end;

initialization
    OldProcessList := TStringList.Create;
    UpDateOldProcessList;
finalization
    OldProcessList.Free;
end.
