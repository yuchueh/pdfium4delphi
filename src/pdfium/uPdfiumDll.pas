unit uPdfiumDll;

{$I pdfium.inc }

interface

uses Windows;

const
  {$IFDEF CPUX64}
  PDFIUMA_DLL = 'pdfiuma_x64.dll';
  {$ELSE}
  PDFIUMA_DLL = 'pdfiuma.dll';
  {$ENDIF CPUX64}
//View
type
  FPDF_MODULEMGR = System.Pointer;

  FPDF_DOCUMENT = System.Pointer;

  FPDF_PAGE = System.Pointer;

  FPDF_PAGEOBJECT = System.Pointer;

  FPDF_PATH = System.Pointer;

  FPDF_CLIPPATH = System.Pointer;

  FPDF_BITMAP = System.Pointer;

  FPDF_FONT = System.Pointer;

  FPDF_TEXTPAGE = System.Pointer;

  FPDF_SCHHANDLE = System.Pointer;

  FPDF_PAGELINK = System.Pointer;

  FPDF_HMODULE = System.Pointer;

  FPDF_DOCSCHHANDLE = System.Pointer;

  FPDF_BOOKMARK = System.Pointer;

  FPDF_DEST = System.Pointer;

  FPDF_ACTION = System.Pointer;

  FPDF_LINK = System.Pointer;

  FPDF_PAGERANGE = System.Pointer;

  FPDF_BOOL = System.boolean;

  FPDF_ERROR = System.Integer;

  FPDF_DWORD = System.LongWord;

  FS_FLOAT = System.Single;

  FPDF_DUPLEXTYPE = (DuplexUndefined, Simplex, DuplexFlipShortEdge, DuplexFlipLongEdge);

  FPDF_WCHAR = System.Word;

  FPDF_LPCBYTE = ^Byte;

  FPDF_BYTESTRING = System.PAnsiChar;

  FPDF_WIDESTRING = System.PWideChar;

  FPDF_STRING = System.PAnsiChar;

  FS_MATRIX = record
    a: System.Single;
    b: System.Single;
    c: System.Single;
    d: System.Single;
    e: System.Single;
    f: System.Single;
  end;

  FS_RECTF = record
    left: System.Single;
    top: System.Single;
    right: System.Single;
    bottom: System.Single;
  end;

  PFPDF_PAGE = ^FPDF_PAGE;

  FS_LPRECTF = ^FS_RECTF;

  FS_LPCRECTF = ^FS_RECTF;

  TRotation = (ro0, ro90, ro180, ro270);
  
const
  FPDF_POLICY_MACHINETIME_ACCESS = $00;

const
  FPDF_ERR_SUCCESS = $00;
  FPDF_ERR_UNKNOWN = $01;
  FPDF_ERR_FILE = $02;
  FPDF_ERR_FORMAT = $03;
  FPDF_ERR_PASSWORD = $04;
  FPDF_ERR_SECURITY = $05;
  FPDF_ERR_PAGE = $06;

const
  FPDF_ANNOT = $01;
  FPDF_LCD_TEXT = $02;
  FPDF_NO_NATIVETEXT = $04;
  FPDF_GRAYSCALE = $08;
  FPDF_DEBUG_INFO = $80;
  FPDF_NO_CATCH = $0100;
  FPDF_RENDER_LIMITEDIMAGECACHE = $0200;
  FPDF_RENDER_FORCEHALFTONE = $0400;
  FPDF_PRINTING = $0800;
  FPDF_REVERSE_BYTE_ORDER = $10;

const
  FPDFBitmap_Gray = $01;
  FPDFBitmap_BGR = $02;
  FPDFBitmap_BGRx = $03;
  FPDFBitmap_BGRA = $04;


type
  m_GetBlock = function(param: System.Pointer; position: System.LongWord; pBuf: Windows.PByte; size: System.LongWord): System.Integer; cdecl;

  FPDF_FILEACCESS = record
    m_FileLen: System.LongWord;
    m_GetBlock: m_GetBlock;
    m_Param: System.Pointer;
  end;

  PFPDF_FILEACCESS = ^FPDF_FILEACCESS;

procedure FPDF_InitLibrary; cdecl; external PDFIUMA_DLL;

procedure FPDF_DestroyLibrary; cdecl; external PDFIUMA_DLL;

procedure FPDF_SetSandBoxPolicy(policy: System.LongWord; enable: System.Integer); cdecl; external PDFIUMA_DLL;

function FPDF_LoadDocument(file_path: System.PAnsiChar; password: System.PAnsiChar): System.Pointer; cdecl; external PDFIUMA_DLL;

function FPDF_LoadMemDocument(data_buf: System.Pointer; size: System.Integer; password: System.PAnsiChar): System.Pointer; cdecl; external PDFIUMA_DLL;

function FPDF_LoadCustomDocument(pFileAccess: PFPDF_FILEACCESS; password: System.PAnsiChar): System.Pointer; cdecl; external PDFIUMA_DLL;

function FPDF_GetFileVersion(doc: System.Pointer; var fileVersion: System.Integer): System.Integer; cdecl; external PDFIUMA_DLL;


function FPDF_GetLastError: System.LongWord; cdecl; external PDFIUMA_DLL;

function FPDF_GetDocPermissions(document: System.Pointer): System.LongWord; cdecl; external PDFIUMA_DLL;

function FPDF_GetSecurityHandlerRevision(document: System.Pointer): System.Integer; cdecl; external PDFIUMA_DLL;

function FPDF_GetPageCount(document: System.Pointer): System.Integer; cdecl; external PDFIUMA_DLL;

