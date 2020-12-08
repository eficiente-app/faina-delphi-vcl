// Eduardo - 05/12/2020
unit Faina.Pasta.vw;

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
  Vcl.Dialogs,
  Data.DB,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Faina.Pasta.cl;

type
  TPasta = class(TForm)
    DBGrid1: TDBGrid;
    srcPasta: TDataSource;
    Panel1: TPanel;
    btnRead: TButton;
    btnWrite: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnReadClick(Sender: TObject);
    procedure btnWriteClick(Sender: TObject);
  private
    DM: TDMPasta;
  public
    class procedure New;
  end;

implementation

{$R *.dfm}

{ TPasta }

class procedure TPasta.New;
begin
  with TPasta.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TPasta.FormCreate(Sender: TObject);
begin
  DM := TDMPasta.Create(Self);
  srcPasta.DataSet := DM.tblPasta;
end;

procedure TPasta.btnReadClick(Sender: TObject);
begin
  DM.Pasta.Query.Add('id', 1);
  DM.Pasta.Table.Read;
end;

procedure TPasta.btnWriteClick(Sender: TObject);
begin
  DM.Pasta.Table.Write;
end;

end.
