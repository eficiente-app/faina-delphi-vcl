unit Faina.Theme.Utils;

interface

uses
  System.SysUtils,
  System.UITypes,
  Vcl.Graphics;

  function ConvertHtmlHexToTColor(Color: String): TColor;

implementation

function ConvertHtmlHexToTColor(Color: String): TColor;
begin
  Result := clNone;
  // CheckHexForHash
  if Color[1] = '#' then
    Color := Color.Replace('#', '');

  { Remember that TColor is bgr not rgb: so you need to switch then around }
  if Length(color) = 6 then
    Result := StrToInt('$00' + copy(color,5,2) + copy(color,3,2) + copy(color,1,2));
end;

end.
