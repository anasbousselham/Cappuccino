unit uMem;

interface

Uses
  Registry, Windows, Classes, Sysutils, Forms;

type

  TMemoryEvent = procedure(Sender: TObject; AQuantity: integer) of object;

  TStatusMonitor = record
    TotalPhys: integer;
    AvailPhys: integer;
    TotalPageFile: integer;
    AvailPageFile: integer;
    TotalVirtual: integer;
    AvailVirtual: integer;
  end;

  TMem = class
  private
    Reg: TRegistry;
    MemoryStatus: TMemoryStatus;
    FOnAllocMemory: TMemoryEvent;
    FOnDeallocMemory: TMemoryEvent;

    function AutoRun(const AWrite, AValue: boolean): boolean;
    function MemoryScale(const AValue: integer): integer;

  public
    constructor Create;
    destructor Destroy; override;

    function GetAutoRun: boolean;
    procedure SetAutoRun(const AValue: boolean);

    function GetCPUUsage: Integer;
    function GetMemoryStatus: TStatusMonitor;

    procedure FreeRAM(const ARAMAmount: Integer);

    function IsWindowsNT: boolean;

  published
    property OnAllocMemory: TMemoryEvent read FOnAllocMemory write FOnAllocMemory;
    property OnDeallocMemory: TMemoryEvent read FOnDeallocMemory write FOnDeallocMemory;
  end;


Const
  MB1 = 1049172;
  GB1 = 1074917243;

Var
  mem: TMem;

implementation

{ TMem }

Const
  QueryKey = 'PerfStats\StatData';
  QueryVal = 'KERNEL\CPUUsage';


function TMem.AutoRun(const AWrite, AValue: boolean): boolean;
Var
  RegAutorun: TRegistry;
begin

  //DON'T USE DIRECLY USE SetAutoRun or GetAutoRun instead

  //If AWrite = True save to registry else read from registry
  //and return true if exists else false

  result := False;

  RegAutorun := TRegistry.Create;
  try
    with RegAutorun do
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey ('Software\Microsoft\Windows\CurrentVersion\Run', TRUE);

      if AWrite then
      begin
        if AValue then
        begin
          WriteString ('MemBoost', ParamStr(0));
        end
        else begin
          DeleteValue ('MemBoost');
        end;
      end
      else begin
        result := not (ReadString('MemBoost') = '');
      end;

    end;
  finally
    RegAutorun.Free;
  end;


end;

constructor TMem.Create;
begin
  //Allocate the resource for the registry, with I can read the CPU Usage
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_DYN_DATA;
  Reg.OpenKey (QueryKey, FALSE);

end;

destructor TMem.Destroy;
begin
  //Deallocate resource
  Reg.CloseKey;
  Reg.Free;
end;

function TMem.GetAutoRun: boolean;
begin
  result := AutoRun(False,False);
end;

function TMem.GetCPUUsage: Integer;
begin
  if Reg.ReadBinaryData (QueryVal, result, Sizeof (result)) < 1 then
    result := 0;
end;

procedure TMem.SetAutoRun(const AValue: boolean);
begin
  AutoRun(True, AValue);
end;

function TMem.IsWindowsNT: boolean;
Var
  OsVersionInfo: TOSVersionInfo;
begin

  result := False;

  //Get version of the windows
  OsVersionInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  if GetVersionEx(OsVersionInfo) then
  begin

    case OsVersionInfo.dwPlatformId of

      //Windows 98 and 95
      VER_PLATFORM_WIN32_WINDOWS:
      begin
        result := False;
      end;

      //Windows NT/2000
      VER_PLATFORM_WIN32_NT:
      begin
        result := True;
      end;

    end;
    
  end;

end;

function TMem.GetMemoryStatus: TStatusMonitor;
begin
  //Getting the resource
  GlobalMemoryStatus (MemoryStatus);

  result.TotalPhys      := MemoryScale(MemoryStatus.dwTotalPhys);
  result.AvailPhys      := MemoryScale(MemoryStatus.dwAvailPhys);
  result.TotalPageFile  := MemoryScale(MemoryStatus.dwTotalPageFile);
  result.AvailPageFile  := MemoryScale(MemoryStatus.dwAvailPageFile);
  result.TotalVirtual   := MemoryScale(MemoryStatus.dwTotalVirtual);
  result.AvailVirtual   := MemoryScale(MemoryStatus.dwAvailVirtual);

end;

function TMem.MemoryScale(const AValue: integer): integer;
begin
  //Trasform value on MB
  result := 0;

  if (AValue < 1000000) then
    result := 0;
    //result := Trunc(AValue / 1024);

  if (AValue > 1000000) and (AValue < 999999999) then
    result := Trunc(AValue / MB1);

  if AValue > 999999999 then
    result := Trunc(AValue / GB1);

end;

procedure TMem.FreeRAM(const ARAMAmount: Integer);
var
  //Dynamic array of Pointers to Memory
  PMem: array of pointer;
  i: Integer;

begin

  //Free the unused memory

  //Set array Length
  SetLength (PMem, ARAMAmount);

  //Allocate Memory
  for i := 0 to (ARAMAmount - 1) do
  begin
    PMem[i] := AllocMem (MB1);
    if Assigned(FOnAllocMemory) then
      FOnAllocMemory(Self,i);
    Application.ProcessMessages;
  end;

  //Free Allocated Memory
  for i := 0 to (ARAMAmount - 1) do
  begin
    FreeMem (PMem[i], MB1);
    if Assigned(FOnDeallocMemory) then
      FOnDeallocMemory(Self,i);
    Application.ProcessMessages;
  end;

end;


end.
