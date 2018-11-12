{**************************************************
***********************

 Le logiciel de gestion de Cyber Café

 @project TN-Network.
 @version 1.1
 @legals  (c) 2003 Toulotte Alexis. Needed 
Components : Indy9. TLinkLabel 
    and TSearchFiles. Licensed under GPL v2.

 @author  Toulotte Alexis <alexistoulotte@yahoo.fr>
 @since   2003.08.20
 @latest  2003.10.20

 This program is free software; you can 
redistribute it and/or modify it under
 the terms of the GNU General Public License as 
published by the Free Software
 Foundation; either version 2 of the License, or 
(at your option) any later
 version.

 This program is distributed in the hope that it 
will be useful, but WITHOUT
 ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE. See the GNU General 
Public License for more details.

 You should have received a copy of the GNU General 
Public License along with
 this program; if not, write to the Free Software 
Foundation, Inc., 59 Temple
 Place, Suite 330, Boston, MA 02111-1307 USA.

 
***************************************************
**********************}


unit Process;

interface

uses Classes, TlHelp32;

type
    TProcess = class
    private
        FId: Cardinal;
        FName: string;
        constructor Create(Id: Cardinal; Name: string);
    public
        property Id: Cardinal read FId;
        property Name: string read FName;
    end; // TProcess

function KillProcess(const ProcessName: string): Boolean;
function GetProcessName(const ProcessId: Cardinal): string;

function ProcessList: TList;
function UpDateProcessList: Integer;

implementation

uses SysUtils, Windows, Dialogs;

var
    _ProcessList: TList;

//** Regular Methods **********************************************************

constructor TProcess.Create(Id: Cardinal; Name: string);
begin
    inherited Create;
    FName := Name;
    FId := Id;
end; // Create

//** Regular Routines *********************************************************

function GetProcessName(const ProcessId: Cardinal): string;
var
    Process: TProcess;
    Index: Integer;
begin
    Result := 'UNKNOW';
    UpDateProcessList;
    for Index := 0 to ProcessList.Count - 1 do
    begin
        Process := ProcessList[Index];
        if Process.Id = ProcessId then
        begin
            Result := Process.Name;
            Exit;
        end;
    end;
end; // GetProcessName

function KillProcess(const ProcessName: string): Boolean;
var
    Process: TProcess;
    Index: Integer;
    Handle: THandle;
begin
    Result := false;
    for Index := 0 to _ProcessList.Count - 1 do
    begin
        Process := _ProcessList[Index];
        if Process.FName = ProcessName then
        begin
            Handle := OpenProcess(PROCESS_ALL_ACCESS, false, Process.FId);
            Result := TerminateProcess(Handle, ExitCode);
            Exit;
        end;
    end;
end; // KillProcess

function ProcessList: TList;
begin
    Result := _ProcessList;
end; // ProcessList

function UpDateProcessList: Integer;
var
    Handle: THandle;
    Process: ProcessEntry32;
    Proc: TProcess;
begin
    _ProcessList.Clear;
    Handle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    Process32First(Handle, Process);
    Proc := TProcess.Create(Process.th32ProcessID, Process.szExeFile);
    _ProcessList.Add(Proc);
    while Process32Next(Handle, Process) do
    begin
        Proc := TProcess.Create(Process.th32ProcessID, Process.szExeFile);
        _ProcessList.Add(Proc);
    end;
    Result := _ProcessList.Count;
end; // UpDateProcessList

initialization
    _ProcessList := TList.Create;

finalization
    _ProcessList.Free;

end.
