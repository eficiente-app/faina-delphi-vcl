// Eduardo - 03/02/2021
unit user_list;

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
  user_controller,
  user_view,
  Extend.DBGrids,
  REST.Table;

type
  TUserList = class(TBaseFormView)
    dbgridUser: TDBGrid;
    srcUser: TDataSource;
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
    procedure dbgridUserCellClick(Column: TColumn);
    procedure btnRemoveClick(Sender: TObject);
  private
    Controller: TUserController;
  end;

implementation

{$R *.dfm}

{ TPasta }

procedure TUserList.FormCreate(Sender: TObject);
begin
  Controller := UserController;
  srcUser.DataSet := Controller.tblUser;
end;

procedure TUserList.btnRemoveClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('Confirma a exclusão do registro?'), PWideChar('Confirmação'), MB_YESNO + MB_ICONQUESTION) <> mrOk then
    Exit;
  Controller.tblUser.Delete;
  Controller.User.Table.Write;
end;

procedure TUserList.btnIncluirClick(Sender: TObject);
begin
  TUserView.New(Self, Controller, rtaInsert);
end;

procedure TUserList.dbgridUserCellClick(Column: TColumn);
begin
  if not Column.Field.DataSet.IsEmpty then
    TUserView.New(Self, Controller, rtaEdit);
end;

procedure TUserList.btnSearchClick(Sender: TObject);
begin
  Controller.User.Query.Add('id', 1);
  Controller.User.Table.Read;
end;

end.
