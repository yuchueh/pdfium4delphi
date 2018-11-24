unit uPdfiumIntf;

interface

{$I pdfium.inc }

uses
  Windows, SysUtils, Classes, Graphics, Controls, uPdfiumDll, Dialogs;

type
  WString = System.WideString;

  EPdfError = class(SysUtils.Exception)

  end;

  TRenderOption = (reAnnotations, reLcd, reNoNativeText, reGrayscale, reDebugInfo,
    reNoCatchException, reLimitCache, reHalftone, rePrinting, reReverseByteOrder);

  TRenderOptions = set of TRenderOption;

  TPageMode = (pmNone, pmOutline, pmThumbs, pmFullScreen, pmOptionalContentGroup, pmAttachments, pmUnknown);

  TSearchOption = (seCaseSensitive, seWholeWord);

  TSearchOptions = set of TSearchOption;

  TSaveOption = (saNone, saIncremental, saNoIncremental, saRemoveSecurity);

  TAction = (acUnsupported, acGoto, acGotoRemote, acUri, acLaunch);

  TPdfVersion = (pvUnknown, pv10, pv11, pv12, pv13, pv14, pv15, pv16, pv17);

  TRectangle = record
{$IFDEF DXEUP}
    private
{$ENDIF}
    Left: System.Double;
    Top: System.Double;
    Right: System.Double;
    Bottom: System.Double;
  end;

  TBookmark = record
{$IFDEF DXEUP}
    private
{$ENDIF}
    PageNumber: System.Integer;
    Action: TAction;
    ActionPageNumber: System.Integer;
  end;

  TPdf = class(Classes.TComponent)
  private
    FActive: System.Boolean;
    FDocument: FPDF_DOCUMENT;
    FFileName: System.AnsiString;
    FPageNumber: System.Integer;
    FPage: FPDF_PAGE;
    FTextPage: FPDF_TEXTPAGE;
    FPassword: System.AnsiString;
    FFind: FPDF_SCHHANDLE;
    PDFbuf: Tmemorystream;
    Fform: FPDF_FORMHANDLE;

    function GetPageCount: System.Integer;
    function GetPageWidth: System.Double;
    function GetPageHeight: System.Double;

    procedure SetActive(Value: System.Boolean);
    procedure SetFileName(Value: System.AnsiString);
    procedure SetPageNumber(Value: System.Integer);

    procedure LoadDocument;
  public
    constructor Create(AOwner: Classes.TComponent); override;
    destructor Destroy; override;

    procedure CreateDocument;

    procedure LoadFile;
    procedure closeDocument;

    procedure LoadPage(APageNumber: integer);
    procedure closePage;

    procedure LoadTextPage;
    procedure closeTextPage;

    procedure AddPage(PageNumber: System.Integer; Width: System.Double; Height: System.Double);
    procedure DeletePage(PageNumber: System.Integer);

    procedure loadFind(Text: System.WideString; Options: TSearchOptions; StartIndex: System.Integer);
    procedure closeFind;

    procedure RenderPageDevice(DeviceContext: Windows.HDC; page: FPDF_PAGE; Left: System.Integer; Top: System.Integer; Width: System.Integer; Height: System.Integer; Rotation: TRotation = ro0; Options: TRenderOptions = []);
    procedure RenderPageBitmap(bitmap: System.Pointer; Page: FPDF_PAGE; Left: System.Integer; Top: System.Integer; Width: System.Integer; Height: System.Integer; Rotation: TRotation = ro0; Options: TRenderOptions = []);
    function FindFirst(Text: System.WideString; Options: TSearchOptions = []; StartIndex: System.Integer = 0; DirectionUp: System.Boolean = true): System.Integer;
    function FindNext: System.Integer;
    function SaveAsCopy(const AFileName: string): Boolean;

    property Active: System.Boolean read FActive write SetActive default false;
    property Document: FPDF_DOCUMENT read FDocument;
    property FileName: System.AnsiString read FFileName write SetFileName;
    property PageNumber: System.Integer read FPageNumber write SetPageNumber default $0;

    property Page: FPDF_PAGE read FPage;
    property TextPage: FPDF_TEXTPAGE read FTextPage;

    property Find: FPDF_SCHHANDLE read FFind;
    property PageCount: System.Integer read GetPageCount;
    property PageHeight: System.Double read GetPageHeight;
    property PageWidth: System.Double read GetPageWidth; 
  end;

  TPdfView = class(TCustomControl)
  private
    FOptions: TRenderOptions;
    FPdf: TPdf;
    FRotation: TRotation;
    FZoomFactor: double;
    FOnPaint: Classes.TNotifyEvent;

    procedure SetOptions(Value: TRenderOptions);
    procedure SetRotation(Value: TRotation);

    procedure Setsize;
    procedure SetzoomFactor(Value: double);
    procedure Paint; override;

  public
    constructor Create(AOwner: Classes.TComponent); virtual;
    destructor Destroy; override;

    procedure OpenPdfFile(PDFfilename: string);
    procedure ClosePdfFile;
    procedure SaveAs(const AFileName: string);

    procedure FirstPage;
    procedure PreviousPage;
    procedure NextPage;
    procedure LastPage;

    procedure FitWidth;
    procedure FitHeight;
    procedure FitPage;

    procedure RotateLeft;
    procedure RotateRight; 

    property Align;
    property Anchors;
    property Color default $FE00000A;
    property Constraints;
    property DragCursor default $FFFFFFF4;
    property DragKind;
    property DragMode;
    property Enabled default true;
    property Options: TRenderOptions read FOptions write SetOptions default [];
    property ParentShowHint default true;
    property Pdf: TPdf read FPdf {0x43D} write FPdf {0x43D};
    property PopupMenu;
    property Rotation: TRotation read FRotation write SetRotation default ro0;
    property zoomFactor: Double read FZoomFactor write setzoomFactor;
    property ShowHint;
    property Visible default true;
  published
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnPaint: Classes.TNotifyEvent read FOnPaint write FOnPaint;
    property OnStartDock;
    property OnStartDrag;
  end;            

