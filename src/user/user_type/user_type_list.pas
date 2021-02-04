// Eduardo - 03/02/2021
unit user_type_list;

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
  user_type_controller,
  user_type_view,
  Extend.DBGrids,
  REST.Table;

type
  TUserTypeList = class(TBaseFormView)
    dbgridUserType: TDBGrid;
    srcUserType: TDataSource;
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
    procedure dbgridUserTypeCellClick(Column: TColumn);
    procedure btnRemoveClick(Sender: TObject);
  private
    Controller: TUserTypeController;
  end;

implementation

{$R *.dfm}

{ TPasta }

procedure TUserTypeList.FormCreate(Sender: TObject);
begin
  Controller := UserTypeController;
  srcUserType.DataSet := Controller.tblUserType;
end;

procedure TUserTypeList.btnRemoveClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('Confirma a exclusão do registro?'), PWideChar('Confirmação'), MB_YESNO + MB_ICONQUESTION) <> mrOk then
    Exit;
  Controller.tblUserType.Delete;
  Controller.UserType.Table.Write;
end;

procedure TUserTypeList.btnIncluirClick(Sender: TObject);
begin
  TUserTypeView.New(Self, Controller, rtaInsert);
end;

procedure TUserTypeList.dbgridUserTypeCellClick(Column: TColumn);
begin
  if not Column.Field.DataSet.IsEmpty then
    TUserTypeView.New(Self, Controller, rtaEdit);
end;

procedure TUserTypeList.btnSearchClick(Sender: TObject);
begin
  Controller.UserType.Query.Add('id', 1);
  Controller.UserType.Table.Read;
end;

end.
