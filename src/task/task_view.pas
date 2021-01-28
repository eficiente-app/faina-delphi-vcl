unit task_view;

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.DBCtrls,
  Vcl.ExtCtrls,
  Vcl.Mask,
  Vcl.StdCtrls,
  base_form_view, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxTextEdit, cxDBEdit,
  cxMaskEdit, cxDropDownEdit, cxEditRepositoryItems, cxClasses;

type
  TTaskView = class(TBaseFormView)
    pnlLateralDireita: TPanel;
    bvlSeparadorDireita: TBevel;
    pnlClient: TPanel;
    cxDBTextEdit1: TcxDBTextEdit;
    pnlStatusColor: TPanel;
    pnlTopOptions: TPanel;
    cxComboBox1: TcxComboBox;
    cxEditRepository1: TcxEditRepository;
    cxEditRepository1TextItem1: TcxEditRepositoryTextItem;
    cxEditRepository1TextItem2: TcxEditRepositoryTextItem;
    cxEditRepository1MaskItem1: TcxEditRepositoryMaskItem;
    cxEditRepository1ComboBoxItem1: TcxEditRepositoryComboBoxItem;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TaskView: TTaskView;

implementation

{$R *.dfm}

procedure TTaskView.FormCreate(Sender: TObject);
begin
  inherited;
  cxComboBox1.RepositoryItem := cxEditRepository1ComboBoxItem1;
end;

end.