var
  unsuppored_info: UNSUPPORT_INFO;
  gTmpFileName: string;

procedure UnSupport_Handler(pThis: PUNSUPPORT_INFO; nType: System.Integer);

implementation

var
  ScrollWidth: integer = 17;
  form: FPDF_FORMHANDLE;

procedure __LoadLibrary;
begin
  FPDF_InitLibrary;
  FillChar(unsuppored_info, sizeof(unsuppored_info), 0);
  unsuppored_info.version := 1;
  unsuppored_info.FSDK_UnSupport_Handler := @UnSupport_Handler;
  FSDK_SetUnSpObjProcessHandler(unsuppored_info);
end;

procedure __UnloadLibrary;
begin
  FPDF_DestroyLibrary();
end;
  
//TPdf               
constructor TPdf.Create(AOwner: Classes.TComponent);
begin
  inherited Create(AOwner);
  pdfbuf := Tmemorystream.Create;
  __LoadLibrary;
end;

destructor TPdf.Destroy;
begin
  __UnloadLibrary;
  pdfbuf.Free;
  inherited Destroy;
end;

procedure TPdf.SetFileName(Value: System.AnsiString);
begin
  if (Value <> '') and (FileExists(Value)) then FFileName := Value;
end;

procedure TPdf.LoadFile;
var
  size: integer;
  fp: Tfilestream;
begin
  fp := Tfilestream.Create(FileName, fmShareDenyRead);
  try
    pdfbuf.Clear;
    PDFbuf.LoadFromStream(fp);
  finally
    fp.Free;
  end;  
  FDocument := FPDF_LoadMemDocument(PDFbuf.Memory, pdfbuf.Size, '');
end;

procedure TPdf.LoadDocument;
var
  formCallbacks: FPDF_FORMFILLINFO;
  platform_callbacks: IPDF_JSPLATFORM;

  function Form_Alert(pThis: PIPDF_JsPlatform; Msg: FPDF_WIDESTRING; Title: FPDF_WIDESTRING; Type_: Integer; Icon: Integer): Integer;
  begin
    Result := 0;
  end;

begin
  FillChar(platform_callbacks, sizeof(platform_callbacks), 0);
  platform_callbacks.version := 1;
  platform_callbacks.app_alert := @Form_Alert;

  FPDF_GetDocPermissions(FDocument);

  FillChar(formCallbacks, sizeof(formCallbacks), 0);
  formCallbacks.version := 1;
  formcallbacks.m_pJsPlatform := @platform_callbacks;

  Fform := FPDFDOC_InitFormFillEnvironment(FDocument, formCallbacks);
  FPDF_SetFormFieldHighlightColor(Fform, 0, $FFE4DD);
  FPDF_SetFormFieldHighlightAlpha(Fform, 100);

  FORM_DoDocumentJSAction(Fform);
  FORM_DoDocumentOpenAction(Fform);  
