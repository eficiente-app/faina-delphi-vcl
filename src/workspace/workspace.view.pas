// Daniel Araujo - 19/01/2021
unit workspace.view;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  base_form_view,
  SVGIconImage;

type
  TWorkSpace = class(TBaseFormView)
    pnlTop: TPanel;
    pnlTitle: TPanel;
    lbMainTitle: TLabel;
    svgUserAvatar: TSVGIconImage;
    pnlLeft: TPanel;
    pnWorkSpace: TPanel;
    svgNotification: TSVGIconImage;
    svgAdd: TSVGIconImage;
    procedure svgUserAvatarClick(Sender: TObject);
    procedure svgAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  user_menu,
  task_view;
{$R *.dfm}

procedure TWorkSpace.svgAddClick(Sender: TObject);
begin
  TTaskView.Create(WorkSpace).ShowModal(WorkSpace);
end;

procedure TWorkSpace.svgUserAvatarClick(Sender: TObject);
begin
  TUserMenu.Show;
end;

end.
