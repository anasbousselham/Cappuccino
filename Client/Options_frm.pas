unit Options_frm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ActnList, ExtDlgs, Menus;

type
  TfrmOptions = class(TForm)
    pcMain: TPageControl;
    tsIdentification: TTabSheet;
    alMain: TActionList;
    actApply: TAction;
    actAddImage: TAction;
    opdgMain: TOpenPictureDialog;
    popImages: TPopupMenu;
    Ajouter1: TMenuItem;
    actDeleteImage: TAction;
    Supprimer1: TMenuItem;
    btnOk: TButton;
    tsInstall: TTabSheet;
    btnUpDate: TButton;
    btnRemoveRegistryEntries: TButton;
    tsRestrictions: TTabSheet;
    chkLockCtrlAltSuppr: TCheckBox;
    chkHideStartButton: TCheckBox;
    chkLockWindowsKey: TCheckBox;
    Label6: TLabel;
    chkLockTaskMgr: TCheckBox;
    Label8: TLabel;
    Label9: TLabel;
    chkLockCtrlEsc: TCheckBox;
    chkLockRightButton: TCheckBox;
    chkReplaceStartButton: TCheckBox;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    edtServeurHost: TEdit;
    Label1: TLabel;
    edtLogin: TEdit;
    Label3: TLabel;
    edtPassword: TEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    edtLogin_Update: TEdit;
    edtPassword_Update: TEdit;
    chkCloseAll: TCheckBox;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    edtPwdClose: TEdit;
    procedure actApplyExecute(Sender: TObject);
    procedure edtLoginKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure alMainUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure GenericWithoutSpaceKeyPress(Sender: TObject; var Key: Char);
    procedure pcMainChange(Sender: TObject);
    procedure btnUpDateClick(Sender: TObject);
    procedure btnRemoveRegistryEntriesClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    procedure UpDateGUI;
    procedure UpDateApplication;
  end; // TfrmOptions

procedure Uninstall;

var
  frmOptions: TfrmOptions;

implementation

{$R *.dfm}

uses Math, Config, Main_frm, Shutdown, System_Restrictions, ComputerInfo,
    Message_frm, Registry;

//** Regular Routines *********************************************************

procedure Uninstall;
var
    Reg: TRegIniFile;
begin
    Settings.AllowSave := false;
    Reg := TRegIniFile.Create;
    try
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        Reg.OpenKey('SOFTWARE', true);
        Reg.EraseSection(SEC_GENERAL);
    finally
        Reg.Free;
    end;
    UnInstallDll;

    RemoveApplicationToStartup;
end; // Uninstall

//** Regular Methods **********************************************************

procedure TfrmOptions.UpDateGUI;
begin
    pcMain.ActivePageIndex := 0;
    pcMainChange(Self);
    edtLogin.Text := Settings.AdminLogin;
    edtServeurHost.Text := Settings.ServeurHost;
    edtPassword.Text := Settings.AdminPassword;
    chkLockCtrlAltSuppr.Checked := Settings.LockCtrlAltSuppr;
    chkHideStartButton.Checked := Settings.HideStartButton;
    chkLockWindowsKey.Checked := Settings.LockWindowsKey;
    chkLockTaskMgr.Checked := Settings.LockTaskMgr;
    chkLockCtrlEsc.Checked := Settings.LockCtrlEsc;
    chkLockRightButton.Checked := Settings.LockRightButton;
    chkReplaceStartButton.Checked := Settings.ReplaceStartButton;
    chkCloseAll.Checked := settings.CloseAll;
    edtLogin_Update.Text := Settings.Login_Update;
    edtPassword_update.Text := Settings.Password_Update;
    edtPwdClose.Text := Settings.PwdClose;
  //  edit1.Text := Settings.Logo;
   // if settings.Logo <>'' then Image1.Picture.LoadFromFile(Settings.Logo);
end; // UpDateGUI

procedure TfrmOptions.UpDateApplication;
begin
    Settings.Save;
    InstallDll;
    LaunchApplicationOnStartup;
    if MessageDlg('L''assistant de configuration doit maintenant redémarrer votre ordinateur' +
        #13 + 'afin de prendre en compte les parametres ainsi modifiés.',
            mtInformation, [mbOk], 0) = mrOk then
        ShutDownWindows(true, 5, '');
        // ShutDownWindows(true);
end; // UpDateApplication

//** Actions ******************************************************************

procedure TfrmOptions.actApplyExecute(Sender: TObject);
begin
    Settings.ServeurHost := edtServeurHost.Text;
    frmMain.itcMain.Host := Settings.ServeurHost;
    Settings.AdminLogin := edtLogin.Text;
    Settings.AdminPassword := edtPassword.Text;
    Settings.LockCtrlAltSuppr := chkLockCtrlAltSuppr.Checked;
    Settings.HideStartButton := chkHideStartButton.Checked;
    Settings.LockWindowsKey := chkLockWindowsKey.Checked;
    Settings.LockTaskMgr := chkLockTaskMgr.Checked;
    Settings.LockCtrlEsc := chkLockCtrlEsc.Checked;
    Settings.LockRightButton := chkLockRightButton.Checked;
    Settings.ReplaceStartButton := chkReplaceStartButton.Checked;
    Settings.Login_Update := edtLogin_Update.Text;
    Settings.Password_Update := edtPassword_Update.Text;
    Settings.CloseAll := chkCloseAll.Checked;
    Settings.PwdClose := edtPwdClose.Text;
    Tag := 1;
    if Settings.FirstBoot then
        UpDateApplication;
    Settings.FirstBoot := false;
    Settings.Save;
end; // actApplyExecute

procedure TfrmOptions.alMainUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
    actApply.Enabled := (edtServeurHost.Text <> '') and (edtLogin.Text <> '') and
        (edtPassword.Text <> '');

    Handled := true;
end; // alMainUpdate

//** Events Handlers **********************************************************

procedure TfrmOptions.FormShow(Sender: TObject);
begin
    UpDateGUI;
    if Settings.FirstBoot then
    ShowWindow(Application.Handle, SW_HIDE);
end; // FormShow

procedure TfrmOptions.edtLoginKeyPress(Sender: TObject; var Key: Char);
begin
    if Key in ['A'..'Z', #32] then
        Key := #0;
end; // edtLoginKeyPress

procedure TfrmOptions.GenericWithoutSpaceKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #32 then
        Key := #0;
end; // GenericPasswordKeyPress

procedure TfrmOptions.pcMainChange(Sender: TObject);
begin
    Caption := 'Paramètres - ' + pcMain.ActivePage.Caption;
end; // pcMainChange

procedure TfrmOptions.btnUpDateClick(Sender: TObject);
begin
    Settings.Save;
    UpDateApplication;
end; // btnUpDateClick

procedure TfrmOptions.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    CanClose := Boolean(Tag);
    Tag := 0;
end; // FormCloseQuery

procedure TfrmOptions.btnRemoveRegistryEntriesClick(Sender: TObject);
begin
    if MessageDlg('Attention, cette opération va également éffacer les paramètres' + #13 +
        'de l''application client, continuer ?', mtWarning, [mbYes, mbNo], 0) = mrYes then
    begin
        Uninstall;
        if MessageDlg('Opération effectué, l''ordinateur doit maintenant redémarrer', mtInformation, [mbOK], 0) = mrOk then
            ShutDownWindows(true, 0, '');
           // ShutDownWindows(true);
    end;
end; // btnRemoveRegistryEntriesClick



end.