end;

procedure TPdf.closeDocument;
begin
  if (Fform <> nil) then
  begin
    FORM_DoDocumentAAction(Fform, FPDFDOC_AACTION_WC);
    FPDFDOC_ExitFormFillEnvironment(Fform);
  end;
  if FDocument <> nil then FPDF_closeDocument(FDocument);
end;                   

procedure TPdf.LoadPage(APageNumber: integer);
begin
  FPage := FPDF_LoadPage(FDocument, APageNumber);
  if FPage <> nil then FTextPage := FPDFText_LoadPage(Fpage);
end;

procedure TPdf.ClosePage;
begin
  if FTextPage <> nil then FPDFText_ClosePage(FTextPage);
  if FPage <> nil then FPDF_ClosePage(Fpage);
end;

function TPdf.GetPageCount: System.Integer;
begin
  Result := FPDF_GetPageCount(FDocument);
end;

function TPdf.GetPageWidth: System.Double;
begin
  Result := FPDF_GetPageWidth(FPage);
end;

function TPdf.GetPageHeight: System.Double;
begin
  Result := FPDF_GetPageHeight(FPage);
end;

procedure TPdf.LoadTextPage;
begin
  
end;

procedure TPdf.CloseTextPage;
begin
//
end;

procedure TPdf.CreateDocument;
begin
  FDocument := FPDF_CreateNewDocument;
end;

procedure TPdf.AddPage(PageNumber: System.Integer; Width: System.Double;
  Height: System.Double);
begin
  FPDFPage_New(FDocument, PageNumber, Width, Height);
end;

procedure TPdf.DeletePage(PageNumber: System.Integer);
begin
  FPDFPage_Delete(FDocument, PageNumber);
end;

procedure TPdf.LoadFind(Text: System.WideString; Options: TSearchOptions; StartIndex: System.Integer);
begin
//  FPDFPAGE_
end;

procedure TPdf.CloseFind;
begin
//
end;

procedure TPdf.SetActive(Value: System.Boolean);
var
  n: integer;
begin
  if Value = true then
  begin
    if FActive = false then
    begin
      Loadfile;
      LoadDocument;
      loadpage(0);
      FActive := true;
    end;
  end
  else
  begin
    if FActive = true then
    begin

      closepage;
      closeDocument;
      FActive := false;
    end;
  end;
end;

procedure TPdf.SetPageNumber(Value: System.Integer);
begin
  FPageNumber := Value;
end;


procedure TPdf.RenderPageDevice(DeviceContext: Windows.HDC; page: FPDF_PAGE; Left: System.Integer; Top: System.Integer; Width: System.Integer; Height: System.Integer;
  Rotation: TRotation = ro0; Options: TRenderOptions = []);
begin
  FPDF_RenderPage(DeviceContext, page, Left, Top, width, height, Rotation, 0);
end;

procedure TPdf.RenderPageBitmap(bitmap: System.Pointer; Page: FPDF_PAGE; Left: System.Integer; Top: System.Integer; Width: System.Integer; Height: System.Integer;
  Rotation: TRotation = ro0; Options: TRenderOptions = []);
begin
  FPDF_RenderPageBitmap(bitmap, page, Left, Top, width, height, Rotation, 0);
end;


function TPdf.FindFirst(Text: System.WideString; Options: TSearchOptions = []; StartIndex: System.Integer = 0; DirectionUp: System.Boolean = true): System.Integer;
begin
//
end;

function TPdf.FindNext: System.Integer;
begin
 //
end;      

// TPdfView       
constructor TPdfView.Create(AOwner: Classes.TComponent);
begin
  inherited Create(AOwner);
  FPdf := TPdf.Create(AOwner);
end;

destructor TPdfView.Destroy;
begin
  FPdf.free;
  inherited Destroy;
end;

procedure TPdfView.OpenPdfFile(PDFfilename: string);
begin
  Pdf.Active := False;
  Pdf.FileName := ansistring(PDFfilename);
  Pdf.PageNumber := 0;
  fzoomFactor := 100;
  Rotation := ro0;
  Pdf.Active := True;
  FitPage;
  SetSize;
  paint;
