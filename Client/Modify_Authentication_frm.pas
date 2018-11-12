unit Modify_Authentication_frm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList;

type
  TfrmModifyAuthentication = class(TForm)
    GroupBox1: TGroupBox;
    edtLogin: TEdit;
    edtPassword: TEdit;
    edtRetryPassword: TEdit;
    btnCancel: TButton;
    btnOk: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    alMain: TActionList;
    actModifyAuthentication: TAction;
    procedure FormShow(Sender: TObject);
    procedure alMainUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure GenericPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure edtLoginKeyPress(Sender: TObject; var Key: Char);
    procedure actModifyAuthenticationExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    FStoredWidth, FStoredHeight: Integer;
  end; // TfrmModifyAuthentication

var
  frmModifyAuthentication: TfrmModifyAuthentication;

implementation

{$R *.dfm}

uses Main_frm, Math;

//** Event Handlers ***********************************************************

procedure TfrmModifyAuthentication.actModifyAuthenticationExecute(
  Sender: TObject);
begin
    if frmMain.TryToConnect then
        frmMain.itcMain.WriteLn('CHANGEAUTH ' + frmMain.ipwMain.LocalName + ' ' +
            edtLogin.Text + ' ' + edtPassword.Text);
end; // actModifyAuthenticationExecute

procedure TfrmModifyAuthentication.FormShow(Sender: TObject);
begin
    edtLogin.Text := Customer.Login;
    edtPassword.Text := Customer.Password;
    edtRetryPassword.Clear;
    ShowWindow(Application.Handle, SW_HIDE);
    Width := FStoredWidth;
    Height := FStoredHeight;
    Left := Screen.Width div 2 - FStoredWidth div 2;
    Top := Screen.Height div 2 - FStoredHeight div 2;
end; // FormShow

procedure TfrmModifyAuthentication.alMainUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
    actModifyAuthentication.Enabled := (edtLogin.Text <> '') and
    (edtPassword.Text <> '') and (edtPassword.Text = edtRetryPassword.Text);
    Handled := true;
end; // alMainUpdate

procedure TfrmModifyAuthentication.GenericPasswordKeyPress(Sender: TObject;
  var Key: Char);
begin
    if Key = #32 then
        Key := #0;
end; // GenericPasswordKeyPress

procedure TfrmModifyAuthentication.edtLoginKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (Key = #32) or (Key in ['A'..'Z']) then
        Key := #0;
end; // edtLoginKeyPress

procedure TfrmModifyAuthentication.FormCreate(Sender: TObject);
begin
    FStoredWidth := Width;
    FStoredHeight := Height;
end;

procedure TfrmModifyAuthentication.btnCancelClick(Sender: TObject);
begin
close;
end;

end.
