// unicode avoid implicit string cast warning
{$ifdef UNICODE}
{$WARN IMPLICIT_STRING_CAST OFF}
{$endif UNICODE}

// Delphi and FPC versions

// Freepascal
{$ifdef FPC}
  {$MODE DELPHI}
  {$define D7UP}
{$endif FPC}

// Delphi 5
{$ifdef VER130}
  {$define D5UP}
{$endif}

//Delphi 6
{$ifdef VER140}
  {$define D5UP}
{$endif}

//Delphi 7
{$ifdef VER150}
  {$define D7UP}
{$endif}

//Delphi 8
{$ifdef VER160}
  {$define D7UP}
{$endif}

// Delphi 2005 / 9
{$ifdef VER170}
  {$define D7UP}
{$endif}

// Delphi 2006 / 10
{$ifdef VER180}
  {$define D7UP}
  // D10 publishes OnMouseEnter / OnMouseLeave
  {$define D10UP}
{$endif}

// Delphi 2007 Rad studio / 11?
{$ifdef VER185}
  {$define D7UP}
  {$define D10UP}
{$endif}

// Delphi 2007 - NET / 11?
{$ifdef VER190}
  {$define D7UP}
  {$define D10UP}
{$endif}

// Delphi 2009 / 12
// first UNICODE version, so then directive UNICODE is defined, no need for directive D12UP
{$ifdef VER200}
  {$define D7UP}
  {$define D10UP}
{$endif}

// Delphi 2010 
{$ifdef VER210}
  {$define D7UP}
  {$define D10UP}
{$endif}

// Delphi XE 
{$ifdef VER220}
  {$define D7UP}
  {$define D10UP}
  {$define DXEUP}
{$endif}

// Delphi XE2 
{$ifdef VER230}
  {$define D7UP}
  {$define D10UP}
  {$define DXEUP}
  {$define DXE2UP}
{$endif}

// Delphi XE3 
{$ifdef VER240}
  {$define D7UP}
  {$define D10UP}
  {$define DXEUP}
  {$define DXE2UP}
  {$define DXE3UP}
{$endif}

// Delphi XE4 
{$ifdef VER250}
  {$define D7UP}
  {$define D10UP}
  {$define DXEUP}
  {$define DXE2UP}
  {$define DXE3UP}
  {$define DXE4UP}
{$endif}

// Delphi XE5 
{$ifdef VER260}
  {$define D7UP}
  {$define D10UP}
  {$define DXEUP}
  {$define DXE2UP}
  {$define DXE3UP}
  {$define DXE4UP}
  {$define DXE5UP}
{$endif}

// Delphi XE6 
{$ifdef VER270}
  {$define D7UP}
  {$define D10UP}
  {$define DXEUP}
  {$define DXE2UP}
  {$define DXE3UP}
  {$define DXE4UP}
  {$define DXE5UP}
  {$define DXE6UP}
{$endif}

// Delphi XE7 
{$ifdef VER280}
  {$define D7UP}
  {$define D10UP}
  {$define DXEUP}
  {$define DXE2UP}
  {$define DXE3UP}
  {$define DXE4UP}
  {$define DXE5UP}
  {$define DXE6UP}
  {$define DXE7UP}
{$endif}

// Delphi XE10 
{$ifdef VER300}
  {$define D7UP}
  {$define D10UP}
  {$define DXEUP}
  {$define DXE2UP}
  {$define DXE3UP}
  {$define DXE4UP}
  {$define DXE5UP}
  {$define DXE6UP}
  {$define DXE7UP}
{$endif}

// Delphi XE10.1 
{$ifdef VER310}
  {$define D7UP}
  {$define D10UP}
  {$define DXEUP}
  {$define DXE2UP}
  {$define DXE3UP}
  {$define DXE4UP}
  {$define DXE5UP}
  {$define DXE6UP}
  {$define DXE7UP}
  {$define DXE101UP}
{$endif}

// Delphi XE10.2
{$ifdef VER320}
  {$define D7UP}
  {$define D10UP}
  {$define DXEUP}
  {$define DXE2UP}
  {$define DXE3UP}
  {$define DXE4UP}
  {$define DXE5UP}
  {$define DXE6UP}
  {$define DXE7UP}
  {$define DXE101UP}
  {$define DXE102UP}
{$endif}