function FPDF_LoadPage(document: System.Pointer; page_index: System.Integer): System.Pointer; cdecl; external PDFIUMA_DLL;

function FPDF_GetPageWidth(page: System.Pointer): System.Double; cdecl; external PDFIUMA_DLL;

function FPDF_GetPageHeight(page: System.Pointer): System.Double; cdecl; external PDFIUMA_DLL;

function FPDF_GetPageSizeByIndex(document: System.Pointer; page_index: System.Integer; var width: System.Double; var height: System.Double): System.Integer; cdecl; external PDFIUMA_DLL;

procedure FPDF_RenderPage(dc: Windows.HDC; page: System.Pointer; start_x: System.Integer; start_y: System.Integer;
  size_x: System.Integer; size_y: System.Integer; rotate: TRotation; flags: System.Integer); cdecl; external PDFIUMA_DLL;

procedure FPDF_RenderPageBitmap(bitmap: System.Pointer; page: System.Pointer; start_x: System.Integer; start_y: System.Integer;
  size_x: System.Integer; size_y: System.Integer; rotate: TRotation; flags: System.Integer); cdecl; external PDFIUMA_DLL;

procedure FPDF_ClosePage(page: System.Pointer); cdecl; external PDFIUMA_DLL;

procedure FPDF_CloseDocument(document: System.Pointer); cdecl; external PDFIUMA_DLL;

procedure FPDF_DeviceToPage(page: System.Pointer; start_x: System.Integer; start_y: System.Integer; size_x: System.Integer; size_y: System.Integer;
  rotate: System.Integer; device_x: System.Integer; device_y: System.Integer; var page_x: System.Double; var page_y: System.Double); cdecl; external PDFIUMA_DLL;

procedure FPDF_PageToDevice(page: System.Pointer; start_x: System.Integer; start_y: System.Integer; size_x: System.Integer; size_y: System.Integer;
  rotate: System.Integer; page_x: System.Double; page_y: System.Double; var device_x: System.Integer; var device_y: System.Integer); cdecl; external PDFIUMA_DLL;

function FPDFBitmap_Create(width: System.Integer; height: System.Integer; alpha: System.Integer): System.Pointer; cdecl; external PDFIUMA_DLL;

function FPDFBitmap_CreateEx(width: System.Integer; height: System.Integer; format: System.Integer; first_scan: System.Pointer; stride: System.Integer): System.Pointer; cdecl; external PDFIUMA_DLL;

procedure FPDFBitmap_FillRect(bitmap: System.Pointer; left: System.LongWord; top: System.LongWord; width: System.LongWord; height: System.LongWord; color: System.LongWord); cdecl; external PDFIUMA_DLL;

function FPDFBitmap_GetBuffer(bitmap: System.Pointer): System.Pointer; cdecl; external PDFIUMA_DLL;

function FPDFBitmap_GetWidth(bitmap: System.Pointer): System.Integer; cdecl; external PDFIUMA_DLL;

function FPDFBitmap_GetHeight(bitmap: System.Pointer): System.Integer; cdecl; external PDFIUMA_DLL;

function FPDFBitmap_GetStride(bitmap: System.Pointer): System.Integer; cdecl; external PDFIUMA_DLL;

procedure FPDFBitmap_Destroy(bitmap: System.Pointer); cdecl; external PDFIUMA_DLL;

function FPDF_VIEWERREF_GetPrintScaling(document: System.Pointer): System.Integer; cdecl; external PDFIUMA_DLL;

function FPDF_VIEWERREF_GetNumCopies(document: System.Pointer): System.Integer; cdecl; external PDFIUMA_DLL;

function FPDF_VIEWERREF_GetPrintPageRange(document: System.Pointer): System.Pointer; cdecl; external PDFIUMA_DLL;

function FPDF_VIEWERREF_GetDuplex(document: System.Pointer): FPDF_DUPLEXTYPE; cdecl; external PDFIUMA_DLL;

function FPDF_CountNamedDests(document: System.Pointer): System.LongWord; cdecl; external PDFIUMA_DLL;

function FPDF_GetNamedDestByName(document: System.Pointer; name: System.PAnsiChar): System.Pointer; cdecl; external PDFIUMA_DLL;

function FPDF_GetNamedDest(document: System.Pointer; index: System.Integer; buffer: System.Pointer; var buflen: System.LongWord): System.Pointer; cdecl; external PDFIUMA_DLL;

//DataAvail
const
  FSDK_IS_LINEARIZED = $01;
  FSDK_NOT_LINEARIZED = $00;
  FSDK_UNKNOW_LINEARIZED = -$1;

type
  PFX_FILEAVAIL = ^FX_FILEAVAIL;

  IsDataAvail = function(pThis: PFX_FILEAVAIL; offset: System.LongWord;
    size: System.LongWord): System.Boolean cdecl;

  FX_FILEAVAIL = record
    version: System.Integer;
    IsDataAvail: IsDataAvail;
  end;

  FPDF_AVAIL = System.Pointer;

  PFX_DOWNLOADHINTS = ^FX_DOWNLOADHINTS;

  AddSegment = procedure(pThis: PFX_DOWNLOADHINTS; offset: System.LongWord;
    size: System.LongWord); cdecl;

  FX_DOWNLOADHINTS = record
    version: System.Integer;
    AddSegment: AddSegment;
  end;

function FPDFAvail_Create(var file_avail: FX_FILEAVAIL; var file_: FPDF_FILEACCESS): System.Pointer cdecl; external PDFIUMA_DLL;

procedure FPDFAvail_Destroy(avail: System.Pointer); cdecl; external PDFIUMA_DLL;

