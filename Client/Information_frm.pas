unit Information_frm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfrmInformation = class(TForm)
    CaptionPanel: TPanel;
    Label1: TLabel;
    Image1: TImage;
    Image2: TImage;
    Panel2: TPanel;
    Label2: TLabel;
    lblExpire: TLabel;
    lbloldconnection: TLabel;
    lblIdentity: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure CaptionPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInformation: TfrmInformation;

implementation
uses Main_frm;
{$R *.dfm}

procedure TfrmInformation.CaptionPanelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
ReleaseCapture;
  SendMessage(frmInformation.Handle, WM_SYSCOMMAND, 61458, 0);
end;

procedure TfrmInformation.Image2Click(Sender: TObject);
begin
close;
end;

procedure TfrmInformation.FormShow(Sender: TObject);
begin
lblIdentity.Caption := Main_frm.Customer.Login;
label3.Caption:=Datetostr(Main_frm.Customer.DateValidite);
label4.Caption:=Datetimetostr(Main_frm.Customer.DateConnection);
end;

procedure TfrmInformation.Label1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
ReleaseCapture;
  SendMessage(frmInformation.Handle, WM_SYSCOMMAND, 61458, 0);
end;

end.
