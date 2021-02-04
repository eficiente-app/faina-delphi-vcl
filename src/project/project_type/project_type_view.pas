// Eduardo - 03/02/2021
unit project_type_view;

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
  project_type_controller,
  search_view,
  REST.Table;

type
  TProjectTypeView = class(TBaseFormView)
    dbedtid: TDBEdit;
    lbid: TLabel;
    pnlTop: TPanel;
    btnConfirm: TButton;
    lbdescription: TLabel;
    srcProjectType: TDataSource;
    dbedtdescription: TDBEdit;
    lbname: TLabel;
    dbedtname: TDBEdit;
    procedure btnConfirmClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Controller: TProjectTypeController;
  public
    class procedure New(AParent: TForm; ATTD: TProjectTypeController; rtbAction: TRESTTableAction);
  end;

implementation

{$R *.dfm}

class procedure TProjectTypeView.New(AParent: TForm; ATTD: TProjectTypeController; rtbAction: TRESTTableAction);
begin
  with TProjectTypeView.Create(AParent) do
  begin
    CloseEsc := True;

    Controller := ATTD;
    srcProjectType.DataSet := Controller.tblProjectType;

    Controller.ProjectType.Table.State(rtbAction);

    ShowModal(AParent);
  end;
end;

procedure TProjectTypeView.btnConfirmClick(Sender: TObject);
begin
  if Controller.tblProjectType.State in dsEditModes then
    Controller.tblProjectType.Post;
  Controller.ProjectType.Table.Write;
  Close;
end;

procedure TProjectTypeView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Controller.tblProjectType.State in dsEditModes then
    Controller.tblProjectType.Cancel;
end;

end.
