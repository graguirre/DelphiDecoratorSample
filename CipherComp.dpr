program CipherComp;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,  //  Exception
  Spring.Services,  //  ServiceLocator
  InterfaceCrypto,
  UnitCrypto,       // register
  UnitCrypto3       // register
  ;
const
  SecretWord : String = 'a secret word';
  SymmetricPassword : String = '1234567890';
var
  FEncAES : ICrypto;
  FEnc3AES : ICrypto;
begin
  FEncAES := ServiceLocator.GetService<ICrypto>('CryptoAES');
  FEnc3AES := ServiceLocator.GetService<ICrypto>('Crypto3AES');
  try
    writeln(SecretWord + ' ' + FEncAES.Decrypt( FEncAES.Crypt(SecretWord) ));
    writeln(SecretWord + ' ' + FEnc3AES.Decrypt( FEnc3AES.Crypt(SecretWord) ));
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
