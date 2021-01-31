// Eduardo - 31/01/2021
unit task_status_view;

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
  task_status_controller,
  search_view,
  REST.Table;

type
  TTaskStatusView = class(TBaseFormView)
    dbedtid: TDBEdit;
    lbid: TLabel;
    pnlTop: TPanel;
    btnConfirm: TButton;
    lbdescription: TLabel;
    srcTaskStatus: TDataSource;
    dbedtdescription: TDBEdit;
    lbname: TLabel;
    dbedtname: TDBEdit;
    procedure btnConfirmClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Controller: TTaskStatusController;
  public
    class procedure New(AParent: TForm; ATTD: TTaskStatusController; rtbAction: TRESTTableAction);
  end;

implementation

{$R *.dfm}

class procedure TTaskStatusView.New(AParent: TForm; ATTD: TTaskStatusController; rtbAction: TRESTTableAction);
begin
  with TTaskStatusView.Create(AParent) do
  begin
    CloseEsc := True;

    Controller := ATTD;
    srcTaskStatus.DataSet := Controller.tblTaskStatus;

    Controller.TaskStatus.Table.State(rtbAction);

    ShowModal(AParent);
  end;
end;

procedure TTaskStatusView.btnConfirmClick(Sender: TObject);
begin
  if Controller.tblTaskStatus.State in dsEditModes then
    Controller.tblTaskStatus.Post;
  Controller.TaskStatus.Table.Write;
  Close;
end;

procedure TTaskStatusView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Controller.tblTaskStatus.State in dsEditModes then
    Controller.tblTaskStatus.Cancel;
end;

end.
