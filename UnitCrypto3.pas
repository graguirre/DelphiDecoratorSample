unit UnitCrypto3;

interface

uses
  uTPLb_AES,
  uTPLb_BlowFish,
  uTPLb_StreamUtils,
  uTPLb_Codec,
  InterfaceCrypto;

type
  TCrypto3BF = class(TInterfacedObject, ICrypto)
    strict private
      FCodec: TCodec;
    public
      constructor Create;
      destructor Destroy; override;
      function Crypt(pString: String): String;
      function Decrypt(pString: String): String;
  end;

  TCrypto3AES = class(TInterfacedObject, ICrypto)
    strict private
      FCodec: TCodec;
    public
      constructor Create;
      destructor Destroy; override;
      function Crypt(pString: String): String;
      function Decrypt(pString: String): String;

  end;

implementation

uses
  Classes, // TEncoding
  SysUtils,
  Spring.Container,
  uTPLb_CryptographicLibrary,
  uTPLb_Constants
  ;
{ TCrypto3BF }

constructor TCrypto3BF.Create;
var
  FCryptoLib: TCryptographicLibrary;
begin
  FCodec := TCodec.Create(nil);
  FCryptoLib := TCryptographicLibrary.Create(nil);

  FCodec.CryptoLibrary := FCryptoLib;
  FCodec.StreamCipherId := uTPLb_Constants.BlockCipher_ProgId;
  FCodec.BlockCipherId  := uTPLb_Constants.Blowfish_ProgId;
  FCodec.ChainModeId    := uTPLb_Constants.CBC_ProgId;
  FCodec.Password := '1234567890';
end;

function TCrypto3BF.Crypt(pString: String): String;
begin
  FCodec.EncryptAnsiString(pString, Result);
//  FCodec.EncryptString(pString, Result, TEncoding.ANSI);

end;

function TCrypto3BF.Decrypt(pString: String): String;
begin
  Result := pString;
end;

destructor TCrypto3BF.Destroy;
begin
  FCodec.Free;
  FCryptoLib.Free;
  inherited;
end;

{ TCrypto3AES }

constructor TCrypto3AES.Create;
var
  FCryptoLib: TCryptographicLibrary;
begin
  FCodec := TCodec.Create(nil);
  FCryptoLib := TCryptographicLibrary.Create(nil);

  FCodec.CryptoLibrary := FCryptoLib;
  FCodec.StreamCipherId := uTPLb_Constants.BlockCipher_ProgId;
  FCodec.BlockCipherId  := 'native.AES-256';
  FCodec.ChainModeId    := uTPLb_Constants.ECB_ProgId;
  FCodec.Password := '1234567890';
end;

function TCrypto3AES.Crypt(pString: String): String;
begin
  FCodec.EncryptAnsiString(pString, Result);
//  FCodec.EncryptString(pString, Result, TEncoding.ANSI);
end;

function TCrypto3AES.Decrypt(pString: String): String;
begin
  FCodec.DecryptAnsiString(Result, pString);
end;

destructor TCrypto3AES.Destroy;
begin
  FCodec.Free;
  FCryptoLib.Free;
  inherited;
end;

initialization
  GlobalContainer.RegisterType<TCrypto3AES>.Implements<ICrypto>('Crypto3AES');
  GlobalContainer.RegisterType<TCrypto3BF>.Implements<ICrypto>('Crypto3BF');
  GlobalContainer.Build;
end.
