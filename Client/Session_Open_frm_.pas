unit Session_Open_frm_;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, CoolTrayIcon, TextTrayIcon, ImgList, ExtCtrls, Menus,
  JvImage, ComCtrls, StdCtrls;

type
  TfrmSessionOpen = class(TForm)
    Panel2: TPanel;
    lblTimeLeft: TLabel;
    lblAccount: TLabel;
    ProgressBar1: TProgressBar;
    Panel1: TPanel;
    Label1: TLabel;
    JvImage1: TJvImage;
    JvImage3: TJvImage;
    popCustomer: TPopupMenu;
    mipopEndCustomerSession: TMenuItem;
    mipopLock: TMenuItem;
    N6: TMenuItem;
    Informationcompte1: TMenuItem;
    mipopModifyAuthentication: TMenuItem;
    N1: TMenuItem;
    mipopShowWindow: TMenuItem;
    N2: TMenuItem;
    CappuccinoAnasoft1: TMenuItem;
    popAdmin: TPopupMenu;
    mipopEndAdminSession: TMenuItem;
    N4: TMenuItem;
    mipopOptions: TMenuItem;
    N3: TMenuItem;
    mipopLogOff: TMenuItem;
    mipopReboot: TMenuItem;
    mipopShutdown: TMenuItem;
    N5: TMenuItem;
    Fermerlapplication1: TMenuItem;
    N7: TMenuItem;
    CAPPUCCINOANASOFT2: TMenuItem;
    tmrMain: TTimer;
    tmrPersistant: TTimer;
    ilMain: TImageList;
    ctiMain: TTextTrayIcon;
    alMain: TActionList;
    actEndCustomerSession: TAction;
    actEndAdminSession: TAction;
    actShowWindow: TAction;
    actModifyAuthentication: TAction;
    actOptions: TAction;
    actReboot: TAction;
    actShutdown: TAction;
    actLogOff: TAction;
    actClose: TAction;
    actLock: TAction;
    actFirstPlant: TAction;
    tmrFlashMessage: TTimer;
    procedure tmrPersistantTimer(Sender: TObject);
    procedure tmrMainTimer(Sender: TObject);
    procedure tmrFlashMessageTimer(Sender: TObject);
    procedure actEndAdminSessionExecute(Sender: TObject);
    procedure actOptionsExecute(Sender: TObject);
    procedure actRebootExecute(Sender: TObject);
    procedure actShutdownExecute(Sender: TObject);
    procedure actLogOffExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actEndCustomerSessionExecute(Sender: TObject);
    procedure actShowWindowExecute(Sender: TObject);
    procedure actModifyAuthenticationExecute(Sender: TObject);
    procedure actLockExecute(Sender: TObject);
    procedure actFirstPlantExecute(Sender: TObject);
    procedure alMainUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
       FTrayIcon: TIcon;
    FFlashMessageDuration: Integer;
    FOldWindowState: TWindowState;
    FShowTimeAndAccount: Boolean;
  public
    { Public declarations }
    procedure CreateParams(var Params: TCreateParams); override;
    procedure RestoreWindow;
    property TrayIcon: TIcon read FTrayIcon;
    procedure UpDatePosition;
    procedure UpDateGUI;
    property ShowTimeAndAccount: Boolean read FShowTimeAndAccount write FShowTimeAndAccount;
  end;
function SecondsToStr(const TimeLeft: Integer): string;
var
  frmSessionOpen: TfrmSessionOpen;

implementation
uses Main_frm, Options_frm, Modify_Authentication_frm,
  Locked_frm, Config, Message_frm, ShutDown, StrUtils, DateUtils, information_frm;
{$R *.dfm}

