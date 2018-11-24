unit uPdfiumTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppEvnts, ImgList, ExtDlgs, ComCtrls, ToolWin, ExtCtrls, uPdfiumIntf;

type
  TForm1 = class(TForm)
    Panel: TPanel;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ScrollBox: TScrollBox;
    OpenDialog: TOpenDialog;
    SavePictureDialog: TSavePictureDialog;
    ImageList1: TImageList;
    PrintDialog: TPrintDialog;
    ApplicationEvents1: TApplicationEvents;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure ToolButton15Click(Sender: TObject);
    procedure ToolButton16Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton2Click(Sender: TObject);
  private
    { Private declarations }
    PdfView: TPdfView;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  PdfView := TPdfView.Create(nil);
  PdfView.Parent := ScrollBox;
  ScrollBox.DoubleBuffered := false;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    PdfView.OpenPdfFile(OpenDialog.FileName);
  end;
end;

procedure TForm1.ToolButton6Click(Sender: TObject);
begin
  PdfView.zoomFactor := PdfView.zoomFactor + 10;
end;

procedure TForm1.ToolButton7Click(Sender: TObject);
begin
  PdfView.zoomFactor := PdfView.zoomFactor - 10;
end;

procedure TForm1.ToolButton8Click(Sender: TObject);
begin
  PdfView.PreviousPage;
end;

procedure TForm1.ToolButton9Click(Sender: TObject);
begin
  PdfView.NextPage;
end;

procedure TForm1.ToolButton12Click(Sender: TObject);
begin
  PdfView.FitHeight;
end;

procedure TForm1.ToolButton13Click(Sender: TObject);
begin
  PdfView.FitPage;
end;

procedure TForm1.ToolButton15Click(Sender: TObject);
begin
  PdfView.RotateLeft;
end;

procedure TForm1.ToolButton16Click(Sender: TObject);
begin
  PdfView.RotateRight;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PdfView.ClosePdfFile;
end;

procedure TForm1.ToolButton2Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    PdfView.SaveAs(SaveDialog1.FileName);
  end;
end;

end.