end;

procedure TPdfView.ClosePdfFile;
begin
  Pdf.Active := False;
end;

procedure TPdfView.SetRotation(Value: TRotation);
begin
  FRotation := Value;
  SetSize;
  paint;
end;

procedure TPdfView.SetOptions(Value: TRenderOptions);
begin
  //
end;

procedure TPdfView.SetzoomFactor(Value: double);
begin
  fzoomFactor := Value;
  SetSize;
end;

procedure TPdfView.SetSize;
var
  PageX, PageY, pdfwidth, pdfheight, jh: double;
begin
  pdfwidth := pdf.PageWidth * zoomFactor / 100;
  pdfheight := pdf.Pageheight * zoomFactor / 100;
  if (Rotation = ro90) or (Rotation = ro270) then
  begin
    jh := pdfwidth;
    pdfwidth := pdfheight;
    pdfheight := jh
  end;

  PageX := (Parent.ClientWidth - pdfWidth) / 2.0;
  if PageX < 0 then PageX := 0;
  PageY := (Parent.ClientHeight - pdfHeight) / 2.0;
  if PageY < 0 then PageY := 0;

  Left := round(pagex);
  Top := round(pagey);
  width := round(pdfwidth);
  height := round(pdfheight);
end;

procedure TPdfView.Paint;
var
  Rect: TRect;
  PageX, PageY, pdfwidth, pdfheight, jh: double;
begin
  pdfwidth := pdf.PageWidth * zoomFactor / 100;
  pdfheight := pdf.Pageheight * zoomFactor / 100;

  if (Rotation = ro90) or (Rotation = ro270) then
  begin
    jh := pdfwidth;
    pdfwidth := pdfheight;
    pdfheight := jh
  end;

  Rect := GetClientRect;
  Canvas.Brush.Color := clWhite;
  Canvas.FillRect(Rect);

  pdf.RenderPageDevice(getdc(Handle), pdf.fpage, 0, 0, round(pdfwidth), round(pdfheight), Rotation);
end;

procedure TPdfView.RotateRight;
begin
  case Rotation of
    ro0: Rotation := ro90;
    ro90: Rotation := ro180;
    ro180: Rotation := ro270;
    ro270: Rotation := ro0;
  end;
end;

procedure TPdfView.Rotateleft;
begin
  case Rotation of
    ro0: Rotation := ro270;
    ro270: Rotation := ro180;
    ro180: Rotation := ro90;
    ro90: Rotation := ro0;
  end;
end;

procedure TPdfView.FitWidth;
var
  PageWidth, PageHeight: double;
  xfactor, yfactor: integer;
begin
  pageWidth := FPDF_GetPageWidth(pdf.page);
  PageHeight := FPDF_GetPageHeight(pdf.page);
  xfactor := Trunc(100 * Parent.Width / PageWidth);
  yfactor := Trunc(100 * Parent.Height / PageHeight);
  if xfactor < yfactor then
  begin
    ZoomFactor := Trunc(100 * (Parent.Width) / PageWidth);
  end
  else
  begin
    ZoomFactor := Trunc(100 * (Parent.Width - ScrollWidth) / PageWidth);
  end;
  SetSize;
end;

procedure TPdfView.FitHeight;
var
  PageWidth, PageHeight: double;
  xfactor, yfactor: integer;
begin
  pageWidth := FPDF_GetPageWidth(pdf.page);
  PageHeight := FPDF_GetPageHeight(pdf.page);
  xfactor := Trunc(100 * Parent.Width / PageWidth);
  yfactor := Trunc(100 * Parent.Height / PageHeight);
  if xfactor < yfactor then
  begin
    ZoomFactor := Trunc(100 * (Parent.Height - ScrollWidth) / PageHeight);
  end
  else
  begin
    ZoomFactor := Trunc(100 * (Parent.Height) / PageHeight);
  end;
  SetSize;
end;

procedure TPdfView.FitPage;
var
  PageWidth, PageHeight: double;
  xfactor, yfactor: integer;
begin
  pageWidth := FPDF_GetPageWidth(pdf.page);
  PageHeight := FPDF_GetPageHeight(pdf.page);
  xfactor := Trunc(100 * Parent.Width / PageWidth);
  yfactor := Trunc(100 * Parent.Height / PageHeight);
  if xfactor < yfactor then
    ZoomFactor := xfactor
  else
    ZoomFactor := yfactor;
  SetSize;
