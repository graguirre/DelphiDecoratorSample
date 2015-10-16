unit UnitIO;

interface
uses
  Classes,  //  TFileStream
  SysUtils,
  InterfaceIO
  ;

type

TIOFile = class(TInterfacedObject, IIO) // read/write string from/into a file
  const
    FileName : String = 'data.txt';
  private
    FileDescriptor : TextFile;
  public
    constructor Create;
    destructor Destroy; override;
    procedure WriteString(pValue : String);
    function ReadString: String;
end;

// implement your favorite IO source.
//  TUnitIOWS = class(TInterfacedObject, IIO) // not implemented, alternative webservice IO source
//  TUnitIODB = class(TInterfacedObject, IIO) // not implemented, alternative database IO source

implementation
uses
  Spring.Container,
  Spring.Services
  ;

{ TUnitIOFile }
constructor TIOFile.Create;
begin
  AssignFile(FileDescriptor, FileName);
end;

destructor TIOFile.Destroy;
begin
  inherited;
end;

procedure TIOFile.WriteString(pValue: String);
begin
  ReWrite(FileDescriptor);
  WriteLn(FileDescriptor, pValue);
  CloseFile(FileDescriptor);
end;

function TIOFile.ReadString: String;
var
  readValue : String;
begin
  Reset(FileDescriptor);
  Read(FileDescriptor, readValue);
  CloseFile(FileDescriptor);
  Result := readValue;
end;

initialization
  GlobalContainer.RegisterType<TIOFile>.Implements<IIO>('IOFile');
//  GlobalContainer.RegisterType<TIOWS>.Implements<IUnitIO>('IOWs');
//  GlobalContainer.RegisterType<TIODB>.Implements<IUnitIO>('IODB');
  GlobalContainer.Build;
end.