procedure former(Obj:tform;img:tbitmap);
var
x, y, reg, debut:integer;
EtaitTrans, first:boolean;
begin
first:=true;
for y:=1 to img.height do begin
  EtaitTrans:=true;
  for x:=1 to img.width do begin

    if img.Canvas.Pixels[x,y]=img.Canvas.Pixels[1,1] then begin
      if EtaitTrans=false then
        if first=true then begin
          reg:=CreateRectRgn(debut,y,x,y+1);
          first:=false;
        end else CombineRgn(reg, reg, createrectrgn(debut,y,x,y+1), rgn_or);
      EtaitTrans:=true;
    end else begin
      if EtaitTrans=true then debut:=x;
      EtaitTrans:=false;
      if x=img.width-1 then CombineRgn(reg, reg, createrectrgn(debut,y,x,y+1), rgn_or);
    end;
  end;
end;
SetWindowRgn(Obj.handle, reg,true);             
end;

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

function ValidSoundFile(const FileName: string): Boolean;
var
    Index: Integer;
begin
    Result := false;
    if ExtractFileExt(FileName) <> '.wav' then
        Exit;
    for Index := 1 to Length(FileName) - 4 do
        if not (FileName[Index] in ['0'..'9']) then
            Exit;
    Result := true;
end; // ValidSoundFile

function SecondsToStr(const TimeLeft: Integer): string;
begin
    Result := Format('%.2d:%.2d:%.2d',
        [TimeLeft div 3600, (TimeLeft div 60) mod 60, TimeLeft mod 60]);
end; // SecondsToStr

//** Regular Methods **********************************************************

procedure TfrmSessionOpen.CreateParams(var Params: TCreateParams);
begin
    inherited CreateParams(Params);
    Params.WndParent:= GetDesktopWindow;
end; // CreateParams

procedure TfrmSessionOpen.RestoreWindow;
begin
  //  image1.Picture.LoadFromFile(settings.Logo);
   // lblFlashMessage.Height := 0;
    tmrFlashMessage.Enabled := false;
   // Height := LAST_HEIGHT;
    UpDatePosition;
end; // RestoreWindow


procedure TfrmSessionOpen.UpDatePosition;
begin
  //  Left := Screen.WorkAreaWidth - LAST_WIDTH;
  //  Top := Screen.WorkAreaHeight - LAST_HEIGHT;
end; // UpDatePosition

procedure TfrmSessionOpen.UpDateGUI;
begin
    if frmMain.AdminSession then
    begin
        ctiMain.PopupMenu := popAdmin;
        ilMain.GetIcon(4, FTrayIcon);
        ctiMain.Hint := 'Vous êtes en mode administrateur.';

    end else
    begin
        ctiMain.PopupMenu := popCustomer;
        if FShowTimeAndAccount then
        begin
            lblTimeLeft.Caption := SecondsToStr(Customer.TimeLeft);

           progressbar1.Position:=Customer.TimeLeft;
          // if WindowState = wsNormal then
          //      Caption := 'Cappuccino - ' + 'Temps restant'
          //  else
            //    Caption := lblTimeLeft.Caption + ' (' + 'restant' + ')';
            ctiMain.Hint := 'Temps restant' + ' : ' +
                lblTimeLeft.Caption ;
            lblAccount.Caption := 'Vous êtes débiteur de : ' + FormatFloat('0.00 ', Customer.Account / 100) + Settings.MonetarySymbol;
          //  lblIdentity.Caption := 'Votre Login :'+Customer.Login;
          // lblexpire.Caption:='Votre compte expire le :'+Datetostr(Customer.DateValidite);
         //  lbloldconnection.Caption:='Dernière connection le :'+Datetimetostr(Customer.DateConnection);

           //SessionModified('Votre compte expire le :'+Datetostr(Customer.DateValidite));
        end else
        begin
            //Caption := '';
            lblTimeLeft.Caption := '';
            ctiMain.Hint := '';
            lblAccount.Caption := '';
           // lblIdentity.Caption := '';
        end;
        if  not FShowTimeAndAccount then
            ilMain.GetIcon(4, FTrayIcon)
        else if Customer.TimeLeft > 1800 then
            ilMain.GetIcon(0, FTrayIcon)
        else if Customer.TimeLeft > 900 then
            ilMain.GetIcon(1, FTrayIcon)
        else if Customer.TimeLeft > 300 then
            ilMain.GetIcon(2, FTrayIcon)
        else
            ilMain.GetIcon(3, FTrayIcon);
    end;
    ctiMain.BackgroundIcon := FTrayIcon;
    ctiMain.IconVisible:=true;