end;

procedure TPdfView.FirstPage;
begin
  Pdf.PageNumber := 0;
  FPDF_ClosePage(pdf.FPage);
  pdf.FPage := FPDF_LoadPage(pdf.FDocument, Pdf.PageNumber);
  paint;
end;

procedure TPdfView.PreviousPage;
begin
  if Pdf.PageNumber > 0 then
  begin
    Pdf.PageNumber := Pdf.PageNumber - 1;
    FPDF_ClosePage(pdf.FPage);
    pdf.FPage := FPDF_LoadPage(pdf.FDocument, Pdf.PageNumber);
    paint;
  end;
end;

procedure TPdfView.NextPage;
begin
  if Pdf.PageNumber < Pdf.PageCount - 1 then
  begin
    Pdf.PageNumber := Pdf.PageNumber + 1;
    FPDF_ClosePage(pdf.FPage);
    pdf.FPage := FPDF_LoadPage(pdf.FDocument, Pdf.PageNumber);
    paint;
  end;
end;

procedure TPdfView.LastPage;
begin
  Pdf.PageNumber := Pdf.PageCount - 1;
  FPDF_ClosePage(pdf.FPage);
  pdf.FPage := FPDF_LoadPage(pdf.FDocument, Pdf.PageNumber);
  paint;
end;

procedure UnSupport_Handler(pThis: PUNSUPPORT_INFO; nType: System.Integer);
var
  feature: string;
begin
  feature := 'Unknown';
  case (ntype) of
    FPDF_UNSP_DOC_XFAFORM:
      begin
        feature := 'XFA';
   //   break;
      end;
    FPDF_UNSP_DOC_PORTABLECOLLECTION:
      begin
        feature := 'Portfolios_Packages';
    //  break;
      end;
    FPDF_UNSP_DOC_ATTACHMENT: begin

      end;
    FPDF_UNSP_ANNOT_ATTACHMENT:
      begin
        feature := 'Attachment';
   //   break;
      end;
    FPDF_UNSP_DOC_SECURITY: begin
        feature := 'Rights_Management';
   //   break;
      end;
    FPDF_UNSP_DOC_SHAREDREVIEW: begin
        feature := 'Shared_Review';
    //  break;
      end;
    FPDF_UNSP_DOC_SHAREDFORM_ACROBAT: begin

      end;
    FPDF_UNSP_DOC_SHAREDFORM_FILESYSTEM: begin

      end;
    FPDF_UNSP_DOC_SHAREDFORM_EMAIL: begin
        feature := 'Shared_Form';
 //     break;
      end;
    FPDF_UNSP_ANNOT_3DANNOT:
      feature := '3D';
    //  break;
    FPDF_UNSP_ANNOT_MOVIE:
      feature := 'Movie';
   //   break;
    FPDF_UNSP_ANNOT_SOUND:
      feature := 'Sound';
    //  break;
    FPDF_UNSP_ANNOT_SCREEN_MEDIA: begin

      end;
    FPDF_UNSP_ANNOT_SCREEN_RICHMEDIA: begin
        feature := 'Screen';
   //   break;
      end;
    FPDF_UNSP_ANNOT_SIG: begin
        feature := 'Digital_Signature';
   //   break;
      end;
  end;
  showmessage('Unsupported feature:' + feature);   
end;       

procedure TPdfView.SaveAs(const AFileName: string);
begin
  FPdf.SaveAsCopy(AFileName);
end;

function __SaveWrite(pThis: PFPDF_FILEWRITE; pData: System.Pointer;
    size: System.LongWord): System.Integer cdecl;
var                        
  AMMStream: TMemoryStream;
begin
  AMMStream := TMemoryStream.Create;
  try
  finally
    AMMStream.Free;
  end;
end;
      
function TPdf.SaveAsCopy(const AFileName: string): Boolean;
var
  APDF_FILEWRITE: FPDF_FILEWRITE;
begin
  APDF_FILEWRITE.version := 1;
  APDF_FILEWRITE.WriteBlock := __SaveWrite;
  gTmpFileName := AFileName;
  Result := FPDF_SaveAsCopy(FDocument, APDF_FILEWRITE, 0)
end;

end.