function FPDFAvail_IsDocAvail(avail: System.Pointer; var hints: FX_DOWNLOADHINTS): System.Integer; cdecl; external PDFIUMA_DLL;

function FPDFAvail_GetDocument(avail: System.Pointer; password: FPDF_BYTESTRING): FPDF_DOCUMENT; cdecl; external PDFIUMA_DLL;

function FPDFAvail_GetFirstPageNum(doc: FPDF_DOCUMENT): System.Integer; cdecl; external PDFIUMA_DLL;

function FPDFAvail_IsPageAvail(avail: System.Pointer; page_index: System.Integer; var hints: FX_DOWNLOADHINTS): System.Integer; cdecl; external PDFIUMA_DLL;

function FPDFAvail_IsFormAvail(avail: System.Pointer; var hints: FX_DOWNLOADHINTS): System.Integer; cdecl; external PDFIUMA_DLL;

function FPDFAvail_IsLinearized(avail: System.Pointer): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

//Doc
const
  PDFACTION_UNSUPPORTED = $00;
  PDFACTION_GOTO = $01;
  PDFACTION_REMOTEGOTO = $02;
  PDFACTION_URI = $03;
  PDFACTION_LAUNCH = $04;

type
  FS_QUADPOINTSF = record
{$IFDEF DXEUP}
    private
{$ENDIF}
    x1: FS_FLOAT;
    y1: FS_FLOAT;
    x2: FS_FLOAT;
    y2: FS_FLOAT;
    x3: FS_FLOAT;
    y3: FS_FLOAT;
    x4: FS_FLOAT;
    y4: FS_FLOAT;
  end;

function FPDFBookmark_GetFirstChild(document: FPDF_DOCUMENT; bookmark: FPDF_BOOKMARK): FPDF_BOOKMARK; cdecl; external PDFIUMA_DLL;

function FPDFBookmark_GetNextSibling(document: FPDF_DOCUMENT; bookmark: FPDF_BOOKMARK): FPDF_BOOKMARK; cdecl; external PDFIUMA_DLL;

function FPDFBookmark_GetTitle(bookmark: FPDF_BOOKMARK; buffer: System.Pointer; buflen: System.LongWord): System.LongWord cdecl; external PDFIUMA_DLL;

function FPDFBookmark_Find(document: FPDF_DOCUMENT; title: FPDF_WIDESTRING): FPDF_BOOKMARK; cdecl; external PDFIUMA_DLL;

function FPDFBookmark_GetDest(document: FPDF_DOCUMENT; bookmark: FPDF_BOOKMARK): FPDF_DEST; cdecl; external PDFIUMA_DLL;

function FPDFBookmark_GetAction(bookmark: FPDF_BOOKMARK): FPDF_ACTION cdecl; external PDFIUMA_DLL;

function FPDFAction_GetType(action: FPDF_ACTION): System.LongWord cdecl; external PDFIUMA_DLL;

function FPDFAction_GetDest(document: FPDF_DOCUMENT; action: FPDF_ACTION): FPDF_DEST; cdecl; external PDFIUMA_DLL;

function FPDFAction_GetURIPath(document: FPDF_DOCUMENT; action: FPDF_ACTION; buffer: System.Pointer; buflen: System.LongWord): System.LongWord cdecl; external PDFIUMA_DLL;

function FPDFDest_GetPageIndex(document: FPDF_DOCUMENT; dest: FPDF_DEST): System.LongWord cdecl; external PDFIUMA_DLL;

function FPDFLink_GetLinkAtPoint(page: FPDF_PAGE; x: System.Double; y: System.Double): FPDF_LINK cdecl; external PDFIUMA_DLL;

function FPDFLink_GetDest(document: FPDF_DOCUMENT; link: FPDF_LINK): FPDF_DEST; cdecl; external PDFIUMA_DLL;

function FPDFLink_GetAction(link: FPDF_LINK): FPDF_ACTION cdecl; external PDFIUMA_DLL;

function FPDFLink_Enumerate(page: FPDF_PAGE; var startPos: System.Integer; var linkAnnot: FPDF_LINK): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function TFPDFLink_GetAnnotRect(linkAnnot: FPDF_LINK; var rect: FS_RECTF): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FPDFLink_CountQuadPoints(linkAnnot: FPDF_LINK): System.Integer; cdecl; external PDFIUMA_DLL;

function FPDFLink_GetQuadPoints(linkAnnot: FPDF_LINK; quadIndex: System.Integer; var quadPoints: FS_QUADPOINTSF): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FPDF_GetMetaText(doc: FPDF_DOCUMENT; tag: FPDF_BYTESTRING; buffer: System.Pointer; buflen: System.LongWord): System.LongWord cdecl; external PDFIUMA_DLL;

//Edit
type
  FX_BYTE = System.Byte;

  FX_WORD = System.Word;

  FX_DWORD = System.LongWord;

const
  FPDF_PAGEOBJ_TEXT = $01;
  FPDF_PAGEOBJ_PATH = $02;
  FPDF_PAGEOBJ_IMAGE = $03;
  FPDF_PAGEOBJ_SHADING = $04;
  FPDF_PAGEOBJ_FORM = $05;

function FPDF_CreateNewDocument: FPDF_DOCUMENT; cdecl; external PDFIUMA_DLL;

function FPDFPage_New(document: FPDF_DOCUMENT;
  page_index: System.Integer; width: System.Double;
  height: System.Double): FPDF_PAGE; cdecl; external PDFIUMA_DLL;

procedure FPDFPage_Delete(document: FPDF_DOCUMENT;
  page_index: System.Integer); cdecl; external PDFIUMA_DLL;

