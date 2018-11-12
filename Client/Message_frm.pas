unit Message_frm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmMessage = class(TForm)
    pbxMain: TPaintBox;
    lblMessage: TLabel;
    tmrClose: TTimer;
    imgPattern: TImage;
    procedure FormCreate(Sender: TObject);
    procedure pbxMainPaint(Sender: TObject);
    procedure tmrCloseTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FBmp: TBitmap;
    procedure FilterBmp;
  public
    class procedure Execute(const Msg, FontName: string; const Seconds, Size: Integer;
        const Color: TColor);
  end; // TfrmMessage

implementation

uses Session_Open_frm;

{$R *.dfm}

class procedure TfrmMessage.Execute(const Msg, FontName: string;
    const Seconds, Size: Integer; const Color: TColor);
var
    Form: TfrmMessage;
begin
    Form := TfrmMessage.Create(nil);
    Form.lblMessage.Caption := Msg;
    Form.lblMessage.Font.Name := FontName;
    Form.tmrClose.Interval := Seconds * 1000;
    Form.lblMessage.Font.Size := Size;
    Form.lblMessage.Font.Color := Color;
    Form.Show;
end; // Execute

procedure TfrmMessage.FilterBmp;
var
    hBrush: THandle;
    Filter: TBitmap;
begin
    Filter := TBitmap.Create;
    try
        Filter.Width := FBmp.Width;
        Filter.Height := FBmp.Height;
        hBrush := CreatePatternBrush(imgPattern.Picture.Bitmap.Handle);
        try
            FillRect(Filter.Canvas.Handle, FBmp.Canvas.ClipRect, hBrush);
        finally
            DeleteObject(hBrush);
        end;
        BitBlt(FBmp.Canvas.Handle, 0, 0, FBmp.Width, FBmp.Height, Filter.Canvas.Handle,
            0, 0, SRCAND);
    finally
        Filter.Free;
    end;
end; // FilterBmp

procedure TfrmMessage.FormCreate(Sender: TObject);
var
    ScreenDC: HDC;
begin
    FBmp := TBitmap.Create;
    FBmp.Width := Screen.Width;
    FBmp.Height := Screen.Height;
    ScreenDC := GetDC(0);
    try
        BitBlt(FBmp.Canvas.Handle, 0, 0, FBmp.Width, FBmp.Height, ScreenDC, 0, 0, SRCCOPY);
        FilterBmp;
    finally
        ReleaseDC(0, ScreenDC);
    end;
    SetBounds(0,0,Screen.Width,Screen.Height);
end;

procedure TfrmMessage.pbxMainPaint(Sender: TObject);
begin
    pbxMain.Canvas.CopyRect(ClientRect, FBmp.Canvas, ClientRect);
end; // pbxMainPaint

procedure TfrmMessage.tmrCloseTimer(Sender: TObject);
begin
    Close;
end; // tmrCloseTimer

procedure TfrmMessage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := caFree;
end; // FormClose

procedure TfrmMessage.FormShow(Sender: TObject);
begin
    tmrClose.Enabled := True;
end; // FormShow

procedure TfrmMessage.FormDestroy(Sender: TObject);
begin
    FBmp.Free;
end; // FormDestroy

end.

