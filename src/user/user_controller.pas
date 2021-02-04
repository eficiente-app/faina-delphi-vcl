// Eduardo - 03/02/2021
unit user_controller;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  REST.Manager,
  user_type_controller;

type
  TUserController = class(TDataModule)
    tblUser: TFDMemTable;
    tblUserid: TIntegerField;
    tblUsername: TStringField;
    tblUserperfil_id: TIntegerField;
    tblUserlogin: TStringField;
    tblUserpassword: TStringField;
    tblUsertype_id: TIntegerField;
    tblUsertype_name: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    User: TRESTManager;
  end;

var
  UserController: TUserController;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TUserController.DataModuleCreate(Sender: TObject);
begin
  User := TRESTManager.Create('api/user', tblUser);
end;

procedure TUserController.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(User);
end;

end.
