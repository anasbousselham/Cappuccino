program Project1;

uses
  Forms,
  Main_frm in 'Main_frm.pas' {frmMain},
  System_Restrictions in 'System_Restrictions.pas',
  ShutDown in 'ShutDown.pas',
  Config in 'Config.pas',
  Message_frm in 'Message_frm.pas' {frmMessage},
  Options_frm in 'Options_frm.pas' {frmOptions},
  Modify_Authentication_frm in 'Modify_Authentication_frm.pas' {frmModifyAuthentication},
  FirstLog_frm in 'FirstLog_frm.pas' {frmFirstLog},
  Locked_frm in 'Locked_frm.pas' {frmLocked},
  uMem in 'uMem.pas',
  UInfoVersion in 'UInfoVersion.pas',
  Information_frm in 'Information_frm.pas' {frmInformation},
  Session_Open_frm in 'Session_Open_frm.pas' {frmSessionOpen},
  PassUnit in 'PassUnit.pas',
  CappuccinoAbout in 'CappuccinoAbout.pas' {CappuccinoAboutDlg},
  u_Saeubern in 'u_Saeubern.pas';

{$R *.res}

begin
  Mem := TMem.Create;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmModifyAuthentication, frmModifyAuthentication);
  Application.CreateForm(TfrmLocked, frmLocked);
  Application.CreateForm(TfrmInformation, frmInformation);
  Application.CreateForm(TfrmSessionOpen, frmSessionOpen);
  // Application.CreateForm(TfrmMessage, frmMessage);
  Application.CreateForm(TfrmOptions, frmOptions);
  Application.Run;
end.
