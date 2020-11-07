program Notepad;

uses
  Vcl.Forms,
  u_main in 'u_main.pas' {메모장},
  u_help in 'u_help.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(T메모장, 메모장);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