function FPDFPage_GetRotation(page: FPDF_PAGE): System.Integer; cdecl; external PDFIUMA_DLL;

procedure FPDFPage_SetRotation(page: FPDF_PAGE; rotate: System.Integer); cdecl; external PDFIUMA_DLL;

procedure FPDFPage_InsertObject(page: FPDF_PAGE;
  page_obj: FPDF_PAGEOBJECT); cdecl; external PDFIUMA_DLL;

function FPDFPage_CountObject(page: FPDF_PAGE): System.Integer; cdecl; external PDFIUMA_DLL;

function FPDFPage_GetObject(page: FPDF_PAGE;
  index: System.Integer): FPDF_PAGEOBJECT; cdecl; external PDFIUMA_DLL;

function FPDFPage_HasTransparency(page: FPDF_PAGE):
  FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FPDFPage_GenerateContent(page: FPDF_PAGE):
  FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FPDFPageObj_HasTransparency(pageObject: FPDF_PAGEOBJECT):
  FPDF_BOOL; cdecl; external PDFIUMA_DLL;

procedure FPDFPageObj_Transform(page_object: FPDF_PAGEOBJECT;
  a: System.Double; b: System.Double; c: System.Double; d: System.Double;
  e: System.Double; f: System.Double); cdecl; external PDFIUMA_DLL;

procedure FPDFPage_TransformAnnots(page: FPDF_PAGE;
  a: System.Double; b: System.Double; c: System.Double; d: System.Double;
  e: System.Double; f: System.Double); cdecl; external PDFIUMA_DLL;

function FPDFPageObj_NewImgeObj(document: FPDF_DOCUMENT):
  FPDF_PAGEOBJECT; cdecl; external PDFIUMA_DLL;



function FPDFImageObj_LoadJpegFile(pages: PFPDF_PAGE;
  nCount: System.Integer; image_object: FPDF_PAGEOBJECT;
  var fileAccess: FPDF_FILEACCESS): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FPDFImageObj_SetMatrix(image_object: FPDF_PAGEOBJECT;
  a: System.Double; b: System.Double; c: System.Double; d: System.Double;
  e: System.Double; f: System.Double): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FPDFImageObj_SetBitmap(pages: PFPDF_PAGE;
  nCount: System.Integer; image_object: FPDF_PAGEOBJECT;
  bitmap: FPDF_BITMAP): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

//Ext
const
  FPDF_UNSP_DOC_XFAFORM = $01;
  FPDF_UNSP_DOC_PORTABLECOLLECTION = $02;
  FPDF_UNSP_DOC_ATTACHMENT = $03;
  FPDF_UNSP_DOC_SECURITY = $04;
  FPDF_UNSP_DOC_SHAREDREVIEW = $05;
  FPDF_UNSP_DOC_SHAREDFORM_ACROBAT = $06;
  FPDF_UNSP_DOC_SHAREDFORM_FILESYSTEM = $07;
  FPDF_UNSP_DOC_SHAREDFORM_EMAIL = $08;
  FPDF_UNSP_ANNOT_3DANNOT = $0B;
  FPDF_UNSP_ANNOT_MOVIE = $0C;
  FPDF_UNSP_ANNOT_SOUND = $0D;
  FPDF_UNSP_ANNOT_SCREEN_MEDIA = $0E;
  FPDF_UNSP_ANNOT_SCREEN_RICHMEDIA = $0F;
  FPDF_UNSP_ANNOT_ATTACHMENT = $10;
  FPDF_UNSP_ANNOT_SIG = $11;

const
  PAGEMODE_UNKNOWN = -$1;
  PAGEMODE_USENONE = $00;
  PAGEMODE_USEOUTLINES = $01;
  PAGEMODE_USETHUMBS = $02;
  PAGEMODE_FULLSCREEN = $03;
  PAGEMODE_USEOC = $04;
  PAGEMODE_USEATTACHMENTS = $05;

type
  PUNSUPPORT_INFO = ^UNSUPPORT_INFO;

  FSDK_UnSupport_Handler = procedure(pThis: PUNSUPPORT_INFO; nType: System.Integer); cdecl;

  UNSUPPORT_INFO = record
    version: System.Integer;
    FSDK_UnSupport_Handler: FSDK_UnSupport_Handler;
  end;

function FSDK_SetUnSpObjProcessHandler(var unsp_info: UNSUPPORT_INFO): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FPDFDoc_GetPageMode(document: FPDF_DOCUMENT): System.Integer; cdecl; external PDFIUMA_DLL;

//Flatten
const
  FLATTEN_FAIL = $00;
  FLATTEN_SUCCESS = $01;
  FLATTEN_NOTINGTODO = $02;
  FLAT_NORMALDISPLAY = $00;
  FLAT_PRINT = $01;


function FPDFPage_Flatten(page: FPDF_PAGE; nFlag: System.Integer): System.Integer; cdecl; external 'pdfium.dll';

//FormFill
const
  FXCT_ARROW = $00;
  FXCT_NESW = $01;
  FXCT_NWSE = $02;
  FXCT_VBEAM = $03;
  FXCT_HBEAM = $04;
  FXCT_HAND = $05;

const
  FPDFDOC_AACTION_WC = $10;
  FPDFDOC_AACTION_WS = $11;
  FPDFDOC_AACTION_DS = $12;
  FPDFDOC_AACTION_WP = $13;
  FPDFDOC_AACTION_DP = $14;

