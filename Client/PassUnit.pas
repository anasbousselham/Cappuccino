unit PassUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TFlatEditUnit, ExtCtrls, JvImage, TFlatButtonUnit,
  JvExExtCtrls;

type
  TPassForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    JvImage1: TJvImage;
    JvImage3: TJvImage;
    Panel2: TPanel;
    edtpass: TFlatEdit;
    Label2: TLabel;
    FlatButton1: TFlatButton;
    procedure JvImage3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtpassKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PassForm: TPassForm;

implementation
uses Session_Open_Frm;
{$R *.dfm}

procedure TPassForm.JvImage3Click(Sender: TObject);
begin
close;
end;


procedure TPassForm.FormShow(Sender: TObject);
begin
edtpass.Text:='';
 SetForegroundWindow(Handle);
end;

procedure TPassForm.edtpassKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
flatbutton1.Click;
end;

end.
