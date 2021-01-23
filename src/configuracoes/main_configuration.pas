// Daniel Araujo - 17/01/2021
unit main_configuration;

interface

uses
  Winapi.Messages,
  Winapi.Windows,
  System.Classes,
  System.SysUtils,
  System.Variants,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  base_form_view, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters, dxNavBarCollns,
  cxClasses, dxNavBarBase, dxNavBar, Vcl.StdCtrls;

type
  TMainConfiguration = class(TBaseFormView)
    pnlLateralEsquerda: TPanel;
    nbMenu: TdxNavBar;
    nbgCadastros: TdxNavBarGroup;
    nbgSitema: TdxNavBarGroup;
    nbiPastas: TdxNavBarItem;
    nbiTipoPasta: TdxNavBarItem;
    nbiTipoTarefa: TdxNavBarItem;
    pnlAreaTrabalho: TPanel;
    lblSubTitle: TLabel;
    procedure nbiPastasClick(Sender: TObject);
    procedure nbiTipoPastaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure nbiTipoTarefaClick(Sender: TObject);
  private
    { Private declarations }
    FActiveForm: TBaseFormView;
    procedure OpenForm(FormClass: TFormClass);
    procedure CloseForm;
    procedure UpdateSubtitle;
  public
    { Public declarations }
  end;

var
  MainConfiguration: TMainConfiguration;

implementation

uses
  folder_list,
  folder_type_list,
  task_type_list;

{$R *.dfm}

{ TConfiguracoesPrincipal }

procedure TMainConfiguration.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseForm;
end;

procedure TMainConfiguration.OpenForm(FormClass: TFormClass);
begin
  CloseForm;
  FActiveForm := TBaseFormView(FormClass.Create(Self));
  FActiveForm.ShowIn(pnlAreaTrabalho, alClient);
  UpdateSubtitle;
end;

procedure TMainConfiguration.UpdateSubtitle;
begin
  lblSubTitle.Visible := Assigned(FActiveForm);
  if Assigned(FActiveForm) then
    lblSubTitle.Caption := '-> '+ FActiveForm.Caption;
end;

procedure TMainConfiguration.CloseForm;
begin
  if not Assigned(FActiveForm) then
    Exit;

  FActiveForm.Close;
end;

procedure TMainConfiguration.nbiPastasClick(Sender: TObject);
begin
  OpenForm(TFolderList);
end;

procedure TMainConfiguration.nbiTipoPastaClick(Sender: TObject);
begin
  OpenForm(TFolderTypeList);
end;

procedure TMainConfiguration.nbiTipoTarefaClick(Sender: TObject);
begin
  OpenForm(TTaskTypeList);
end;

end.
