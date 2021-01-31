// Eduardo - 08/01/2021
unit task_type_view;

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
  task_type_controller,
  search_view,
  REST.Table;

type
  TTaskTypeView = class(TBaseFormView)
    dbedtid: TDBEdit;
    lbid: TLabel;
    pnlTop: TPanel;
    btnConfirm: TButton;
    lbdescription: TLabel;
    srcTaskType: TDataSource;
    dbedtdescription: TDBEdit;
    lbname: TLabel;
    dbedtname: TDBEdit;
    procedure btnConfirmClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Controller: TTaskTypeController;
  public
    class procedure New(AParent: TForm; ATTD: TTaskTypeController; rtbAction: TRESTTableAction);
  end;

implementation

{$R *.dfm}

class procedure TTaskTypeView.New(AParent: TForm; ATTD: TTaskTypeController; rtbAction: TRESTTableAction);
begin
  with TTaskTypeView.Create(AParent) do
  begin
    CloseEsc := True;

    Controller := ATTD;
    srcTaskType.DataSet := Controller.tblTaskType;

    Controller.TaskType.Table.State(rtbAction);

    ShowModal(AParent);
  end;
end;

procedure TTaskTypeView.btnConfirmClick(Sender: TObject);
begin
  if Controller.tblTaskType.State in dsEditModes then
    Controller.tblTaskType.Post;
  Controller.TaskType.Table.Write;
  Close;
end;

procedure TTaskTypeView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Controller.tblTaskType.State in dsEditModes then
    Controller.tblTaskType.Cancel;
end;

end.
