// Eduardo - 31/01/2021
unit task_label_view;

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
  task_label_controller,
  task_type_controller,
  search_view,
  REST.Table;

type
  TTaskLabelView = class(TBaseFormView)
    dbedtid: TDBEdit;
    lbid: TLabel;
    pnlTop: TPanel;
    btnConfirm: TButton;
    lbdescription: TLabel;
    srcTaskLabel: TDataSource;
    dbedtdescription: TDBEdit;
    lbname: TLabel;
    dbedtname: TDBEdit;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    sbttipo_id: TSpeedButton;
    lbtask_type_name: TLabel;
    dbedttask_type_name: TDBEdit;
    procedure btnConfirmClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbttipo_idClick(Sender: TObject);
  private
    Controller: TTaskLabelController;
  public
    class procedure New(AParent: TForm; ATTD: TTaskLabelController; rtbAction: TRESTTableAction);
  end;

implementation

{$R *.dfm}

class procedure TTaskLabelView.New(AParent: TForm; ATTD: TTaskLabelController; rtbAction: TRESTTableAction);
begin
  with TTaskLabelView.Create(AParent) do
  begin
    CloseEsc := True;

    Controller := ATTD;
    srcTaskLabel.DataSet := Controller.tblTaskLabel;

    Controller.TaskLabel.Table.State(rtbAction);

    ShowModal(AParent);
  end;
end;

procedure TTaskLabelView.sbttipo_idClick(Sender: TObject);
begin
  TSearchView.New(
    TForm(Self.Parent),
    TaskTypeController.tblTaskType.FieldByName('id'),
    TaskLabelController.tblTaskLabel.FieldByName('tipo_id')
  );
end;

procedure TTaskLabelView.btnConfirmClick(Sender: TObject);
begin
  if Controller.tblTaskLabel.State in dsEditModes then
    Controller.tblTaskLabel.Post;
  Controller.TaskLabel.Table.Write;
  Close;
end;

procedure TTaskLabelView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Controller.tblTaskLabel.State in dsEditModes then
    Controller.tblTaskLabel.Cancel;
end;

end.