end; // UpDateGUI



procedure TfrmSessionOpen.tmrPersistantTimer(Sender: TObject);
begin
ctiMain.IconVisible:=true;
 //   if Visible and not Application.Active and not Boolean(Tag) then
 //       Show;
 //   if (FOldWindowState <> WindowState) and Visible then
        UpDateGUI;
 //   FOldWindowState := WindowState;
end;

procedure TfrmSessionOpen.tmrMainTimer(Sender: TObject);
var
    SoundFileName: string;
begin

        Dec(Customer.TimeLeft);
       // if (not Visible or (WindowState = wsMinimized)) and FShowTimeAndAccount then
            case Customer.TimeLeft of
                3600: begin ctiMain.ShowBalloonHint('CAPPUCCINO', 'Il vous reste une heure.', bitInfo, 15);  TfrmMessage.Execute('Il vous reste une heure..', 'Arial', 8,35, clBlue) end;
                1800: begin ctiMain.ShowBalloonHint('CAPPUCCINO', 'Il vous reste 30 minutes.', bitInfo, 15); TfrmMessage.Execute('Il vous reste 30 minutes.', 'Arial', 8,35, clBlue) end;
                900: begin ctiMain.ShowBalloonHint('CAPPUCCINO', 'Il vous reste 15 minutes.', bitInfo, 15);  TfrmMessage.Execute('Il vous reste 15 minutes.', 'Arial', 8,35, clBlue) end;
                300: begin ctiMain.ShowBalloonHint('CAPPUCCINO', 'Il vous reste 5 minutes.', bitInfo, 15);  TfrmMessage.Execute('Il vous reste 5 minutes.', 'Arial', 8,35, clBlue) end;
                60: begin ctiMain.ShowBalloonHint('CAPPUCCINO', 'Il vous reste une minute.', bitInfo, 15); TfrmMessage.Execute('Il vous reste une minute.', 'Arial', 8,35, clBlue) end;
            end;
        if FShowTimeAndAccount then

        if (Customer.TimeLeft <= 0) and (Customer.TimeLeft >= -2) then
        begin
            if frmMain.TryToConnect then
                frmMain.itcMain.WriteLn('NOTIME ' + frmMain.ipwMain.LocalName)
        end else if Customer.TimeLeft < -2 then
            frmMain.EndCustomerSession;
    //end;
    if (not frmMain.AdminSession) and (Customer.Id > -1) then
    begin

        frmMain.UpDateTimeLeft;
    end;
    UpDateGUI;
end;


procedure TfrmSessionOpen.tmrFlashMessageTimer(Sender: TObject);
begin

    FlashWindow(Handle, true);
    Inc(FFlashMessageDuration);
    if FFlashMessageDuration = 10 then
    begin
        RestoreWindow;
        ctiMain.ShowBalloonHint('CAPPUCCINO', 'L''icone de Cappuccino se situe ici.', bitInfo, 10);
     //   WindowState := wsMinimized;
    end;
end;

procedure TfrmSessionOpen.actEndAdminSessionExecute(Sender: TObject);
begin
 frmMain.EndAdminSession;
end;

procedure TfrmSessionOpen.actOptionsExecute(Sender: TObject);
begin
if not frmOptions.Visible then
        frmOptions.ShowModal;
end;

