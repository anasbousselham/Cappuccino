unit FirstLog_frm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmFirstLog = class(TForm)
    lblInfo: TLabel;
    imgInfo: TImage;
    btnOk: TButton;
    tmrFlashTrayIcon: TTimer;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrFlashTrayIconTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    FTrayIcon: TIcon;
    FTrayIconIndex: Integer;
  end; // TfrmFirstLog

var
  frmFirstLog: TfrmFirstLog;

implementation

{$R *.dfm}

uses Main_frm, DateUtils, StrUtils, Session_Open_frm, CoolTrayIcon,
  TextTrayIcon;

//** Event Handlers ***********************************************************

procedure TfrmFirstLog.FormShow(Sender: TObject);
begin
    ShowWindow(Application.Handle, SW_HIDE);
    lblInfo.Caption := 'Bonjour ' + Customer.SurName + '.' + #13 +
        #13 + 'Bienvenue dans l''environnement CAPPUCCINO, pour connaître à' +
        #13 + 'chaque instant l''évolution de votre forfait, ainsi que les autres' +
        #13 + 'options disponibles faites un clic droit sur la fenêtre' +
        #13 + ''+
        #13 + 'Pour plus de sécurité veillez changer votre login et votre mot de passe .';
    tmrFlashTrayIcon.Enabled := true;
    timer1.Enabled:=true;
end; // FormShow                       

procedure TfrmFirstLog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    Action := caFree;
    tmrFlashTrayIcon.Enabled := false;
    frmSessionOpen.ctiMain.IconVisible := true;
    timer1.Enabled:=false;
end; // FormClose

procedure TfrmFirstLog.tmrFlashTrayIconTimer(Sender: TObject);
begin
    Inc(FTrayIconIndex);
    with frmSessionOpen.ilMain do
    begin
        if FTrayIconIndex >= Count then
            FTrayIconIndex := 0;
        GetIcon(FTrayIconIndex, FTrayIcon);
        frmSessionOpen.ctiMain.BackgroundIcon := FTrayIcon;
    end;
end; // tmrFlashTrayIconTimer

procedure TfrmFirstLog.FormCreate(Sender: TObject);
begin
    FTrayIcon := TIcon.Create;
    FTrayIconIndex := 0;
end; // FormCreate

procedure TfrmFirstLog.Timer1Timer(Sender: TObject);
begin
timer1.Enabled:=false;
btnOk.Enabled:=true;
end;

end.

