// Eduardo - 03/02/2021
unit task_schedule_type_view;

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
  task_schedule_type_controller,
  search_view,
  REST.Table;

type
  TTaskScheduleTypeView = class(TBaseFormView)
    dbedtid: TDBEdit;
    lbid: TLabel;
    pnlTop: TPanel;
    btnConfirm: TButton;
    lbdescription: TLabel;
    srcTaskScheduleType: TDataSource;
    dbedtdescription: TDBEdit;
    lbname: TLabel;
    dbedtname: TDBEdit;
    procedure btnConfirmClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Controller: TTaskScheduleTypeController;
  public
    class procedure New(AParent: TForm; ATTD: TTaskScheduleTypeController; rtbAction: TRESTTableAction);
  end;

implementation

{$R *.dfm}

class procedure TTaskScheduleTypeView.New(AParent: TForm; ATTD: TTaskScheduleTypeController; rtbAction: TRESTTableAction);
begin
  with TTaskScheduleTypeView.Create(AParent) do
  begin
    CloseEsc := True;

    Controller := ATTD;
    srcTaskScheduleType.DataSet := Controller.tblTaskScheduleType;

    Controller.TaskScheduleType.Table.State(rtbAction);

    ShowModal(AParent);
  end;
end;

procedure TTaskScheduleTypeView.btnConfirmClick(Sender: TObject);
begin
  if Controller.tblTaskScheduleType.State in dsEditModes then
    Controller.tblTaskScheduleType.Post;
  Controller.TaskScheduleType.Table.Write;
  Close;
end;

procedure TTaskScheduleTypeView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Controller.tblTaskScheduleType.State in dsEditModes then
    Controller.tblTaskScheduleType.Cancel;
end;

end.
