unit UInfoVersion;

interface

uses
  Windows, Messages, SysUtils, Classes;

type
  TInfoVersion = class(TObject)
  private
    FFileName: string;
    FItems: TStrings;
    procedure SetFileName(const Value: string);
  protected
  public
    constructor Create(const strFileName: string); overload;
    destructor Destroy; override;
    function GetFileInfo(StringInfo: string): string;
    function GetMajorNum: Integer;
    function GetMinorNum: Integer;
    function GetReleaseNum: Integer;
    function GetBuildNum: Integer;
    property Items: TStrings read FItems;
  published
    property FileName: string read FFileName write SetFileName;
  end;

implementation
const
  FILE_VERSION = 'FileVersion';
constructor TInfoVersion.Create(const strFileName: string);
begin
  inherited Create;
  FItems := TStringList.Create;
  FFileName := strFileName;
  SetFileName(FFileName);
end;

destructor TInfoVersion.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TInfoVersion.SetFileName(const Value: string);
const
  Ident: array[0..9] of string = (
    'CompanyName',
    'FileDescription',
    'FileVersion',
    'InternalName',
    'LegalCopyright',
    'LegalTrademarks',
    'OriginalFilename',
    'ProductName',
    'ProductVersion',
    'Comments');
var
  SizeInfo, lpdwHandle: DWORD;
  Buffer: PChar;
  P: PChar;
  I, L: Integer;
  Ad, SLang: string;
begin
  FFileName := Value;
  FItems.Clear;
  SizeInfo := GetFileVersionInfoSize(PChar(FFileName), lpdwHandle);
  if SizeInfo > 0 then
  begin
    GetMem(Buffer, SizeInfo);
    try
      GetFileVersionInfo(PChar(FFileName), 0, SizeInfo, Buffer);
      Ad := '\VarFileInfo\Translation';
      if VerQueryValueA(Buffer, PChar(Ad), Pointer(P), UINT(L)) and (L = 4) then
      begin
        SLang := IntToHex(PLongInt(P)^, 8);
        SLang := Copy(SLang, 5, 4) + Copy(SLang, 1, 4);
        for I := 0 to 8 do
        begin
          Ad := '\StringFileInfo\' + SLang + '\' + Ident[I];
          if VerQueryValue(Buffer, PChar(Ad), Pointer(P), UINT(L)) then
            FItems.Add(Ident[I] + ' = ' + P)
          else
            FItems.Add(Ident[I] + ' = ');
        end;
      end;
    finally
      FreeMem(Buffer);
    end;
  end;
end;

function TInfoVersion.GetFileInfo(StringInfo: string): string;
var
  I: Integer;
begin
  Result := '';
  StringInfo := UpperCase(StringInfo);
  for I := 0 to FItems.Count - 1 do
    if Pos(StringInfo + ' =', UpperCase(FItems[I])) = 1 then
    begin
      Result := Trim(Copy(FItems[I], Length(StringInfo + ' =') + 1, MAXINT));
      Exit;
    end;
end;

function TInfoVersion.GetMajorNum: Integer;
var
  SVer: string;
  N: Integer;
begin
  Result := -1;
  SVer := GetFileInfo('FileVersion');
  if SVer = '' then
    exit;
  SVer := SVer + '.';
  N := Pos('.', SVer);
  try
    Result := StrToInt(Copy(SVer, 1, N - 1));
  finally
  end;
end;

function TInfoVersion.GetMinorNum: Integer;
var
  SVer: string;
  N: Integer;
begin
  Result := -1;
  SVer := GetFileInfo('FileVersion');
  if SVer = '' then
    exit;
  SVer := SVer + '.';
  N := Pos('.', SVer);
  SVer := Copy(SVer, N + 1, MAXINT);
  N := Pos('.', SVer);
  try
    Result := StrToInt(Copy(SVer, 1, N - 1));
  finally
  end;
end;

function TInfoVersion.GetReleaseNum: Integer;
var
  SVer: string;
  N: Integer;
begin
  Result := -1;
  SVer := GetFileInfo('FileVersion');
  if SVer = '' then
    exit;
  SVer := SVer + '.';
  N := Pos('.', SVer);
  SVer := Copy(SVer, N + 1, MAXINT);
  N := Pos('.', SVer);
  SVer := Copy(SVer, N + 1, MAXINT);
  N := Pos('.', SVer);
  try
    Result := StrToInt(Copy(SVer, 1, N - 1));
  finally
  end;
end;

function TInfoVersion.GetBuildNum: Integer;
var
  SVer: string;
  N: Integer;
begin
  Result := -1;
  SVer := GetFileInfo('FileVersion');
  if SVer = '' then
    exit;
  SVer := SVer + '.';
  N := Pos('.', SVer);
  SVer := Copy(SVer, N + 1, MAXINT);
  N := Pos('.', SVer);
  SVer := Copy(SVer, N + 1, MAXINT);
  N := Pos('.', SVer);
  SVer := Copy(SVer, N + 1, MAXINT);
  N := Pos('.', SVer);
  try
    Result := StrToInt(Copy(SVer, 1, N - 1));
  finally
  end;
end;
end.

 