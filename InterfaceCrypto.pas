unit InterfaceCrypto;

interface

type

ICrypto = interface
['{90A603A7-DE80-40B5-AD4A-DA8AEBC03966}']
  function Crypt(pString: String): String;
  function Decrypt(pString: String): String;
end;

implementation

end.
