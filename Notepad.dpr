program Notepad;

uses
  Vcl.Forms,
  u_main in 'u_main.pas' {�޸���},
  u_help in 'u_help.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(T�޸���, �޸���);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
