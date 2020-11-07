unit u_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ToolWin, Vcl.ComCtrls, Vcl.Menus,
  Vcl.StdCtrls, System.Actions, Vcl.ActnList, Vcl.Clipbrd,System.UITypes, u_help;

type
  T�޸��� = class(TForm)
    MainMenu1: TMainMenu;
    FontDialog1: TFontDialog;
    ActionList1: TActionList;
    actFileNew: TAction;
    actFileOpen: TAction;
    actFileSave: TAction;
    actFileSaveAs: TAction;
    actFileQuit: TAction;
    actEditCopy: TAction;
    actEditPaste: TAction;
    actEditCut: TAction;
    actEditSelectAll: TAction;
    actEditSelectNone: TAction;
    actViewStatusbar: TAction;
    miFile: TMenuItem;
    miEdit: TMenuItem;
    miView: TMenuItem;
    miViewStatusBar: TMenuItem;
    miEditCopy: TMenuItem;
    miEditCut: TMenuItem;
    miEditPaste: TMenuItem;
    miEditN1: TMenuItem;
    miEditSelectAll: TMenuItem;
    miEditSelectNone: TMenuItem;
    miFileNew: TMenuItem;
    miFileOpen: TMenuItem;
    miFileSave: TMenuItem;
    miFileSaveAs: TMenuItem;
    miFileN1: TMenuItem;
    miFileQuit: TMenuItem;
    mmText: TMemo;
    StatusBar: TStatusBar;
    PopupMenu: TPopupMenu;
    miCopy: TMenuItem;
    miCut: TMenuItem;
    miPaste: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog1: TSaveDialog;
    actEditUndo: TAction;
    miEditN2: TMenuItem;
    miEditUndo: TMenuItem;
    actFormatFont: TAction;
    miFormat: TMenuItem;
    miFormatFont: TMenuItem;
    actHelpAbout: TAction;
    miHelp: TMenuItem;
    miHelpAbout: TMenuItem;
    ColorDialog1: TColorDialog;
    ����: TMenuItem;
    actFormatColor: TAction;
    procedure mmTextChange(Sender: TObject);
    procedure actEditCopyExecute(Sender: TObject);
    procedure actEditCutExecute(Sender: TObject);
    procedure actEditPasteExecute(Sender: TObject);
    procedure actEditSelectAllExecute(Sender: TObject);
    procedure actEditSelectNoneExecute(Sender: TObject);
    procedure actViewStatusbarExecute(Sender: TObject);
    procedure actFileQuitExecute(Sender: TObject);
    procedure actFileNewExecute(Sender: TObject);
    procedure actFileSaveExecute(Sender: TObject);
    procedure actFileOpenExecute(Sender: TObject);
    procedure actFileSaveAsExecute(Sender: TObject);
    procedure actEditUndoExecute(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure miEditClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actFormatFontExecute(Sender: TObject);
    procedure actHelpAboutExecute(Sender: TObject);
    procedure actFormatColorExecute(Sender: TObject);
  private
    FileName:String;
    Changed:boolean;
  public
    { Public declarations }
  end;

var
  �޸���: T�޸���;

implementation

{$R *.dfm}

procedure T�޸���.actEditCopyExecute(Sender: TObject);
begin
  mmText.CopyToClipboard;
end;

procedure T�޸���.actEditCutExecute(Sender: TObject);
begin
  mmText.CutToClipboard;
end;

procedure T�޸���.actEditPasteExecute(Sender: TObject);
begin
  mmText.PasteFromClipboard;
end;

procedure T�޸���.actEditSelectAllExecute(Sender: TObject);
begin
  mmText.SelectAll;
end;

procedure T�޸���.actEditSelectNoneExecute(Sender: TObject);
begin
  mmText.SelLength := 0;
end;

procedure T�޸���.actEditUndoExecute(Sender: TObject);
begin
  mmText.Undo;
end;

procedure T�޸���.actFileNewExecute(Sender: TObject);
begin
  if FileName = '' then
  begin
    actFileSaveAs.Execute;
  end;
  FileName := '';
  mmText.Lines.Clear;
end;

procedure T�޸���.actFileOpenExecute(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    FileName := OpenDialog.FileName;
    mmText.Lines.LoadFromFile(FileName);
  end;
end;

procedure T�޸���.actFileQuitExecute(Sender: TObject);
begin
  Close;
end;

procedure T�޸���.actFileSaveAsExecute(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    FileName := SaveDialog1.FileName;
    mmText.Lines.SaveToFile(FileName);
    �޸���.Caption := '�޸��� - '+FileName;
    Changed := false;
  end;
end;

procedure T�޸���.actFileSaveExecute(Sender: TObject);
begin
  if FileName = '' then
  begin
    actFileSaveAs.Execute;
  end
  else
  begin
    mmText.Lines.SaveToFile(FileName);
    �޸���.Caption := '�޸��� - '+FileName;
    Changed := false;
  end;
end;

procedure T�޸���.actFormatColorExecute(Sender: TObject);
begin
  if ColorDialog1.Execute then
  begin
    mmText.Color := ColorDialog1.Color;
  end;

end;

procedure T�޸���.actFormatFontExecute(Sender: TObject);
begin
  if FontDialog1.Execute then
  begin
    mmText.Font := FontDialog1.Font;
  end;
end;

procedure T�޸���.actHelpAboutExecute(Sender: TObject);
begin
  Form1.ShowModal;
end;

procedure T�޸���.actViewStatusbarExecute(Sender: TObject);
begin
  StatusBar.Visible := not StatusBar.Visible;
end;

procedure T�޸���.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Selected : integer;
begin
  Selected := 0;
  if Changed = true then
  begin
    if mmText.Lines.Count <> 0 then
    begin
      if FileName = '' then
      begin
        Selected := MessageDlg('������ ���� �������� ���� ��������� �����Ͻðڽ��ϱ�?' ,mtWarning, [mbYes, mbNo],0);
      end
      else if FileName <> '' then
      begin
        Selected := MessageDlg(FileName + '�� ���� �������� ���� ��������� �����Ͻðڽ��ϱ�?' ,mtWarning, [mbYes, mbNo],0);
      end;
      if Selected = mrYes then
      begin
        actFileSave.Execute;
      end
      else if Selected = mrNo then
      begin
        exit;
      end;
    end;
  end;
end;

procedure T�޸���.miEditClick(Sender: TObject);
begin
  miEditCopy.Enabled := mmText.SelLength <> 0;
  miEditCut.Enabled := mmText.SelLength <> 0;
  miEditPaste.Enabled := Clipboard.AsText <> '';
  miEditSelectAll.Enabled := mmText.SelLength <> Length(mmText.Lines.Text);
  miEditSelectNone.Enabled := mmText.SelLength <> 0;
  miEditUndo.Enabled := mmText.CanUndo;
end;

procedure T�޸���.mmTextChange(Sender: TObject);
begin
  StatusBar.SimpleText := IntToStr(mmText.Lines.Count) + ' ��';
  Changed := true;
end;

procedure T�޸���.PopupMenuPopup(Sender: TObject);
begin
  miCopy.Enabled := mmText.SelLength <> 0;
  miCut.Enabled := mmText.SelLength <> 0;
  miPaste.Enabled := Clipboard.AsText <> '';
end;

end.