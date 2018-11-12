unit u_Saeubern;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ShlObj, ShellAPI;

procedure SaeubernStarten;
function TempDir: String;
procedure Loeschen(Dir: string);
procedure DelRecent;
procedure EmptyRecycleBin; 
procedure DelCokies;


implementation

procedure DeleteFilesFolder(sFolder:String; Mask: String);
var
  lpFileOp: TSHFILEOPSTRUCTA;
  TabFolder: array[0..255] of Char;
  i: Integer;
begin
  if sFolder = '' then Exit;
  if Copy(sFolder, Length(sFolder), 1) <> '\' then
    sFolder := sFolder+ '\'+Mask
  else
    sFolder := sFolder+ Mask;
  For i:=0 to Length(sFolder)-1 do TabFolder[i]:=sFolder[i+1];
  TabFolder[Length(sFolder)]:=#0;
  TabFolder[Length(sFolder)+1]:=#0;
  lpFileOp.Wnd := Application.Handle;
  lpFileOp.wFunc := FO_DELETE;
  lpFileOp.pFrom := TabFolder;
  lpFileOp.pTo := '';
  lpFileOp.fFlags := FOF_SILENT or FOF_NOERRORUI or FOF_NOCONFIRMATION;
  SHFileOperation(lpFileOp);
end;

function GetSpecialFolder(Folder: Integer): String;
var
  IdList: PITEMIDLIST;
  Dossier: array[0..MAX_PATH] of Char;
begin
  if SHGetSpecialFolderLocation(0, Folder, IdList) = NOERROR then begin
    SHGetPathFromIDList(IdList, Dossier);
    Result := String(Dossier);
  end
  else
    Result := '';
end;

procedure SaeubernStarten;
begin
 Loeschen(TempDir);
 DelCokies;
 DelRecent;
 EmptyRecycleBin;
end;

function TempDir: String;
var
  Buffer: Array[0..MAX_PATH+1] of Char;
begin
  GetTempPath(MAX_PATH+1,Buffer);
  TempDir:=StrPas(Buffer);
end;

procedure Loeschen(Dir: String);
var
  S: TSHFileOpStruct;
begin
  if (Dir<>'') and (Dir[length(Dir)]<>'\') then
    Dir:=Dir+'\';

    FillChar(S, sizeof(S), 0 );
    S.wFunc := FO_DELETE;
    S.pFrom := PChar(Dir+'*.*'+#0);
    S.fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
    ShFileOperation(S);
end;

procedure DelRecent;
begin
  SHAddToRecentDocs(0,nil);
end;

procedure DelCokies;
begin
DeleteFilesFolder(GetSpecialFolder(CSIDL_INTERNET_CACHE), '*.*');
DeleteFilesFolder(GetSpecialFolder(CSIDL_COOKIES), '*.txt');
DeleteFilesFolder(GetSpecialFolder(CSIDL_HISTORY), '*.*');
end;

Procedure EmptyRecycleBin ;
Const
  SHERB_NOCONFIRMATION = $00000001 ;
  SHERB_NOPROGRESSUI   = $00000002 ;
  SHERB_NOSOUND        = $00000004 ;
Type
  TSHEmptyRecycleBin = function (Wnd : HWND;
                                 pszRootPath : PChar;
                                 dwFlags : DWORD):
                             HRESULT; stdcall ;
Var
  SHEmptyRecycleBin : TSHEmptyRecycleBin;
  LibHandle         : THandle;

Begin 
  LibHandle := LoadLibrary(PChar('Shell32.dll')) ;
  if LibHandle <> 0 then
    @SHEmptyRecycleBin:= GetProcAddress(LibHandle,
                                    'SHEmptyRecycleBinA')
  else
    begin
      MessageDlg('SHELL32FAIL',
                 mtError,
                 [mbOK],
                 0);
      Exit;
    end;

  if @SHEmptyRecycleBin <> nil then
     SHEmptyRecycleBin(Application.Handle,
                       nil,
                       SHERB_NOCONFIRMATION or { no check }
                       SHERB_NOPROGRESSUI or SHERB_NOSOUND);
  FreeLibrary(LibHandle);
  @SHEmptyRecycleBin := nil ;
end;

end.
