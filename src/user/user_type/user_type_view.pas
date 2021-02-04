// Eduardo - 03/02/2021
unit user_type_view;

interface

uses
  Winapi.Messages,
  Winapi.Windows,
  System.Classes,
  System.SysUtils,
  System.Variants,
  Data.DB,
  Vcl.Buttons,
  Vcl.Controls,
  Vcl.DBCtrls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.ImgList,
  Vcl.Mask,
  Vcl.StdCtrls,
  base_form_view,
  user_type_controller,
  search_view,
  REST.Table;

type
  TUserTypeView = class(TBaseFormView)
    dbedtid: TDBEdit;
    lbid: TLabel;
    pnlTop: TPanel;
    btnConfirm: TButton;
    lbdescription: TLabel;
    srcUserType: TDataSource;
    dbedtdescription: TDBEdit;
    lbname: TLabel;
    dbedtname: TDBEdit;
    procedure btnConfirmClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Controller: TUserTypeController;
  public
    class procedure New(AParent: TForm; ATTD: TUserTypeController; rtbAction: TRESTTableAction);
  end;

implementation

{$R *.dfm}

class procedure TUserTypeView.New(AParent: TForm; ATTD: TUserTypeController; rtbAction: TRESTTableAction);
begin
  with TUserTypeView.Create(AParent) do
  begin
    CloseEsc := True;

    Controller := ATTD;
    srcUserType.DataSet := Controller.tblUserType;

    Controller.UserType.Table.State(rtbAction);

    ShowModal(AParent);
  end;
end;

procedure TUserTypeView.btnConfirmClick(Sender: TObject);
begin
  if Controller.tblUserType.State in dsEditModes then
    Controller.tblUserType.Post;
  Controller.UserType.Table.Write;
  Close;
end;

procedure TUserTypeView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Controller.tblUserType.State in dsEditModes then
    Controller.tblUserType.Cancel;
end;

end.
