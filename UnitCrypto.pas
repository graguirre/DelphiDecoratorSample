unit UnitCrypto;

interface
uses
  LbClass,   // TLbBlowfish, TLbRijndael
  InterfaceCrypto;

type
  TCryptoBF = class(TInterfacedObject, ICrypto)
    strict private
      FBF : TLbBlowfish;
    public
      constructor Create;
      destructor Destroy; override;
      function Crypt(pString: String): String;
      function Decrypt(pString: String): String;
  end;

  TCryptoAES = class(TInterfacedObject, ICrypto)
    strict private
      FAES : TLbRijndael;
    public
      constructor Create;
      destructor Destroy; override;
      function Crypt(pString: String): String;
      function Decrypt(pString: String): String;
  end;

implementation

uses
  Spring.Container,
  SysUtils, // FreeAndNil
  LbCipher  // TKeyXXX
  ;
{ TModuloCriptoBF }

function TCryptoBF.Crypt(pString: String): String;
begin
  Result := FBF.EncryptString(pString);
end;

constructor TCryptoBF.Create;
var
  FKey : TKey128;
begin
  FKey[0] := 12;
  FKey[1] := 201;
  FKey[3] := 103;
  FKey[15] := 1;
  FBF := TLbBlowfish.Create(nil);
  FBF.SetKey(FKey);
end;

function TCryptoBF.Decrypt(pString: String): String;
begin
  Result := FBF.DecryptString(pString);
end;

destructor TCryptoBF.Destroy;
begin
  FreeAndNil(FBF);
  inherited;
end;

{ TModuloCriptoAES }

function TCryptoAES.Crypt(pString: String): String;
begin
  Result := FAES.EncryptString(pString);
end;

constructor TCryptoAES.Create;
begin
  FAES := TLbRijndael.Create(nil);
  FAES.CipherMode := cmECB;   // cmECB (default), cmCBC
  FAES.KeySize := ks256;      // ks128, ks192
  FAES.SetKey('1234567890');  // set the password here
end;

function TCryptoAES.Decrypt(pString: String): String;
begin
  Result := FAES.DecryptString(pString);
end;

destructor TCryptoAES.Destroy;
begin
  FreeAndNil(FAES);
  inherited;
end;

initialization
  GlobalContainer.RegisterType<TCryptoAES>.Implements<ICrypto>('CryptoAES');
  GlobalContainer.RegisterType<TCryptoBF>.Implements<ICrypto>('CryptoBF');
  GlobalContainer.Build;
end.