const
  FPDF_FORMFIELD_UNKNOWN = $00;
  FPDF_FORMFIELD_PUSHBUTTON = $01;
  FPDF_FORMFIELD_CHECKBOX = $02;
  FPDF_FORMFIELD_RADIOBUTTON = $03;
  FPDF_FORMFIELD_COMBOBOX = $04;
  FPDF_FORMFIELD_LISTBOX = $05;
  FPDF_FORMFIELD_TEXTFIELD = $06;

const
  FPDFPAGE_AACTION_OPEN = $00;
  FPDFPAGE_AACTION_CLOSE = $01;


type
  FPDF_FORMHANDLE = System.Pointer;

  PIPDF_JsPlatform = ^IPDF_JSPLATFORM;

  app_alert = function(pThis: PIPDF_JsPlatform; Msg: FPDF_WIDESTRING; Title: FPDF_WIDESTRING;
    Type_: System.Integer; Icon: System.Integer): System.Integer; cdecl;

  app_beep = procedure(pThis: PIPDF_JsPlatform; nType: System.Integer); cdecl;

  app_response = function(pThis: PIPDF_JsPlatform; Question: FPDF_WIDESTRING; Title: FPDF_WIDESTRING;
    Default: FPDF_WIDESTRING; cLabel: FPDF_WIDESTRING;
    bPassword: FPDF_BOOL; response: System.Pointer;
    length: System.Integer): System.Integer; cdecl;

  Doc_getFilePath = function(pThis: PIPDF_JsPlatform;
    filePath: System.Pointer; length: System.Integer): System.Integer; cdecl;

  Doc_mail = procedure(pThis: PIPDF_JsPlatform; mailData: System.Pointer;
    length: System.Integer; bUI: FPDF_BOOL;
    To_: FPDF_WIDESTRING; Subject: FPDF_WIDESTRING;
    CC: FPDF_WIDESTRING; BCC: FPDF_WIDESTRING;
    Msg: FPDF_WIDESTRING); cdecl;

  Doc_print = procedure(pThis: PIPDF_JsPlatform; bUI: FPDF_BOOL;
    nStart: System.Integer; nEnd: System.Integer;
    bSilent: FPDF_BOOL; bShrinkToFit: FPDF_BOOL;
    bPrintAsImage: FPDF_BOOL; bReverse: FPDF_BOOL;
    bAnnotations: FPDF_BOOL); cdecl;

  Doc_submitForm = procedure(pThis: PIPDF_JsPlatform;
    formData: System.Pointer; length: System.Integer;
    URL: FPDF_WIDESTRING); cdecl;

  Doc_gotoPage = procedure(pThis: PIPDF_JsPlatform; nPageNum: System.Integer); cdecl;

  Field_browse = function(pThis: PIPDF_JsPlatform; filePath: System.Pointer;
    length: System.Integer): System.Integer; cdecl;

  IPDF_JSPLATFORM = record
    version: System.Integer;
    app_alert: app_alert;
    app_beep: app_beep;
    app_response: app_response;
    Doc_getFilePath: Doc_getFilePath;
    Doc_mail: Doc_mail;
    Doc_print: Doc_print;
    Doc_submitForm: Doc_submitForm;
    Doc_gotoPage: Doc_gotoPage;
    Field_browse: Field_browse;
    m_pFormfillinfo: System.Pointer;
  end;



type
  TimerCallback = procedure(idEvent: System.Integer);

  FPDF_SYSTEMTIME = record
{$IFDEF DXEUP}
    private
{$ENDIF}
    wYear: System.Word;
    wMonth: System.Word;
    wDayOfWeek: System.Word;
    wDay: System.Word;
    wHour: System.Word;
    wMinute: System.Word;
    wSecond: System.Word;
    wMilliseconds: System.Word;
  end;

  PFPDF_FORMFILLINFO = ^FPDF_FORMFILLINFO;

  FRelease = procedure(pThis: PFPDF_FORMFILLINFO); cdecl;

  FFI_Invalidate = procedure(pThis: PFPDF_FORMFILLINFO;
    page: FPDF_PAGE; left: System.Double; top: System.Double;
    right: System.Double; bottom: System.Double); cdecl;

  FFI_OutputSelectedRect = procedure(pThis: PFPDF_FORMFILLINFO;
    page: FPDF_PAGE; left: System.Double; top: System.Double;
    right: System.Double; bottom: System.Double); cdecl;

  FFI_SetCursor = procedure(pThis: PFPDF_FORMFILLINFO;
    nCursorType: System.Integer); cdecl;

  FFI_SetTimer = function(pThis: PFPDF_FORMFILLINFO; uElapse: System.Integer;
    lpTimerFunc: TimerCallback): System.Integer; cdecl;

  FFI_KillTimer = procedure(pThis: PFPDF_FORMFILLINFO;
    nTimerID: System.Integer); cdecl;

  FFI_GetLocalTime = function(pThis: PFPDF_FORMFILLINFO): FPDF_SYSTEMTIME
    ; cdecl;

  FFI_OnChange = procedure(pThis: PFPDF_FORMFILLINFO); cdecl;

  FFI_GetPage = function(pThis: PFPDF_FORMFILLINFO;
    document: FPDF_DOCUMENT; nPageIndex: System.Integer):
    FPDF_PAGE; cdecl;

  FFI_GetCurrentPage = function(pThis: PFPDF_FORMFILLINFO;
    document: FPDF_DOCUMENT): FPDF_PAGE; cdecl;

  FFI_GetRotation = function(pThis: PFPDF_FORMFILLINFO;
    page: FPDF_PAGE): System.Integer; cdecl;

  FFI_ExecuteNamedAction = procedure(pThis: PFPDF_FORMFILLINFO;
    namedAction: FPDF_BYTESTRING); cdecl;

  FFI_SetTextFieldFocus = procedure(pThis: PFPDF_FORMFILLINFO;
    value: FPDF_WIDESTRING; valueLen: FPDF_DWORD;
    is_focus: FPDF_BOOL); cdecl;

  FFI_DoURIAction = procedure(pThis: PFPDF_FORMFILLINFO;
    bsURI: FPDF_BYTESTRING); cdecl;

  FFI_DoGoToAction = procedure(pThis: PFPDF_FORMFILLINFO;
    nPageIndex: System.Integer; zoomMode: System.Integer;
    var fPosArray: System.Single; sizeofArray: System.Integer); cdecl;

  FPDF_FORMFILLINFO = record
    version: System.Integer;
    Release: FRelease;
    FFI_Invalidate: FFI_Invalidate;
    FFI_OutputSelectedRect: FFI_OutputSelectedRect;
    FFI_SetCursor: FFI_SetCursor;
    FFI_SetTimer: FFI_SetTimer;
    FFI_KillTimer: FFI_KillTimer;
    FFI_GetLocalTime: FFI_GetLocalTime;
    FFI_OnChange: FFI_OnChange;
    FFI_GetPage: FFI_GetPage;
    FFI_GetCurrentPage: FFI_GetCurrentPage;
    FFI_GetRotation: FFI_GetRotation;
    FFI_ExecuteNamedAction: FFI_ExecuteNamedAction;
    FFI_SetTextFieldFocus: FFI_SetTextFieldFocus;
    FFI_DoURIAction: FFI_DoURIAction;
    FFI_DoGoToAction: FFI_DoGoToAction;
    m_pJsPlatform: ^IPDF_JSPLATFORM;
  end;


