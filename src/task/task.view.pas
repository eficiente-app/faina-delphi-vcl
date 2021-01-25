unit task.view;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_form_view, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, dxCore, dxCoreClasses, cxGraphics,
  dxGDIPlusAPI, dxGDIPlusClasses, dxRichEdit.NativeApi, dxRichEdit.Types,
  dxRichEdit.Options, dxRichEdit.Control, dxRichEdit.Control.SpellChecker,
  dxRichEdit.Dialogs.EventArgs, dxBarBuiltInMenu, cxControls,
  dxRichEdit.Platform.Win.Control, dxRichEdit.Control.Core;

type
  TTaskView = class(TBaseFormView)
    dbedtName: TDBEdit;
    pnlLateralDireita: TPanel;
    bvlSeparadorDireita: TBevel;
    pnlTopOptions: TPanel;
    pnlClient: TPanel;
    dxRichEditControl1: TdxRichEditControl;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TaskView: TTaskView;

implementation

{$R *.dfm}

end.
