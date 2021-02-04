// Eduardo - 03/02/2021
unit project_type_list;

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
  Vcl.Buttons,
  Vcl.Menus,
  base_form_view,
  project_type_controller,
  project_type_view,
  Extend.DBGrids,
  REST.Table;

type
  TProjectTypeList = class(TBaseFormView)
    dbgridProjectType: TDBGrid;
    srcProjectType: TDataSource;
    pnlTop: TPanel;
    btnIncluir: TButton;
    pnlSearch: TPanel;
    pnlGrupSearch: TPanel;
    btnSearch: TButton;
    btnClear: TButton;
    gbxSearch: TGroupBox;
    popAction: TPopupMenu;
    btnRemove: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure dbgridProjectTypeCellClick(Column: TColumn);
    procedure btnRemoveClick(Sender: TObject);
  private
    Controller: TProjectTypeController;
  end;

implementation

{$R *.dfm}

{ TPasta }

procedure TProjectTypeList.FormCreate(Sender: TObject);
begin
  Controller := ProjectTypeController;
  srcProjectType.DataSet := Controller.tblProjectType;
end;

procedure TProjectTypeList.btnRemoveClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('Confirma a exclusão do registro?'), PWideChar('Confirmação'), MB_YESNO + MB_ICONQUESTION) <> mrOk then
    Exit;
  Controller.tblProjectType.Delete;
  Controller.ProjectType.Table.Write;
end;

procedure TProjectTypeList.btnIncluirClick(Sender: TObject);
begin
  TProjectTypeView.New(Self, Controller, rtaInsert);
end;

procedure TProjectTypeList.dbgridProjectTypeCellClick(Column: TColumn);
begin
  if not Column.Field.DataSet.IsEmpty then
    TProjectTypeView.New(Self, Controller, rtaEdit);
end;

procedure TProjectTypeList.btnSearchClick(Sender: TObject);
begin
  Controller.ProjectType.Query.Add('id', 1);
  Controller.ProjectType.Table.Read;
end;

end.