function FPDFDOC_InitFormFillEnvironment(document: FPDF_DOCUMENT; var formInfo: FPDF_FORMFILLINFO): System.Pointer; cdecl; external PDFIUMA_DLL;

procedure FPDFDOC_ExitFormFillEnvironment(hHandle: System.Pointer); cdecl; external PDFIUMA_DLL;

procedure FORM_OnAfterLoadPage(page: FPDF_PAGE; hHandle: System.Pointer); cdecl; external PDFIUMA_DLL;

procedure FORM_OnBeforeClosePage(page: FPDF_PAGE; hHandle: System.Pointer); cdecl; external PDFIUMA_DLL;

procedure FORM_DoDocumentJSAction(hHandle: System.Pointer); cdecl; external PDFIUMA_DLL;

procedure FORM_DoDocumentOpenAction(hHandle: System.Pointer); cdecl; external PDFIUMA_DLL;


procedure FORM_DoDocumentAAction(hHandle: System.Pointer; aaType: System.Integer); cdecl; external PDFIUMA_DLL;

procedure FORM_DoPageAAction(page: FPDF_PAGE; hHandle: System.Pointer; aaType: System.Integer); cdecl; external PDFIUMA_DLL;

function FORM_OnMouseMove(hHandle: System.Pointer; page: FPDF_PAGE; modifier: System.Integer;
  page_x: System.Double; page_y: System.Double): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FORM_OnLButtonDown(hHandle: System.Pointer; page: FPDF_PAGE; modifier: System.Integer;
  page_x: System.Double; page_y: System.Double): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FORM_OnLButtonUp(hHandle: System.Pointer; page: FPDF_PAGE; modifier: System.Integer;
  page_x: System.Double; page_y: System.Double): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FORM_OnKeyDown(hHandle: System.Pointer; page: FPDF_PAGE; nKeyCode: System.Integer;
  modifier: System.Integer): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FORM_OnKeyUp(hHandle: System.Pointer; page: FPDF_PAGE; nKeyCode: System.Integer;
  modifier: System.Integer): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FORM_OnChar(hHandle: System.Pointer; page: FPDF_PAGE; nChar: System.Integer;
  modifier: System.Integer): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FORM_ForceToKillFocus(hHandle: System.Pointer): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FPDPage_HasFormFieldAtPoint(hHandle: System.Pointer; page: FPDF_PAGE;
  page_x: System.Double; page_y: System.Double): System.Integer; cdecl; external PDFIUMA_DLL;

procedure FPDF_SetFormFieldHighlightColor(hHandle: System.Pointer;
  fieldType: System.Integer; color: System.LongWord); cdecl; external PDFIUMA_DLL;

procedure FPDF_SetFormFieldHighlightAlpha(hHandle: System.Pointer; alpha: System.Byte); cdecl; external PDFIUMA_DLL;

procedure FPDF_RemoveFormFieldHighlight(hHandle: System.Pointer); cdecl; external PDFIUMA_DLL;

procedure FPDF_FFLDraw(hHandle: System.Pointer; bitmap: FPDF_BITMAP; page: FPDF_PAGE;
  start_x: System.Integer; start_y: System.Integer; size_x: System.Integer; size_y: System.Integer;
  rotate: System.Integer; flags: System.Integer); cdecl; external PDFIUMA_DLL;

  //Ppo
function FPDF_ImportPages(dest_doc: FPDF_DOCUMENT; src_doc: FPDF_DOCUMENT; pagerange: FPDF_BYTESTRING; index: System.Integer): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FPDF_CopyViewerPreferences(dest_doc: FPDF_DOCUMENT; src_doc: FPDF_DOCUMENT): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

//Progressive
const
  FPDF_RENDER_READER = $00;
  FPDF_RENDER_TOBECOUNTINUED = $01;
  FPDF_RENDER_DONE = $02;
  FPDF_RENDER_FAILED = $03;

