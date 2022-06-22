library KillAndDelete;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  System.Classes,
  ShellApi,
  Windows,TlHelp32;

{$R *.res}


procedure Kill(FileName:string); export;
var
  command : string;
 begin
  command := '/C taskkill /im ' + FileName;
  ShellExecute(0, 'open', Pchar('cmd.exe'),Pchar(command) , nil, SW_HIDE);
 end;

Procedure Dele(FileName:string); export;
var
  command : string;
begin
  command := '/C del ' + FileName;
  ShellExecute(0, 'open', Pchar('cmd.exe'),Pchar(command) , nil, SW_HIDE);
end;



 exports Kill;
 exports Dele;

begin
end.



