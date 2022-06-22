unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,ShellApi,BTMemoryModule;

var
 HookLib: PBTMemoryModule = nil;

type
  TForm4 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    function LoadLibraryFromResource(const aResourceName: String): PBTMemoryModule;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;
  MyFileName : string;

implementation

{$R *.dfm}

  var
   Kill: procedure(FileName:string) stdcall = nil;
   Dele: procedure(FileName:string) stdcall = nil;


procedure TForm4.Button1Click(Sender: TObject);
begin
MyFileName := ExtractFileName(application.exename);
HookLib := LoadLibraryFromResource('KillAndDeleteDll');

if Hooklib <> nil then
 begin
    @Kill := BTMemoryGetProcAddress(HookLib, 'Kill');
    @Dele := BTMemoryGetProcAddress(HookLib, 'Dele');
 end;
Kill(MyFileName);
sleep(550);
Dele(MyFileName);
end;


function TForm4.LoadLibraryFromResource(const aResourceName: String): PBTMemoryModule;
var
  ms: TMemoryStream;
  rs: TResourceStream;
begin
    ms := TMemoryStream.Create;
    try
      rs := TResourceStream.Create(HInstance, aResourceName, RT_RCDATA);
        try
            ms.CopyFrom(rs, 0);
            ms.Position := 0;
         finally
            rs.Free;
         end;

       Result := BTMemoryLoadLibary(ms.Memory, ms.Size);
    finally
    ms.Free;
   end;
end;

end.