type

  PIFSDK_PAUSE = ^IFSDK_PAUSE;

  NeedToPauseNow = function(pThis: PIFSDK_PAUSE): FPDF_BOOL cdecl;

  IFSDK_PAUSE = record
{$IFDEF DXEUP}
    private
{$ENDIF}
    version: System.Integer;
    NeedToPauseNow: NeedToPauseNow;
    user: System.Pointer;
  end;

function FPDF_RenderPageBitmap_Start(bitmap: FPDF_BITMAP; page: FPDF_PAGE; start_x: System.Integer; start_y: System.Integer; size_x: System.Integer;
  size_y: System.Integer; rotate: System.Integer; flags: System.Integer; var pause: IFSDK_PAUSE): System.Integer; cdecl; external PDFIUMA_DLL;

function FPDF_RenderPage_Continue(page: FPDF_PAGE; var pause: IFSDK_PAUSE): System.Integer; cdecl; external PDFIUMA_DLL;

procedure FPDF_RenderPage_Close(page: FPDF_PAGE); cdecl; external PDFIUMA_DLL;

//save
const
  FPDF_INCREMENTAL = $01;
  FPDF_NO_INCREMENTAL = $02;
  FPDF_REMOVE_SECURITY = $03;

type
  PFPDF_FILEWRITE = ^FPDF_FILEWRITE;

  WriteBlock = function(pThis: PFPDF_FILEWRITE; pData: System.Pointer;
    size: System.LongWord): System.Integer cdecl;

  FPDF_FILEWRITE = record
{$IFDEF DXEUP}
    private
{$ENDIF}
    version: System.Integer;
    WriteBlock: WriteBlock;
  end;

function FPDF_SaveAsCopy(document: FPDF_DOCUMENT; var pFileWrite: FPDF_FILEWRITE; flags: FPDF_DWORD): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FPDF_SaveWithVersion(document: FPDF_DOCUMENT; var pFileWrite: FPDF_FILEWRITE; flags: FPDF_DWORD; fileVersion: System.Integer): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

//SearchEx
function FPDFText_GetCharIndexFromTextIndex(text_page: FPDF_TEXTPAGE;
  nTextIndex: System.Integer): System.Integer; cdecl; external PDFIUMA_DLL;

//SysFontInfo
const
  FXFONT_ANSI_CHARSET = $00;
  FXFONT_DEFAULT_CHARSET = $01;
  FXFONT_SYMBOL_CHARSET = $02;
  FXFONT_SHIFTJIS_CHARSET = $80;
  FXFONT_HANGEUL_CHARSET = $81;
  FXFONT_GB2312_CHARSET = $86;
  FXFONT_CHINESEBIG5_CHARSET = $88;
  FXFONT_FF_FIXEDPITCH = $01;
  FXFONT_FF_ROMAN = $10;
  FXFONT_FF_SCRIPT = $40;
  FXFONT_FW_NORMAL = $0190;
  FXFONT_FW_BOLD = $02BC;

type
  PFPDF_SYSFONTINFO = ^FPDF_SYSFONTINFO;

  Release = procedure(pThis: PFPDF_SYSFONTINFO) cdecl;

  EnumFonts = procedure(pThis: PFPDF_SYSFONTINFO; pMapper: System.Pointer) cdecl;

  MapFont = function(pThis: PFPDF_SYSFONTINFO; weight: System.Integer; bItalic: System.Integer; charset: System.Integer; pitch_family: System.Integer; face: System.PAnsiChar; var bExact: System.Integer): System.Pointer cdecl;

  GetFont = function(pThis: PFPDF_SYSFONTINFO; face: System.PAnsiChar): System.Pointer cdecl;

  GetFontData = function(pThis: PFPDF_SYSFONTINFO; hFont: System.Pointer; table: System.LongWord; buffer: System.PByte; buf_size: System.LongWord): System.LongWord cdecl;

  GetFaceName = function(pThis: PFPDF_SYSFONTINFO; hFont: System.Pointer; buffer: System.PAnsiChar; buf_size: System.LongWord): System.LongWord cdecl;

  GetFontCharset = function(pThis: PFPDF_SYSFONTINFO; hFont: System.Pointer): System.Integer cdecl;

  DeleteFont = procedure(pThis: PFPDF_SYSFONTINFO; hFont: System.Pointer) cdecl;

  FPDF_SYSFONTINFO = record
{$IFDEF DXEUP}
    private
{$ENDIF}
    version: System.Integer;
    Release: Release;
    EnumFonts: EnumFonts;
    MapFont: MapFont;
    GetFont: GetFont;
    GetFontData: GetFontData;
    GetFaceName: GetFaceName;
    GetFontCharset: GetFontCharset;
    DeleteFont: DeleteFont;
  end;

procedure FPDF_AddInstalledFont(mapper: System.Pointer; face: System.PAnsiChar; charset: System.Integer) cdecl; external PDFIUMA_DLL;

procedure FPDF_SetSystemFontInfo(var pFontInfo: FPDF_SYSFONTINFO) cdecl; external PDFIUMA_DLL;

function FPDF_GetDefaultSystemFontInfo: FPDF_SYSFONTINFO cdecl; external PDFIUMA_DLL;

//Text
const
  FPDF_MATCHCASE = $01;
  FPDF_MATCHWHOLEWORD = $02;


function FPDFText_LoadPage(page: FPDF_PAGE): FPDF_TEXTPAGE; cdecl; external PDFIUMA_DLL;

procedure FPDFText_ClosePage(text_page: FPDF_TEXTPAGE); cdecl; external PDFIUMA_DLL;

function FPDFText_CountChars(text_page: FPDF_TEXTPAGE): System.Integer; cdecl; external PDFIUMA_DLL;

