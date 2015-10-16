unit UnitIODecorator;

interface

uses
  InterfaceCrypto,
  InterfaceIO
  ;

type

TIODecorator = class(TInterfacedObject, IIO) // IO decorator
    procedure WriteString(pValue : String); virtual; abstract;
    function ReadString: String; virtual; abstract;
end;

TIOCrypto = class(TIODecorator)
  private
    FCrypto : ICrypto;
    FIO : IIO;
  public
    constructor Create(TObject: IIO);
    destructor Destroy; override;
    procedure WriteString(pValue : String); override;
    function ReadString: String; override;
end;

implementation

uses
  Spring.Container,
  Spring.Services
  ;

{ TIOCrypto }

constructor TIOCrypto.Create(TObject: IIO);
begin
  FCrypto := ServiceLocator.GetService<ICrypto>('CryptoAES');
  FIO := TObject;
end;

destructor TIOCrypto.Destroy;
begin

  inherited;
end;

function TIOCrypto.ReadString: String;
begin
  Result := FCrypto.Decrypt(FIO.ReadString);
end;

procedure TIOCrypto.WriteString(pValue: String);
begin
  FIO.WriteString(FCrypto.Crypt(pValue));
end;

end.
