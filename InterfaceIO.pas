unit InterfaceIO;

interface

type
  IIO = interface
  ['{7A33F29E-FB56-42D2-BF7A-AB772311E3E2}']
    procedure WriteString(pValue : String);
    function ReadString: String;
  end;

implementation

end.
