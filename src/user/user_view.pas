// Eduardo - 03/02/2021
unit user_view;

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
  user_controller,
  search_view,
  REST.Table;

type
  TUserView = class(TBaseFormView)
    dbedtid: TDBEdit;
    lbid: TLabel;
    pnlTop: TPanel;
    btnConfirm: TButton;
    srcUser: TDataSource;
    lbname: TLabel;
    dbedtname: TDBEdit;
    procedure btnConfirmClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Controller: TUserController;
  public
    class procedure New(AParent: TForm; ATTD: TUserController; rtbAction: TRESTTableAction);
  end;

implementation

{$R *.dfm}

class procedure TUserView.New(AParent: TForm; ATTD: TUserController; rtbAction: TRESTTableAction);
begin
  with TUserView.Create(AParent) do
  begin
    CloseEsc := True;

    Controller := ATTD;
    srcUser.DataSet := Controller.tblUser;

    Controller.User.Table.State(rtbAction);

    ShowModal(AParent);
  end;
end;

procedure TUserView.btnConfirmClick(Sender: TObject);
begin
  if Controller.tblUser.State in dsEditModes then
    Controller.tblUser.Post;
  Controller.User.Table.Write;
  Close;
end;

procedure TUserView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Controller.tblUser.State in dsEditModes then
    Controller.tblUser.Cancel;
end;

end.
