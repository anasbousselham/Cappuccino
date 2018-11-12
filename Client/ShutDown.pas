unit ShutDown;

interface

procedure ShutDownWindows(const Reboot: Boolean; const TimeOut: Integer; const Msg: string);
procedure AbordShutDown;
procedure LogOff;

implementation

uses Windows, Forms;

procedure ShutDownWindows(const Reboot: Boolean; const TimeOut: Integer; const Msg: string);
var
    TokenIn, TokenOut: TTokenPrivileges; // Etat precedent, etat final.
    ReturnLength: Cardinal; // Pas utilisé
    CurrentProcess, Token: THandle;
    Luid: TLargeInteger;
begin
    // CurentProcess : Processus de l'application.
    CurrentProcess := GetCurrentProcess;
    OpenProcessToken(CurrentProcess, TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, Token);
    LookupPrivilegeValue(nil, 'SeShutdownPrivilege', Luid);
    TokenIn.PrivilegeCount := 1; // Nombre de priviliges
    TokenIn.Privileges[0].Luid := Luid;
    TokenIn.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
    // Ajuste les privileges
    AdjustTokenPrivileges(Token, false, TokenIn, SizeOf(TTokenPrivileges), TokenOut, ReturnLength);
    if not InitiateSystemShutdown(nil, PChar(Msg), TimeOut, true, Reboot) then
        if Reboot then
            ExitWindowsEx(EWX_REBOOT or EWX_FORCEIFHUNG, 0)
        else
            ExitWindowsEx(EWX_SHUTDOWN or EWX_FORCEIFHUNG, 0);
end; // ShutDownWindows

procedure AbordShutDown;
begin
    AbortSystemShutdown(nil);
end; // AbordShutDown

procedure LogOff;
begin
    ExitWindowsEx(EWX_LOGOFF or EWX_FORCE, 0);
end; // LogOff

end.
