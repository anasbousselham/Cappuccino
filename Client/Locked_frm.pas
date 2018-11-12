unit Locked_frm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ActnList;

type
  TfrmLocked = class(TForm)
    lblTimeLeft: TLabel;
    tmrLock: TTimer;
    Panel1: TPanel;
    Label1: TLabel;
    edtPassword: TEdit;
    btnCheckPW: TButton;
    lblUser: TLabel;
    alMain: TActionList;
    actCheckPassword: TAction;
    tmrSecurity: TTimer;
    procedure tmrLockTimer(Sender: TObject);
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure actCheckPasswordExecute(Sender: TObject);
    procedure alMainUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure tmrSecurityTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FTimeLeft: Integer;
    procedure UnLock;
  public
    property TimeLeft: Integer read FTimeLeft write FTimeLeft;
  end; // TfrmLocked

var
  frmLocked: TfrmLocked;

implementation

{$R *.dfm}

uses Session_Open_frm, Config, Main_frm, System_Restrictions;

procedure TfrmLocked.UnLock;
begin
    SetRights(1);
    DisableTaskBar(false);
    tmrLock.Enabled := false;
    frmSessionOpen.tmrMain.Enabled := true;

    if frmSessionOpen.ShowTimeAndAccount then
        //frmSessionOpen.show;
        frmSessionOpen.Timer1.Enabled:=true;
    Close;
end; // UnLock

procedure TfrmLocked.tmrLockTimer(Sender: TObject);
begin
    if not Visible then
        Show;
    lblTimeLeft.Caption := SecondsToStr(FTimeLeft);
    Dec(FTimeLeft);
    if FTimeLeft < 0 then
    begin
        edtPassword.Clear;
        Close;
        tmrLock.Enabled := false;
        frmMain.EndCustomerSession;
    end;
end; // tmrLockTimer

procedure TfrmLocked.edtPasswordKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #32 then
        Key := #0;
end; // edtPasswordKeyPress

procedure TfrmLocked.actCheckPasswordExecute(Sender: TObject);
begin
    if edtPassword.Text = Customer.Password then
        UnLock
    else
    begin
        edtPassword.Clear;
        frmSessionOpen.Tag := 1;
        Application.MessageBox('Mauvais mot de passe.', 'Erreur', MB_OK + MB_ICONERROR);
        frmSessionOpen.Tag := 0;
    end;
end; // actCheckPasswordExecute

procedure TfrmLocked.alMainUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
    actCheckPassword.Enabled := edtPassword.Text <> '';
    Handled := true;
end; // alMainUpdate

procedure TfrmLocked.FormShow(Sender: TObject);
begin
    Activate;
    frmSessionOpen.tmrMain.Enabled := false;
    tmrSecurity.Enabled := true;
    edtPassword.Clear;
    SetRights(0);
    DisableTaskBar(true);
    lblUser.Caption := 'Cet ordinateur à été bloqué par ' +
        Customer.Login;
end; // FormShow

procedure TfrmLocked.tmrSecurityTimer(Sender: TObject);
begin
    frmMain.KillNewProcess;
    CloseActiveWindows(Self);
end; // tmrSecurityTimer

procedure TfrmLocked.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    tmrSecurity.Enabled := false;
end; // FormClose

end.
