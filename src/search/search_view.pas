// Eduardo - 08/12/2020
unit search_view;

interface

uses
  Winapi.Messages,
  Winapi.Windows,
  System.Classes,
  System.SysUtils,
  System.Variants,
  Data.DB,
  Vcl.Controls,
  Vcl.DBCtrls,
  Vcl.DBGrids,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Grids,
  Vcl.Mask,
  Vcl.StdCtrls,
  FireDAC.Comp.Client,
  base_form_view,
  Extend.DBGrids;

type
  TSearchView = class(TBaseFormView)
    pnlSearch: TPanel;
    dbgrid: TDBGrid;
    src: TDataSource;
    cbxField: TComboBox;
    lbField: TLabel;
    btnSearch: TButton;
    pnlTop: TPanel;
    edtValue: TEdit;
    lbValue: TLabel;
    btnConfirm: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgridDblClick(Sender: TObject);
  private
    FOrigin: TField;
    FRecipient: TField;
  public
    class function New(AParent: TForm; Origin, Recipient: TField): TSearchView;
  end;

implementation

uses
  System.StrUtils;

{$R *.dfm}

{ TPesquisa }

class function TSearchView.New(AParent: TForm; Origin, Recipient: TField): TSearchView;
begin
  Result := TSearchView.Create(AParent);
  with Result do
  begin
    FOrigin := Origin;
    FRecipient := Recipient;
    src.DataSet := Origin.DataSet;
    ShowModal(AParent);
  end;
end;

procedure TSearchView.btnConfirmClick(Sender: TObject);
begin
  FRecipient.Value := FOrigin.Value;
  Close;
end;

procedure TSearchView.btnSearchClick(Sender: TObject);
var
  sSearch: String;
  Field: TField;
begin
  if Trim(edtValue.Text).IsEmpty then
    Exit;

  Field := TField(cbxField.Items.Objects[cbxField.ItemIndex]);

  sSearch := Field.FieldName;

  if Field.InheritsFrom(TNumericField) or Field.InheritsFrom(TDateField) then
    sSearch := sSearch +' = '+ Trim(edtValue.Text)
  else
    sSearch := sSearch +' LIKE '+ QuotedStr('%'+ ReplaceStr(Trim(edtValue.Text), ' ', '%') +'%');

  src.DataSet.Filtered := False;
  src.DataSet.Filter   := sSearch;
  src.DataSet.Filtered := True;
end;

procedure TSearchView.dbgridDblClick(Sender: TObject);
begin
  btnConfirmClick(btnConfirm);
end;

procedure TSearchView.FormCreate(Sender: TObject);
begin
  CloseEsc := True;
end;

procedure TSearchView.FormShow(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to Pred(dbgrid.Columns.Count) do
  begin
    dbgrid.Columns[I].Visible := dbgrid.Columns[I].FieldName <> dbgrid.Columns[I].Field.DisplayLabel;
    if dbgrid.Columns[I].Visible then
    begin
      dbgrid.Columns[I].Title.Alignment := dbgrid.Columns[I].Field.Alignment;
      cbxField.AddItem(dbgrid.Columns[I].Field.DisplayLabel, dbgrid.Columns[I].Field);
    end;
  end;
  cbxField.ItemIndex := 0;
  dbgrid.ResizeColumn([]);
end;

end.
