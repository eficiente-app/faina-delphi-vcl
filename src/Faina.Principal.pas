// Eduardo - 07/11/2020
unit Faina.Principal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs, Vcl.ExtCtrls;

type
  TPrincipal = class(TForm)
    pnlTop: TPanel;
    pnlMenu: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Principal: TPrincipal;

implementation

{$R *.dfm}

end.