function FPDFText_GetUnicode(text_page: FPDF_TEXTPAGE; index: System.Integer): System.LongWord; cdecl; external PDFIUMA_DLL;

function FPDFText_GetFontSize(text_page: FPDF_TEXTPAGE; index: System.Integer): System.Double; cdecl; external PDFIUMA_DLL;

procedure FPDFText_GetCharBox(text_page: FPDF_TEXTPAGE; index: System.Integer; var left: System.Double;
  var right: System.Double; var bottom: System.Double; var top: System.Double); cdecl; external PDFIUMA_DLL;

function FPDFText_GetCharIndexAtPos(text_page: FPDF_TEXTPAGE; x: System.Double; y: System.Double; xTorelance: System.Double;
  yTolerance: System.Double): System.Integer; cdecl; external PDFIUMA_DLL;


function FPDFText_GetCharcode(text_page: FPDF_TEXTPAGE; index: System.Integer): System.LongWord; cdecl; external PDFIUMA_DLL;

function FPDFText_GetText(text_page: FPDF_TEXTPAGE; start_index: System.Integer; count: System.Integer; result: System.PWord): System.Integer; cdecl; external PDFIUMA_DLL;

function FPDFText_CountRects(text_page: FPDF_TEXTPAGE; start_index: System.Integer; count: System.Integer): System.Integer; cdecl; external PDFIUMA_DLL;

procedure FPDFText_GetRect(text_page: FPDF_TEXTPAGE; rect_index: System.Integer; var left: System.Double;
  var top: System.Double; var right: System.Double; var bottom: System.Double); cdecl; external PDFIUMA_DLL;

function FPDFText_GetBoundedText(text_page: FPDF_TEXTPAGE; left: System.Double; top: System.Double; right: System.Double;
  bottom: System.Double; buffer: System.PWord; buflen: System.Integer): System.Integer; cdecl; external PDFIUMA_DLL;

function FPDFText_FindStart(text_page: FPDF_TEXTPAGE; findwhat: FPDF_WIDESTRING; flags: System.LongWord;
  start_index: System.Integer): FPDF_SCHHANDLE; cdecl; external PDFIUMA_DLL;

function FPDFText_FindNext(handle: FPDF_SCHHANDLE): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FPDFText_FindPrev(handle: FPDF_SCHHANDLE): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FPDFText_GetSchResultIndex(handle: FPDF_SCHHANDLE): System.Integer; cdecl; external PDFIUMA_DLL;

function FPDFText_GetSchCount(handle: FPDF_SCHHANDLE): System.Integer; cdecl; external PDFIUMA_DLL;

procedure FPDFText_FindClose(handle: FPDF_SCHHANDLE); cdecl; external PDFIUMA_DLL;

function FPDFLink_LoadWebLinks(text_page: FPDF_TEXTPAGE): FPDF_PAGELINK; cdecl; external PDFIUMA_DLL;

function FPDFLink_CountWebLinks(link_page: FPDF_PAGELINK): System.Integer; cdecl; external PDFIUMA_DLL;

function FPDFLink_GetURL(link_page: FPDF_PAGELINK; link_index: System.Integer; var buffer: System.Word;
  buflen: System.Integer): System.Integer; cdecl; external PDFIUMA_DLL;

function FPDFLink_CountRects(link_page: FPDF_PAGELINK; link_index: System.Integer): System.Integer; cdecl; external PDFIUMA_DLL;

procedure FPDFLink_GetRect(link_page: FPDF_PAGELINK; link_index: System.Integer; rect_index: System.Integer;
  var left: System.Double; var top: System.Double; var right: System.Double; var bottom: System.Double); cdecl; external PDFIUMA_DLL;

procedure FPDFLink_CloseWebLinks(link_page: FPDF_PAGELINK); cdecl; external PDFIUMA_DLL;

//TransformPage
type
  FPDF_PAGEARCSAVER = System.Pointer;

  FPDF_PAGEARCLOADER = System.Pointer;

procedure FPDFPage_SetMediaBox(page: FPDF_PAGE; left: System.Single; bottom: System.Single;
  right: System.Single; top: System.Single); cdecl; external PDFIUMA_DLL;

procedure FPDFPage_SetCropBox(page: FPDF_PAGE; left: System.Single;
  bottom: System.Single; right: System.Single; top: System.Single); cdecl; external PDFIUMA_DLL;

function FPDFPage_GetMediaBox(page: FPDF_PAGE; var left: System.Single; var bottom: System.Single;
  var right: System.Single; var top: System.Single): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FPDFPage_GetCropBox(page: FPDF_PAGE; var left: System.Single; var bottom: System.Single;
  var right: System.Single; var top: System.Single): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

function FPDFPage_TransFormWithClip(page: FPDF_PAGE; var matrix: FS_MATRIX;
  var clipRect: FS_RECTF): FPDF_BOOL; cdecl; external PDFIUMA_DLL;

procedure FPDFPageObj_TransformClipPath(page_object: FPDF_PAGEOBJECT; a: System.Double;
  b: System.Double; c: System.Double; d: System.Double; e: System.Double; f: System.Double); cdecl; external PDFIUMA_DLL;

function FPDF_CreateClipPath(left: System.Single; bottom: System.Single; right: System.Single;
  top: System.Single): FPDF_CLIPPATH; cdecl; external PDFIUMA_DLL;

procedure FPDF_DestroyClipPath(clipPath: FPDF_CLIPPATH); cdecl; external PDFIUMA_DLL;

procedure FPDFPage_InsertClipPath(page: FPDF_PAGE; clipPath: FPDF_CLIPPATH); cdecl; external PDFIUMA_DLL;

implementation

end.

