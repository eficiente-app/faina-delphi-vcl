// Eduardo - 03/02/2021
unit user_type_controller;

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
  REST.Manager;

type
  TUserTypeController = class(TDataModule)
    tblUserType: TFDMemTable;
    tblUserTypeid: TIntegerField;
    tblUserTypedescription: TStringField;
    tblUserTypename: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    UserType: TRESTManager;
  end;

var
  UserTypeController: TUserTypeController;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TUserTypeController.DataModuleCreate(Sender: TObject);
begin
  UserType := TRESTManager.Create('api/user/type', tblUserType);
  UserType.Table.Read;
end;

procedure TUserTypeController.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(UserType);
end;

end.