procedure TfrmSessionOpen.actRebootExecute(Sender: TObject);
begin
//    ShutDownWindows(Boolean((Sender as TAction).Tag), 0, '');
ShutDownWindows(Boolean((Sender as TAction).Tag));
end;

procedure TfrmSessionOpen.actShutdownExecute(Sender: TObject);
begin
//    ShutDownWindows(Boolean((Sender as TAction).Tag), 0, '');
ShutDownWindows(Boolean((Sender as TAction).Tag));
end;

procedure TfrmSessionOpen.actLogOffExecute(Sender: TObject);
begin
 LogOff;
end;

procedure TfrmSessionOpen.actCloseExecute(Sender: TObject);
begin
   frmMain.Tag := 1;
    try
        with frmMain do
        begin
             if itcMain.Connected then
             itcMain.Disconnect;
             ShowWindow(FindWindow('Progman',nil),SW_RESTORE);
            AfficheBarreDeTaches(true);
            itsMain.Active := false;
            Close;
        end;
    except
    end;
end;

procedure TfrmSessionOpen.actEndCustomerSessionExecute(Sender: TObject);
begin
frmMain.EndCustomerSession;
end;

procedure TfrmSessionOpen.actShowWindowExecute(Sender: TObject);
begin
 if Visible then
        if WindowState = wsMinimized then
            WindowState := wsNormal
        else
            Close
    else
    begin
        Show;
        WindowState := wsNormal;
    end;
end;

procedure TfrmSessionOpen.actModifyAuthenticationExecute(Sender: TObject);
begin
if not frmModifyAuthentication.Visible then
        frmModifyAuthentication.Show;
end;

procedure TfrmSessionOpen.actLockExecute(Sender: TObject);
begin
if frmMain.TryToConnect then
        frmMain.itcMain.WriteLn('ASKFORLOCKSESSION ' + frmMain.ipwMain.LocalName);
end;

procedure TfrmSessionOpen.actFirstPlantExecute(Sender: TObject);
begin
if formstyle=fsStayOnTop  then
formstyle:=fsnormal  else
        formstyle:=fsStayOnTop;
        show;
end;

procedure TfrmSessionOpen.alMainUpdate(Action: TBasicAction; var Handled: Boolean);
begin
 actShowWindow.Caption := IfThen(Visible and (WindowState = wsNormal), 'Masquer', 'Voir') +
        ' temps restant'+ ' / Acompte';

    actShowWindow.Enabled := FShowTimeAndAccount;
    Handled := true;
end;

procedure TfrmSessionOpen.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
ReleaseCapture;
  SendMessage(frmSessionOpen_.Handle, WM_SYSCOMMAND, 61458, 0);
end;

procedure TfrmSessionOpen.Label1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
ReleaseCapture;
  SendMessage(frmSessionOpen_.Handle, WM_SYSCOMMAND, 61458, 0);
end;

procedure TfrmSessionOpen.FormCreate(Sender: TObject);
begin
 FTrayIcon := TIcon.Create;
 //   RestoreWindow;
 //   UpDateSoundList;
end;

procedure TfrmSessionOpen.FormDestroy(Sender: TObject);
begin
FTrayIcon.Free;
 
end;

procedure TfrmSessionOpen.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
tmrPersistant.Enabled := false;
      ctiMain.IconVisible:=false;
end;

procedure TfrmSessionOpen.FormShow(Sender: TObject);
begin
progressbar1.Position:=0;
//SetWindowLong(Application.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW);
//Former(frmSessionOpen,Image1.Picture.Bitmap);
tmrPersistant.Enabled := true;
//if frmSessionOpen.Visible then
        if Customer.Account >0 then ctiMain.ShowBalloonHint('CAPPUCCINO', 'Il faut payer vos dûe de: '+FormatFloat('0.00 ', Customer.Account / 100) + Settings.MonetarySymbol +' le plutot possible', bitInfo, 20);
     //    frmSessionOpen.Position:=poDesktopCenter;
end;

end.
