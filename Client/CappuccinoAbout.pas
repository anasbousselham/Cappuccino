unit CappuccinoAbout;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TCappuccinoAboutDlg = class(TForm)
    Panel1: TPanel;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    OKButton: TButton;
    ProgramIcon: TImage;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CappuccinoAboutDlg: TCappuccinoAboutDlg;

implementation
uses UInfoVersion;
{$R *.dfm}

procedure TCappuccinoAboutDlg.FormCreate(Sender: TObject);
begin
with TInfoVersion.create(ParamStr(0)) do
  try
version.Caption:=Format('Version %d.%d build %d', [GetMajorNum,
      GetMinorNum, GetBuildNum]);
      finally
    free;
  end;
end;

end.
 
