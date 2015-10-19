program CipherIO;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,  //  Exception
  Spring.Services,  //  ServiceLocator
  InterfaceIO,
  UnitIO,           // register
  UnitIODecorator,
  UnitCrypto        // register
  ;
const
  SecretWord : String = 'a secret word';
var
  FIO : IIO;
begin
  try
    FIO := ServiceLocator.GetService<IIO>('IOFile');

    FIO.WriteString(SecretWord);
    Writeln(FIO.ReadString);
    Writeln('Check data.txt file in a file editor. Testing IO interface. Press any key to continue.');
    readln;

    FIO := ServiceLocator.GetService<IIO>('IOCrypto');   // decorate IO

    FIO.WriteString(SecretWord);
    Writeln(FIO.ReadString); // check data.txt file
    Writeln('Check data.txt file in a file editor. Testing decorated IO interface.')


  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
